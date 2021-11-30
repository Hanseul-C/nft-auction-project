package project.spring.nft;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import project.spring.nft.domain.ArtVO;
import project.spring.nft.domain.WishlistVO;
import project.spring.nft.pageutil.PageCriteria;
import project.spring.nft.persistence.ArtDAO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/**/*.xml"}) 
@WebAppConfiguration
public class ArtDAOTest {
	private static final Logger logger=
			LoggerFactory.getLogger(ArtDAOTest.class);
	
	@Autowired
	private ArtDAO dao;
	
	@Test
	public void testDAO() {
		//testInsert();
		//testSearch();
		//testSearch2();
		//testSelect();
//		testSearch();
		//getNums();
		//testSelectbyMemberId();
	}

	/*
	 * private void testSelectbyMemberId() { String memberId = "test"; List<ArtVO>
	 * list = dao.selectMemberId(memberId); for (ArtVO vo : list) {
	 * logger.info(vo.toString()); }
	 * 
	 * }
	 */

//	private void testSearch() {
//		PageCriteria criteria = new PageCriteria(1,3);
//		
//		List<ArtVO> list=dao.selectArtName(criteria, "작가");
//		for (ArtVO vo : list) {
//			System.out.println(vo.toString());
//		}
//	}
	

	private void testSearch() {
		PageCriteria criteria = new PageCriteria(1,3);
		
		List<ArtVO> list=dao.selectArtName(criteria, "작가");
		for (ArtVO vo : list) {
			System.out.println(vo.toString());
		}
	}
	
//	private void getNums() {
//		int result = dao.getArtNameNumsOfRecords();
//		logger.info(result + "");
//	}

//	private void testSelect() {
//		List<ArtVO> list=dao.selectCurrentArt();
//		for (ArtVO vo : list) {
//			System.out.println(vo.toString());
//		}
//	}

//	private void testSearch2() {
//		List<ArtVO> list=dao.selectMemberNickname("관리");
//		for (ArtVO vo : list) {
//			System.out.println(vo.toString());
//		}
//	}
//
//	private void testSearch() {
//		List<ArtVO> list=dao.selectArtName("테스");
//		for (ArtVO vo : list) {
//			System.out.println(vo.toString());
//		}
//	}

//	private void testInsert() {
//		ArtVO vo=new ArtVO(0, "test", "제발요요", 10000, "테스트중", null, 0, 0, 0, "s_ssssss.png", "");
//		int result=dao.insertArt(vo);
//		if(result==1) {
//			logger.info("insert 성공");
//			int update=dao.updateNickName(vo.getMemberId());
//			logger.info(update+"개 nickname 변경. art 등록 최종완료");
//		}else {
//			logger.info("insert 실패");
//		}
//	}
} // end class
