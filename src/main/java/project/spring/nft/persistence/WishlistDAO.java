package project.spring.nft.persistence;

import java.util.List;

import project.spring.nft.domain.ArtVO;
import project.spring.nft.domain.WishlistVO;

public interface WishlistDAO {
	// 위시리스트 찜버튼을 누르면 db로 들어가 등록
	int insertWishlist(WishlistVO vo);
	
	/*
	 * // 위시리스트에서 사용자의 아이디로(세션) 조회하기 WishlistVO selectWishlistByMemberId(String
	 * memberId);
	 */
	
	// 전체 작품들을 조회
	List<WishlistVO> selectWishlist(String memberId);
	
	// 위시리스트 페이지에서 클릭을 선택해서 이름, 작품명으로 삭제
	int deleteWishlist(String memberId, String artName);
	
	// 작품이 등록이 되어있는지 아닌지 카운트로 조회
	int selectCount(String memberId, String artName);
	
	//작품정보 수정 시 위시리스트도 수정
	int updateArt(ArtVO vo);
	
	//작품 삭제 시 위시리스트 삭제
	int deleteArt(int artNo);
	
} // end WishlistDAO
