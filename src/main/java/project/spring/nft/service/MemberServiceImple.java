package project.spring.nft.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.spring.nft.domain.MemberVO;
import project.spring.nft.persistence.MemberDAO;

@Service
public class MemberServiceImple implements MemberService {
	private static final Logger logger=
			LoggerFactory.getLogger(MemberServiceImple.class);
	
	@Autowired
	private MemberDAO dao;
	
	@Override
	public int createMember(MemberVO vo) {
		logger.info("createMemeber() 호출 : vo = "+vo.toString());
		return dao.insertMember(vo);
	}
	
	@Override
	public int readIdCheck(String memberId) {
		logger.info("readIdCheck() 호출");
		return dao.selectIdCheck(memberId);
	}
	
	@Override
	public MemberVO readByMemberNo(int memberNo) {
		logger.info("readByMemberNo() 호출");
		return dao.selectByMemberNo(memberNo);
	}
	
	@Override
	public MemberVO readLogin(String memberId, String memberPassword) {
		logger.info("readLogin() 호출");
		return dao.selectLogin(memberId, memberPassword);
	}

	@Override
	public int updateMemberPassword(int memberNo, String updatePassword) {
		logger.info("updateMemberPassword() 호출 : updatePassword = "+updatePassword);
		return dao.updateMemberPassword(memberNo, updatePassword);
	}

	@Override
	public int updateMemberInfo(MemberVO vo) {
		logger.info("updateMemberInfo() 호출 : vo ="+vo.toString());
		return dao.updateMemberInfo(vo);
	}

	@Override
	public int deleteMember(int memberNo, String memberPassword) {
		logger.info("deleteMember() 호출 : memberNo = "+memberNo);
		return dao.deleteMember(memberNo, memberPassword);
	}

}
