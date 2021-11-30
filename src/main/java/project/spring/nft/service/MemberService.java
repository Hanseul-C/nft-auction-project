package project.spring.nft.service;

import java.util.List;

import project.spring.nft.domain.MemberVO;
import project.spring.nft.domain.PaymentVO;

public interface MemberService {
	//회원정보 등록
	int createMember(MemberVO vo);
	
	//아이디 중복체크
	int readIdCheck(String memberId);
	
	//회원정보 조회
	MemberVO readByMemberId(String memberId);
	
	//로그인 아이디 조회
	MemberVO readLogin(String memberId);
	
	//비밀번호 수정
	int updateMemberPassword(String memberId, String updatePassword);
	
	//회원정보 수정
	int updateMemberInfo(MemberVO vo);
	
	//회원탈퇴
	int deleteMember(String memberId, String memberPassword);
	
	//전화번호로 아이디찾기
	List<String> findIdasPhone(String memberName, String memberPhone);
	
	//이메일로 아이디찾기
	List<String> findIdasEmail(String memberName, String memberEmail);
	
	//비밀번호 찾기
	MemberVO findPasswordasEmail(String memberId, String memberEmail);

	//구매내역
	List<PaymentVO> readPaymentAll(String memberId);
	
	//작품 수익금
	int readProfit(String memberId);
	
	//회원 정산금
	Integer readRefund(String memberId);
}
