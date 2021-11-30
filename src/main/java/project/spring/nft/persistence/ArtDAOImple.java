package project.spring.nft.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.spring.nft.domain.ArtVO;
import project.spring.nft.pageutil.PageCriteria;

@Repository
public class ArtDAOImple implements ArtDAO {
	private static Logger logger=
			LoggerFactory.getLogger(ArtDAOImple.class);
	private static final String NAMESPACE="project.spring.nft.ArtMapper";
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int insertArt(ArtVO vo) {
		//회원번호, 작품명, 즉납가, 작품설명, 이미지파일이름(썸네일) 등록하기
		//TODO nft관련 정보등록은 추후 추가
		logger.info("insertArt() 호출");
		return sqlSession.insert(NAMESPACE+".insert", vo);
	}
	
	@Override
	public int updateNickName(String memberId) {
		logger.info("updateNickName() 호출 : memberId = "+memberId);
		return sqlSession.update(NAMESPACE+".update_nickname", memberId);
	}
	
	@Override
	public List<ArtVO> selectCurrentArt(PageCriteria criteria) {
		logger.info("selectCurrentArt() 호출 : criteria = "+criteria);
		return sqlSession.selectList(NAMESPACE+".select_all_by_no", criteria);
	}

	@Override
	public List<ArtVO> selectWishArt(PageCriteria criteria) {
		logger.info("selectWishArt() 호출 : criteria = "+criteria);
		return sqlSession.selectList(NAMESPACE+".select_all_by_wish", criteria);
	}

	@Override
	public List<ArtVO> selectViewArt(PageCriteria criteria) {
		logger.info("selectViewArt() 호출 : criteria = "+ criteria);
		return sqlSession.selectList(NAMESPACE+".select_all_by_view", criteria);
	}
	
	@Override
	public int getTotalNumsOfRecords() {
		logger.info("getTotalNumsOfRecords() 호출");
		return sqlSession.selectOne(NAMESPACE+".select_total_cnt");
	}
	
	@Override
	public int getArtNameNumsOfRecords(String keyword) {
		logger.info("getArtNameNumsOfRecords() 호출");
		keyword="%"+keyword+"%";
		return sqlSession.selectOne(NAMESPACE+".select_art_name_cnt", keyword);
	}
	
	@Override
	public int getNicknameNumsOfRecords(String keyword) {
		logger.info("getNicknameNumsOfRecords() 호출");
		keyword="%"+keyword+"%";
		return sqlSession.selectOne(NAMESPACE+".select_nickname_cnt", keyword);
	}

	@Override
	public List<ArtVO> selectArtName(PageCriteria criteria, String keyword) {
		logger.info("selectArtName() 호출 : keyword = "+keyword+", criteria = "+ criteria);
		keyword="%"+keyword+"%";
		Map<String, Object> searchMap=new HashMap<String, Object>();
		searchMap.put("start", criteria.getStart());
		searchMap.put("end", criteria.getEnd());
		searchMap.put("keyword", keyword);
		logger.info(criteria.getStart()+"");
		return sqlSession.selectList(NAMESPACE+".select_by_art_name", searchMap);
	}

	@Override
	public List<ArtVO> selectMemberNickname(PageCriteria criteria, String keyword) {
		logger.info("selectMemberNickname() 호출");
		keyword="%"+keyword+"%";
		Map<String, Object> searchMap=new HashMap<String, Object>();
		searchMap.put("start", criteria.getStart());
		searchMap.put("end", criteria.getEnd());
		searchMap.put("keyword", keyword);
		return sqlSession.selectList(NAMESPACE+".select_by_member_nickname", searchMap);
	}
	
	@Override
	public ArtVO selectArtNo(int artNo) {
		logger.info("selectArtNo() 호출");
		return sqlSession.selectOne(NAMESPACE+".select_by_art_no", artNo);
	}
	
	@Override
	public int updateView(int artNo, int count) {
		logger.info("updateView() 호출 : artNo = "+artNo+", count = "+count);
		Map<String, Integer> countMap=new HashMap<String, Integer>();
		countMap.put("artNo", artNo);
		countMap.put("count", count);
		return sqlSession.update(NAMESPACE+".update_view", countMap);
	} //end updateView()

	@Override
	public List<ArtVO> selectMemberId(PageCriteria criteria, String memberId) {
		logger.info("select() 호출");
		Map<String, Object> artMap=new HashMap<String, Object>();
		artMap.put("start", criteria.getStart());
		artMap.put("end", criteria.getEnd());
		artMap.put("memberId", memberId);
		return sqlSession.selectList(NAMESPACE + ".select_my_art", artMap);
	}

	@Override
	public int updateWishCount(int artNo, int count) {
		logger.info("updateWishCount() 호출 : artNo = "+artNo+", count = "+count);
		Map<String, Integer> countMap=new HashMap<String, Integer>();
		countMap.put("artNo", artNo);
		countMap.put("count", count);
		return sqlSession.update(NAMESPACE+".update_wish_count", countMap);
	}

	
	@Override
	public int updateReplyCount(int amount, int artNo) {
		logger.info("updateReplyCount 호출 : amount = "+amount+", artNo = "+artNo);
		Map<String, Integer> args = new HashMap<String, Integer>();
		args.put("amount", amount);
		args.put("artNo", artNo);
		return sqlSession.update(NAMESPACE + ".update_reply_count", args);
	}
	
	@Override
	public int updateArt(ArtVO vo) {
		logger.info("updateArt() 호출 : vo = "+vo.toString());
		return sqlSession.update(NAMESPACE+".update_art", vo);
	}
	
	@Override
	public int deleteArt(int artNo) {
		logger.info("deleteArt() 호출 : artNo = "+artNo);
		return sqlSession.delete(NAMESPACE+".delete_art", artNo);
	}
	
	@Override
	public List<ArtVO> selectWinBid(String memberId) {
		logger.info("selectWinBid() 호출 : memberId = "+memberId);
		return sqlSession.selectList(NAMESPACE+".select_win_list", memberId);
	}
<<<<<<< HEAD

	@Override
	public List<ArtVO> selectNotAuction() {
		logger.info("selectNotAuction() 호출");
		return sqlSession.selectList(NAMESPACE + ".select_not_auction");
	}

=======
	
	@Override
	public int getTotalMyArt(String memberId) {
		logger.info("getTotalMyArt() 호출");
		return sqlSession.selectOne(NAMESPACE+".select_my_art_count", memberId); 
	} 
>>>>>>> origin/develop-yed
}
