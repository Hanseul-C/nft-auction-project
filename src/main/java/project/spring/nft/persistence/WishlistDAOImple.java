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
import project.spring.nft.domain.WishlistVO;

@Repository
public class WishlistDAOImple implements WishlistDAO {
	private static final Logger logger =
			LoggerFactory.getLogger(WishlistDAOImple.class);
	private static final String NAMESPACE =
			"project.spring.nft.WishlistMapper";

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int insertWishlist(WishlistVO vo) {
		logger.info("insert() 호출");
		System.out.println(vo);
		return sqlSession.insert(NAMESPACE + ".insert", vo);
	}

	@Override
	public List<WishlistVO> selectWishlist(String memberId) {
		logger.info("select() 호출");
		return sqlSession.selectList(NAMESPACE + ".select_all", memberId);
	}

	@Override
	public int deleteWishlist(String memberId, String artName) {
		logger.info("delete() 호출 : memberId : " + memberId);
		Map<String, String> countMap=new HashMap<String, String>();
		countMap.put("memberId", memberId);
		countMap.put("artName", artName);
		return sqlSession.delete(NAMESPACE + ".delete", countMap);
	}

	@Override
	public int selectCount(String memberId, String artName) {
		logger.info("selectCount() 호출 : memberid = " + memberId);
		Map<String, String> countMap=new HashMap<String, String>();
		countMap.put("memberId", memberId);
		countMap.put("artName", artName);
		return sqlSession.selectOne(NAMESPACE + ".select_count", countMap);
	}

	@Override
	public int updateArt(ArtVO vo) {
		logger.info("updateArt() 호출");
		return sqlSession.update(NAMESPACE+".update_art", vo);
	}
	
	@Override
	public int deleteArt(int artNo) {
		logger.info("deleteArt() 호출");
		return sqlSession.delete(NAMESPACE+".delete_art", artNo);
	}
} // end WishlistDAOImple class
