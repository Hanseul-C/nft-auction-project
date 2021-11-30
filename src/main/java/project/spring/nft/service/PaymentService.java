package project.spring.nft.service;

import java.util.List;

import project.spring.nft.domain.AuctionVO;
import project.spring.nft.domain.PaymentVO;

public interface PaymentService {
	
	int insertPayment(PaymentVO vo);
	
	List<PaymentVO> selectByMemberId(String memberId);
	
	PaymentVO selectByArtNo(int artNo);
	
	//경매 낙찰 시 낙찰 정보 제공
	AuctionVO readArtNo(int artNo);
}
