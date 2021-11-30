package project.spring.nft.persistence;

import java.util.List;

import project.spring.nft.domain.ArtVO;
import project.spring.nft.pageutil.PageCriteria;

//TODO 기능추가 필요
public interface ArtDAO {
	//작품 등록
	int insertArt(ArtVO vo);
	//회원닉네임 업데이트
	int updateNickName(String memberId);
	//최신순 정렬 전체 작품 조회
	List<ArtVO> selectCurrentArt(PageCriteria criteria);
	//찜하기순 정렬 전체 작품 조회
	List<ArtVO> selectWishArt(PageCriteria criteria);
	//조회수순 정렬  전체 작품 조회
	List<ArtVO> selectViewArt(PageCriteria criteria);
	//작품 전체 개수
	int getTotalNumsOfRecords();
	//작품명 검색 개수
	int getArtNameNumsOfRecords(String keyword);
	//작가명 검색 개수
	int getNicknameNumsOfRecords(String keyword);		
	//작품명 검색
	List<ArtVO> selectArtName(PageCriteria criteria, String keyword);
	//작가이름 검색
	List<ArtVO> selectMemberNickname(PageCriteria criteria, String keyword);
	//작품 상세 조회
	ArtVO selectArtNo(int artNo);
	//조회수 카운팅 적용하기
	int updateView(int artNo, int count);
	//댓글수 업데이트
	int updateReplyCount(int amount, int artNo);
	//작품 데이터 수정
	int updateArt(ArtVO vo);
	//작품(게시된) 삭제
	int deleteArt(int artNo);
	//회원 낙찰내역
	List<ArtVO> selectWinBid(String memberId);
	// 작품 멤버 아이디로 검색, 등록 내역에서 쓸거임
	List<ArtVO> selectMemberId(PageCriteria criteria, String memberId);
	// 작품 WISH_COUNT 올라가기, 내려가기(업데이트)
	int updateWishCount(int artNo, int count);
	//등록내역 개수
	int getTotalMyArt(String memberId);
	
	// 경매에 등록되지 않은 작품 정보 조회
	List<ArtVO> selectNotAuction();
}
