package project.spring.nft.persistence;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.spring.nft.domain.RefundVO;

@Repository
public class RefundDAOImple implements RefundDAO {
	private static final Logger logger=
			LoggerFactory.getLogger(RefundDAOImple.class);
	private static final String NAMESPACE = "project.spring.nft.RefundMapper";
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int insert(RefundVO vo) {
		logger.info("insert() 호출 : vo = "+vo.toString());
		return sqlSession.insert(NAMESPACE+".insert", vo);
	}
	
	@Override
	public Integer select(String memberId) {
		logger.info("select() 호출 : memberId = "+memberId);
		return sqlSession.selectOne(NAMESPACE+".select", memberId);
	}
}
