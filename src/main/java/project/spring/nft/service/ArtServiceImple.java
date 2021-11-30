package project.spring.nft.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import project.spring.nft.domain.ArtVO;
import project.spring.nft.domain.PaymentVO;
import project.spring.nft.pageutil.PageCriteria;
import project.spring.nft.persistence.ArtDAO;
import project.spring.nft.persistence.ArtReplyDAO;
import project.spring.nft.persistence.AuctionDAO;
import project.spring.nft.persistence.PaymentDAO;
import project.spring.nft.persistence.WishlistDAO;

@Service
public class ArtServiceImple implements ArtService {
	private static final Logger logger=
			LoggerFactory.getLogger(ArtServiceImple.class);
	
	@Autowired
	private ArtDAO artDAO;
	@Autowired
	private AuctionDAO auctionDAO;
	@Autowired
	private ArtReplyDAO artReplyDAO;
	@Autowired
	private WishlistDAO wishlistDAO;
	@Autowired
	private PaymentDAO paymentDAO;
	
	@Override
	public int createArt(ArtVO vo) {
		logger.info("createArt 호출 : vo = "+vo.toString());
		return artDAO.insertArt(vo);
	}
	
	@Override
	public int updateNickname(String memberId) {
		logger.info("updateNickname() 호출 : memberId = "+memberId);
		return artDAO.updateNickName(memberId);
	}

	@Override
	public List<ArtVO> readCurrentArt(PageCriteria criteria) {
		logger.info("readCurrentArt() 호출");
		return artDAO.selectCurrentArt(criteria);
	}

	@Override
	public List<ArtVO> readWishArt(PageCriteria criteria) {
		logger.info("readWishArt() 호출");
		return artDAO.selectWishArt(criteria);
	}

	@Override
	public List<ArtVO> readViewArt(PageCriteria criteria) {
		logger.info("readViewArt() 호출");
		return artDAO.selectViewArt(criteria);
	}
	
	@Override
	public int getTotalNumsOfRecords() {
		logger.info("getTotalNumsOfRecords() 호출");
		return artDAO.getTotalNumsOfRecords();
	}
	
	@Override
	public int getArtNameNumsOfRecords(String keyword) {
		logger.info("getArtNameNumsOfRecords() 호출");
		return artDAO.getArtNameNumsOfRecords(keyword);
	}
	
	@Override
	public int getNicknameNumsOfRecords(String keyword) {
		logger.info("getNicknameNumsOfRecords() 호출");
		return artDAO.getNicknameNumsOfRecords(keyword);
	}

	@Override
	public List<ArtVO> readArtName(PageCriteria criteria, String keyword) {
		logger.info("readArtName() 호출 : keyword = "+keyword+", criteria = "+criteria);
		return artDAO.selectArtName(criteria, keyword);
	}

	@Override
	public List<ArtVO> readMemberNickname(PageCriteria criteria, String keyword) {
		logger.info("readMemberNickname() : keyword = "+keyword);
		return artDAO.selectMemberNickname(criteria, keyword);
	}
	
	@Override
	public Map<String, Object> readArtNo(int artNo) {
		logger.info("readArtNo() 호출");
		Map<String, Object> readMap=new HashMap<String, Object>();
		ArtVO vo=artDAO.selectArtNo(artNo);
		logger.info("ArtVO 조회");
		readMap.put("vo", vo);

		int maxMoney = 0;
		try {
			maxMoney=auctionDAO.selectMaxBid(artNo);
			logger.info("maxMoney 조회");			
			readMap.put("maxMoney", maxMoney);
		} catch (NullPointerException e) {
			logger.info(artNo+"의 auction 값 없음");
		}
		return readMap;
	}
	
	@Override
	public int updateView(int artNo, int count) {
		logger.info("updateView() 호출 : artNo = "+artNo+", count = "+count);
		return artDAO.updateView(artNo, count);
	}

	@Override
	public List<ArtVO> readByMemberId(PageCriteria criteria, String memberId) {
		logger.info("readByMemberId() 호출 : memberId = " + memberId);
		return artDAO.selectMemberId(criteria, memberId);
	}

	@Override
	public int updateWishCount(int artNo, int count) {
		logger.info("updateWishCount() 호출 : artNo = "+artNo+", count = "+count);
		return artDAO.updateWishCount(artNo, count);
	}

	@Transactional
	@Override
	public int updateArt(ArtVO vo) {
		logger.info("updateArt() 호출 : vo = "+vo.toString());
		//TODO art수정하면 다른 테이블에 있는 art정보도 업데이트해야함
		//art정보를 저장하고있는 테이블 : wishlist
		int result=artDAO.updateArt(vo);
		logger.info("작품 수정 성공");
		wishlistDAO.updateArt(vo);
		logger.info("위시리스트 작품 정보 수정 성공");
		return result;
	}
	

	//작품 삭제 시 작품에 달린 댓글, 경매기록, 찜도 전부 지워져야함
	//TODO 만약 누군가 구매했다면 작품삭제 불가능(구매기능 만들고 업데이트)
	@Transactional
	@Override
	public int deleteArt(int artNo) throws Exception{
		logger.info("deleteArt() 호출");
		int result=0;
		if(paymentDAO.selectByArtNo(artNo) == null) {
			result=artDAO.deleteArt(artNo);
			logger.info("작품 삭제 성공");
			
			artReplyDAO.deleteArtNo(artNo); //작품의 댓글들 삭제
			logger.info("작품의 댓글 삭제 성공");
			//작품의 경매내역 삭제
			auctionDAO.deleteArtNo(artNo);
			logger.info("작품의 경매내역 삭제 성공");
			//작품의 위시리스트 삭제
			wishlistDAO.deleteArt(artNo);
			logger.info("작품의 찜내역 삭제 성공");
		}else { //해당 작품의 결제내역이 존재함
			logger.info("결제된 작품은 삭제 불가능");
		}
		return result;
	}	
	
	@Override
	public List<ArtVO> readWinBid(String memberId) {
		logger.info("readWinBid() 호출");
		List<ArtVO> alist=artDAO.selectWinBid(memberId);
		List<PaymentVO> plist=paymentDAO.selectAll(memberId);
		
		//낙찰된 작품번호랑 일치하는 구매된 작품번호가 있으면 해당 vo는 빼고 list에 넣기
		for(int i=0;i<plist.size();i++) { //3, 4
			for(int j=0;j<alist.size();j++) { //2, 3, 5, 7
				if(plist.get(i).getArtNo() == alist.get(j).getArtNo()) {
					//일치하는 artNo가 없음
					alist.remove(alist.get(j));
				}
			}
		}
		
		for (ArtVO vo : alist) {
			System.out.println("alist = "+vo.toString());
		}
		
		return alist;
	}

	@Override
	public ArtVO readArtno(int artNo) {
		logger.info("readArtNo() 호출");
		return artDAO.selectArtNo(artNo);
	}
<<<<<<< HEAD

	@Override
	public List<ArtVO> readNotAuction() {
		logger.info("readNotAuction() 호출");
		return artDAO.selectNotAuction();
	}


=======
	
	@Override
	public PaymentVO readPayResult(int artNo) {
		logger.info("readPayResult() 호출");
		return paymentDAO.selectByArtNo(artNo);
	}
	
	@Override
	public int getTotalMyArt(String memberId) {
		logger.info("getTotalMyArt() 호출");
		return artDAO.getTotalMyArt(memberId);
	}
	
>>>>>>> origin/develop-yed
}
