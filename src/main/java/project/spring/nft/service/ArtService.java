package project.spring.nft.service;

import java.util.List;
import java.util.Map;

import project.spring.nft.domain.ArtVO;
import project.spring.nft.pageutil.PageCriteria;

//TODO 기능 추가 필요
public interface ArtService {
	//작품 등록
	int createArt(ArtVO vo);
	//닉네임 적용
	int updateNickname(String memberId);
	//최신순 정렬 전체 작품 조회
	List<ArtVO> readCurrentArt(PageCriteria criteria);
	//찜하기순 정렬 전체 작품 조회
	List<ArtVO> readWishArt(PageCriteria criteria);
	//조회수순 정렬  전체 작품 조회
	List<ArtVO> readViewArt(PageCriteria criteria);
	//전체 작품 수
	int getTotalNumsOfRecords();
	//작품명 검색 개수
	int getArtNameNumsOfRecords(String keyword);
	//작가명 검색 개수
	int getNicknameNumsOfRecords(String keyword);		
	//작품명 검색
	List<ArtVO> readArtName(PageCriteria criteria, String keyword);
	//작가이름 검색
	List<ArtVO> readMemberNickname(PageCriteria criteria, String keyword);
	//상세 작품 조회
	Map<String, Object> readArtNo(int artNo);
	//조회수 카운팅 업데이트
	int updateView(int artViewCount);
	
	ArtVO readArtno(int artNo);

}
