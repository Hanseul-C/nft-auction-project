package project.spring.nft.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.spring.nft.domain.MemberVO;
import project.spring.nft.domain.PaymentVO;
import project.spring.nft.persistence.MemberDAO;
import project.spring.nft.persistence.PaymentDAO;
import project.spring.nft.persistence.RefundDAO;

@Service
public class MemberServiceImple implements MemberService {
	private static final Logger logger=
			LoggerFactory.getLogger(MemberServiceImple.class);
	
	@Autowired
	private MemberDAO memberDAO;
	@Autowired
	private PaymentDAO paymentDAO;
	@Autowired
	private RefundDAO refundDAO;
	
	@Override
	public int createMember(MemberVO vo) {
		logger.info("createMemeber() 호출 : vo = "+vo.toString());
		return memberDAO.insertMember(vo);
	}
	
	@Override
	public int readIdCheck(String memberId) {
		logger.info("readIdCheck() 호출");
		return memberDAO.selectIdCheck(memberId);
	}
	
	@Override
	public MemberVO readByMemberId(String memberId) {
		logger.info("readByMemberId() 호출");
		return memberDAO.selectByMemberId(memberId);
	}
	
	@Override
	public MemberVO readLogin(String memberId) {
		logger.info("readLogin() 호출");
		return memberDAO.selectLogin(memberId);
	}

	@Override
	public int updateMemberPassword(String memberId, String updatePassword) {
		logger.info("updateMemberPassword() 호출 : updatePassword = "+updatePassword);
		return memberDAO.updateMemberPassword(memberId, updatePassword);
	}

	@Override
	public int updateMemberInfo(MemberVO vo) {
		logger.info("updateMemberInfo() 호출 : vo ="+vo.toString());
		return memberDAO.updateMemberInfo(vo);
	}

	@Override
	public int deleteMember(String memberId, String memberPassword) {
		logger.info("deleteMember() 호출 : memberNo = "+memberId);
		return memberDAO.deleteMember(memberId, memberPassword);
	}

	@Override
	public List<String> findIdasEmail(String memberName, String memberEmail) {
		logger.info("findIdasEmail() 호출");
		return memberDAO.findIdasEmail(memberName, memberEmail);
	}
	
	@Override
	public MemberVO findPasswordasEmail(String memberId, String memberEmail) {
		logger.info("findPasswordasEmail() 호출");
		return memberDAO.findPasswordasEmail(memberId, memberEmail);
	}
	
	@Override
	public List<PaymentVO> readPaymentAll(String memberId) {
		logger.info("readAll() 호출");
		return paymentDAO.selectAll(memberId);
	}
<<<<<<< HEAD

	@Override
	public List<String> findIdasPhone(String memberName, String memberPhone) {
		logger.info("findIdasPhone() 호출");
		return memberDAO.findIdasPhone(memberName, memberPhone);
	}
	

=======
	
	@Override
	public int readProfit(String memberId) {
		logger.info("readProfit() 호출 : memberId = "+memberId);
		return paymentDAO.selectProfit(memberId);
	}
	
	
	@Override
	public Integer readRefund(String memberId) {
		logger.info("readRefund() 호출");
		return refundDAO.select(memberId);
	}
>>>>>>> origin/develop-yed
} // end class
