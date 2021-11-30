package project.spring.nft.persistence;

import java.util.List;

import project.spring.nft.domain.PaymentVO;

// 결제 관련
public interface PaymentDAO {
 
	int insertPayment(PaymentVO vo);
	
	List<PaymentVO> selectByMemberId(String memberId);
	
	PaymentVO selectByArtNo(int artNo);
	
	//사용자 구매목록
	List<PaymentVO> selectAll(String memberId);
	
	//판매수익
	int selectProfit(String memberId);
}
