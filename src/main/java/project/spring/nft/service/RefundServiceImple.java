package project.spring.nft.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.spring.nft.domain.RefundVO;
import project.spring.nft.persistence.RefundDAO;

@Service
public class RefundServiceImple implements RefundService {
	private static final Logger logger=
			LoggerFactory.getLogger(RefundServiceImple.class);
	
	@Autowired
	private RefundDAO dao;
	
	@Override
	public int create(RefundVO vo) {
		logger.info("insert() 호출");
		return dao.insert(vo);
	}

}
