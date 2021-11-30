package project.spring.nft.persistence;

import project.spring.nft.domain.RefundVO;

public interface RefundDAO {
	//환급 정보
	int insert(RefundVO vo);
	//정산액 조회
	Integer select(String memberId);
}
