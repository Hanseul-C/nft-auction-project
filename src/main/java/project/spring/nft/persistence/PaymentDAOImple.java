package project.spring.nft.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.spring.nft.domain.PaymentVO;

@Repository
public class PaymentDAOImple implements PaymentDAO {
	private static final Logger logger =
			LoggerFactory.getLogger(PaymentDAOImple.class);
	
	private static final String NAMESPACE = "project.spring.nft.PaymentMapper";

	@Autowired
	private SqlSession sqlsession;
	
	@Override
	public int insertPayment(PaymentVO vo) {
		logger.info("insertPayment() 호출");
		return sqlsession.insert(NAMESPACE + ".insert", vo);
	}

	@Override
	public List<PaymentVO> selectByMemberId(String memberId) {
		logger.info("selectByMemberId() 호출");
		return sqlsession.selectOne(NAMESPACE + ".select_by_member_id", memberId);
	}

	@Override
	public PaymentVO selectByArtNo(int artNo) {
		logger.info("selectByArtNo() 호출");
		return sqlsession.selectOne(NAMESPACE + ".select_by_art_no", artNo);
	}
	
	@Override
	public List<PaymentVO> selectAll(String memberId) {
		logger.info("selectAll() 호출 : memberId = "+memberId);
		return sqlsession.selectList(NAMESPACE+".select_all_by_id", memberId);
	}
	
	@Override
	public int selectProfit(String memberId) {
		logger.info("selectProfit() 호출");
		return sqlsession.selectOne(NAMESPACE+".select_profit", memberId);
	} //end selectProfit()
}
