package project.spring.nft.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.spring.nft.domain.AuctionVO;
import project.spring.nft.domain.PaymentVO;
import project.spring.nft.persistence.AuctionDAO;
import project.spring.nft.persistence.PaymentDAO;

@Service
public class PaymentServiceImple implements PaymentService {

	private static final Logger logger =
			LoggerFactory.getLogger(PaymentServiceImple.class);
	
	@Autowired
	private PaymentDAO paymentDAO;
	@Autowired
	private AuctionDAO auctionDAO;
	
	@Override
	public int insertPayment(PaymentVO vo) {
		logger.info("insertPayment() 호출");
		return paymentDAO.insertPayment(vo);
	}

	@Override
	public List<PaymentVO> selectByMemberId(String memberId) {
		logger.info("selectByMemberId() 호출");
		return paymentDAO.selectByMemberId(memberId);
	}

	@Override
	public PaymentVO selectByArtNo(int artNo) {
		logger.info("selectByArtNi() 호출");
		return paymentDAO.selectByArtNo(artNo);
	}
	
	@Override
	public AuctionVO readArtNo(int artNo) {
		logger.info("readArtNo() 호출");
		return auctionDAO.selectWinner(artNo);
	}
}
