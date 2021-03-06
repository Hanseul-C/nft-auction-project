package project.spring.nft.persistence;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.spring.nft.domain.MemberVO;

@Repository
public class MemberDAOImple implements MemberDAO {
	private static final Logger logger=
			LoggerFactory.getLogger(MemberDAOImple.class);
	
	private static final String NAMESPACE="project.spring.nft.MemberMapper";
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int insertMember(MemberVO vo) {
		logger.info("insertMember() 호출");
		return sqlSession.insert(NAMESPACE+".insert", vo);
	}
	
	@Override
	public int selectIdCheck(String memberId) {
		logger.info("selectIdCheck() 호출");
		return sqlSession.selectOne(NAMESPACE+".select_by_member_id", memberId);
	}
	
	@Override
	public MemberVO selectByMemberNo(int memberNo) {
		logger.info("selectByMemberNo() 호출");
		return sqlSession.selectOne(NAMESPACE+".select_by_member_no", memberNo);
	}
	
	@Override
	public MemberVO selectLogin(String memberId, String memberPassword) {
		logger.info("selectLogin() 호출 : memberId = "+memberId+", memberPassword = "+memberPassword);
		Map<String, String> loginMap=new HashMap<String, String>();
		loginMap.put("memberId", memberId);
		loginMap.put("memberPassword", memberPassword);
		return sqlSession.selectOne(NAMESPACE+".select_login", loginMap);
	}  

	@Override
	public int updateMemberPassword(int memberNo, String updatePassword) {
		logger.info("updateMemberPassword() 호출");
		Map<String, String> updateMap=new HashMap<String, String>();
		String parseMemberNo=Integer.toString(memberNo);
		updateMap.put("memberNo", parseMemberNo);
		updateMap.put("memberPassword", updatePassword);
		return sqlSession.update(NAMESPACE+".update_pw", updateMap);
	}

	@Override
	public int updateMemberInfo(MemberVO vo) {
		logger.info("updateMemberInfo() 호출");
		return sqlSession.update(NAMESPACE+".update_info", vo);
	}

	@Override
	public int deleteMember(int memberNo, String memberPassword) {
		logger.info("deleteMember() 호출");
		Map<String, String> deleteMap=new HashMap<String, String>();
		String parseMemberNo=Integer.toString(memberNo);
		deleteMap.put("memberNo", parseMemberNo);
		deleteMap.put("memberPassword", memberPassword);
		return sqlSession.delete(NAMESPACE+".delete", deleteMap);
	}

}
