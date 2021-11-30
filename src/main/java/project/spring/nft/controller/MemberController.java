package project.spring.nft.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import project.spring.nft.domain.ArtVO;
import project.spring.nft.domain.MemberVO;

import project.spring.nft.domain.PaymentVO;
import project.spring.nft.pageutil.PageCriteria;
import project.spring.nft.pageutil.PageMaker;
import project.spring.nft.service.ArtService;
import project.spring.nft.service.MemberService;

@Controller
@RequestMapping(value = "/members")
public class MemberController {
	private static final Logger logger=
			LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private MemberService memberService;
	@Autowired
	private JavaMailSender mailSender;
	@Resource(name = "bcryptPasswordEncoder")
	BCryptPasswordEncoder passEncoder;
	@Autowired
	private ArtService artService;

	@GetMapping("/sign-up")
	public void joinMemberGET() {
		logger.info("joinMemberGET() 호출");
	} //end joinMemberGET()
	
	@PostMapping("/sign-up")
	public String joinMemberPOST(MemberVO vo, RedirectAttributes reAttr) {		
		logger.info("joinMemberPOST() 호출 : vo = " + vo.toString());
		//비밀번호 암호화
		vo.setMemberPassword(passEncoder.encode(vo.getMemberPassword()));
		int result = memberService.createMember(vo);
		logger.info(result + "행 삽입");

		if (result == 1) {
			reAttr.addFlashAttribute("joinResult", "success");
			//main에서 회원가입 성공 alert 띄우기
			return "redirect:/main";
		} else {
			return "redirect:/members/sign-up";
		}
	} // end joinMemberPOST()

	
	@GetMapping("/login")
	public void loginMemberGET(HttpServletRequest request) {
		logger.info("loginMemberGET() 호출");
		
		//만약 url에 parameter가 있다면
		String uri=request.getRequestURI();
		logger.info("요청 uri : "+uri);
		String contextRoot=request.getContextPath();
		logger.info("contextRoot : "+contextRoot);
		uri=uri.replace(contextRoot, "");
		String queryString=request.getQueryString();
		logger.info("쿼리 스트링 : "+queryString);
		
		if(queryString != null) { //상세페이지의 댓글에서 로그인 이동한 경우
			HttpSession session=request.getSession();
			session.setAttribute("targetURL","../arts/detail?"+queryString);
		}
	} // end loginMemberGET()

	@PostMapping("/login")
	public String loginMemberPOST(String memberId, String memberPassword, HttpServletRequest request,
			RedirectAttributes reAttr) {
		logger.info("loginMemberPOST() 호출 : memberId = " + memberId + ", memberPassword = " + memberPassword);
		//회원 아이디로 세션생성하고 타겟url 생성하고 redirect
		MemberVO vo = memberService.readLogin(memberId);

		if (vo != null) { // 아이디가 일치하는 정보가 존재할 경우
			//입력된 비밀번호가 복호화된 비밀번호와 일치한지 확인
			if(passEncoder.matches(memberPassword, vo.getMemberPassword())) {
				logger.info("로그인 성공 : memberNo = " + vo.getMemberNo());
				HttpSession session = request.getSession();
				session.setAttribute("memberId", memberId); // id세션 생성
				reAttr.addFlashAttribute("loginResult", "success");
				
				String targetURL = (String) session.getAttribute("targetURL");
				logger.info("targetURL : " + targetURL);
				if (targetURL != null) {
					session.removeAttribute("targetURL");
					return "redirect:" + targetURL;
				} else {
					return "redirect:/main";
				}				
			}else {
				reAttr.addFlashAttribute("loginResult", "nomatch");
				return "redirect:/members/login";
			}
		} else {
			reAttr.addFlashAttribute("loginResult", "fail");
			return "redirect:/members/login";
		}
	} // end loginMemberPOST()

	@GetMapping("/my-page/member")
	public void myPageGET(Model model, HttpServletRequest request) {
		logger.info("myPageGET() 호출");

		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");

		MemberVO vo = memberService.readByMemberId(memberId);
		logger.info("마이페이지 회원정보 : " + vo.toString());

		// model로 보내주는 것 까먹지 말기!!
		model.addAttribute("vo", vo);
	}

	@PostMapping("/my-page/member")
	public void myPagePOST() {
		logger.info("myPagePOST() 호출");
	}

	// 비밀번호 변경페이지 불러오기
	@GetMapping("my-page/password-change")
	public void passwordChangeGET(Model model, HttpServletRequest request) {
		logger.info("passwordChangeGET() 호출");

		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");

		MemberVO vo = memberService.readByMemberId(memberId);
		logger.info("마이페이지 회원정보 : " + vo.toString());

		// model로 보내주는 것 까먹지 말기!!
		model.addAttribute("vo", vo);
	}

	// 비밀번호 변경 후 DB에 저장하기 암호화 적용.
	@PostMapping("my-page/password-change")
	public String passwordChangePOST(Model model, HttpServletRequest request) {
		logger.info("passwordChangePOST() 호출");

		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		String updatePassword = request.getParameter("updatePassword");
		updatePassword=passEncoder.encode(updatePassword); //암호화
		int result = memberService.updateMemberPassword(memberId, updatePassword);
		
		if (result == 1) {
			logger.info(result + "비밀번호 수정 성공 , 세션 유지 아이디 : " + memberId);
			return "redirect:/members/my-page/member";
		} else {
			logger.info(result + "비밀번호 수정 실패 , 세션 유지 아이디 : " + memberId);
			return "redirect:/members/my-page/member";
		}

	}

	// 회원 정보 수정페이지 불러오기.
	@GetMapping("/my-page/update")
	public void updateMemberGET(Model model, HttpServletRequest request) {
		logger.info("updateGET() 호출");

		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");

		// 정보 가져와서 보여주기
		MemberVO vo = memberService.readByMemberId(memberId);
		logger.info("마이페이지 회원정보 : " + vo.toString());

		model.addAttribute("vo", vo);

	}

	// 정보 수정해서 db 저장.
	@PostMapping("/my-page/update")
	public String updateMemberPOST(MemberVO vo, HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		logger.info("updatePOST() 호출 , 입력한 정보 vo : " + vo);
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		vo.setMemberId(memberId);
		int result = memberService.updateMemberInfo(vo);

		if (result == 1) {
			logger.info(result + "성공 , 세션 유지 아이디 : " + memberId);
			// TODO : 리다이렉트, 타겟URI 바꾸기!!
			// prompt나 경고창 뜨게 하기.
			PrintWriter out = response.getWriter();
			out.println("<script> alert('회원 정보 수정이 완료되었습니다!'); </script>");
			return "redirect:/members/my-page/member";
		} else {
			logger.info(result + "실패 , 세션 유지 아이디 : " + memberId);
			return "redirect:/members/my-page/member";
		}

	}
	
	@GetMapping("/logout")
	public String logoutMember(HttpServletRequest request, RedirectAttributes reAttr) {
		logger.info("logoutMember() 호출");
		HttpSession session=request.getSession();
		session.removeAttribute("memberId");
		reAttr.addFlashAttribute("logoutResult", "success"); 
		return "redirect:/main";
	}
	

	// delete의 GET
	@GetMapping("/my-page/delete")
	public void deleteMemberGET(Model model, HttpServletRequest request) {
		logger.info("deleteGET() 호출");

		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");

		// 정보 가져와서 보여주기
		MemberVO vo = memberService.readByMemberId(memberId);
		logger.info("마이페이지 회원정보 : " + vo.toString());

		model.addAttribute("vo", vo);

	}

	// TODO : 삭제 하면 DB는 완료되는데 서버 오류뜸(세션때문인듯 NullPoint에러가뜸!!)
	// update 페이지에서 회원탈퇴 db로
	@PostMapping("/my-page/delete")
	public String deleteMemberPOST(Model model, MemberVO vo, HttpServletRequest request) {
		logger.info("deletePOST() 호출");
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		vo.setMemberId(memberId);
		String memberPassword = request.getParameter("memberPassword");
		logger.info(vo.toString());
		// input에서 입력받은 비밀번호와 VO에 있는 패스워드가 일치 하지 않는 경우엔
		if (memberPassword != vo.getMemberPassword()) {
			logger.info("비밀번호 일치 실패");
			return "redirect:/members/my-page/delete";

		} else { // 일치하는 경우 정상인 경우.
			int result = memberService.deleteMember(memberId, memberPassword);
			if (result == 1) {
				logger.info(result + "삭제 성공 , 세션 삭제하기");
				// 세션 삭제후 메인페이지로 돌아가게 만들기
				session.removeAttribute(memberId);
				return "redirect:/members/login";
			} else {
				logger.info(result + "삭제 실패 , 세션 유지 아이디 : " + memberId);
				return "redirect:/members/login";
			}

		}

	} // end deletePOST()
	
	@GetMapping("/find-id")
	public void findId(HttpServletRequest request, Model model) {
		logger.info("findId() 호출");
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		
		if(memberId == null) {
			model.addAttribute("accessResult", "success");
		}else {
			model.addAttribute("accessResult", "fail");
		}
	} //end findId()
	
	@PostMapping("/find-id/phone")
	public String findIdasPhone(Model model, String memberName, String memberPhone) {
		logger.info("findIdasPhone() 호출");
		List<String> list=memberService.findIdasPhone(memberName, memberPhone);
		logger.info(list.size()+"개 정보 일치");
		model.addAttribute("list", list);
		return "members/find-result";
	} //end findIdasPhone()
	
	@PostMapping("/find-id/email")
	public String findIdasEmail(Model model, String memberName, String memberEmail) {
		logger.info("findIdasEmail() 호출");
		List<String> list=memberService.findIdasEmail(memberName, memberEmail);
		logger.info(list.size()+"개 정보 일치");
		model.addAttribute("list", list);
		return "members/find-result";
	} //end findIdasEmail()
	
	@GetMapping("/find-password")
	public void findPasswordGET(HttpServletRequest request, Model model) {
		logger.info("findPasswordGET() 호출");
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		
		if(memberId == null) {
			model.addAttribute("accessResult", "success");
		}else {
			model.addAttribute("accessResult", "fail");
		}
	} //end findPasswordGET()
	
	@PostMapping("/find-password")
	public String findPasswordPOST(RedirectAttributes reAttr, String memberId, String memberEmail) throws Exception {
		logger.info("findPasswordPOST() 호출");
		MemberVO vo=memberService.findPasswordasEmail(memberId, memberEmail);
		if(vo != null) { //일치하는 회원정보가 있으면
			String randomPassword=getRamdomPassword(7);
			logger.info("randomPassword = "+randomPassword);
			//임시번호도 암호화 필요함
			String encodeRandom=passEncoder.encode(randomPassword);
			int update=memberService.updateMemberPassword(memberId, encodeRandom);
			logger.info(update+"개 임시비밀번호 변경");
			//TODO 메일로 임시비번 보내기
			int result=sendMailTest(memberEmail, randomPassword);
			logger.info(result+"개 메일 발송 완료");
			reAttr.addFlashAttribute("emailResult", "success");
			return "redirect:login";
		}else {
			reAttr.addFlashAttribute("emailResult", "fail");
			return "redirect:find-password";
		}
	} //end findPasswordPOST();
	
	public static String getRamdomPassword(int len) { 
		char[] charSet = new char[] { 
				'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 
				'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 
				'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 
				'U', 'V', 'W', 'X', 'Y', 'Z' 
				}; 
		int idx = 0; 
		StringBuffer sb = new StringBuffer(); 
		logger.info("charSet.length : "+charSet.length); 
		
		for (int i = 0; i < len; i++) { 
			idx = (int) (charSet.length * Math.random()); 
			// 36 * 생성된 난수를 Int로 추출 (소숫점제거) 
			logger.info("idx : "+idx); 
			sb.append(charSet[idx]); 
		} 
		return sb.toString(); 
	} //end getRamdomPassword()
	

    public int sendMailTest(String memberEmail, String randomPassword) throws Exception{
        int result=0;
        String subject = "[NFT-AUCTION] 임시 비밀번호가 발급되었습니다.";
        String content = 
        	"<p>안녕하세요 회원님!<br>발급된 임시 비밀번호는 "
        	+randomPassword
        	+"입니다.<br>로그인하고 비밀번호를 변경해주세요.</p>";
        String from = "qrqrqrqrt@gmail.com";
        String to = memberEmail;
        
        try {
            MimeMessage mail = mailSender.createMimeMessage();
            MimeMessageHelper mailHelper = new MimeMessageHelper(mail,"UTF-8");
            // true는 멀티파트 메세지를 사용하겠다는 의미
            
            mailHelper.setFrom(new InternetAddress(from,"NFT-AUCTION","UTF-8"));
            // 빈에 아이디 설정한 것은 단순히 smtp 인증을 받기 위해 사용 따라서 보내는이(setFrom())반드시 필요
            mailHelper.setTo(to);
            mailHelper.setSubject(subject);
            mailHelper.setText(content, true);
            // true는 html을 사용하겠다는 의미입니다.            
            mailSender.send(mail);
            result=1;
            return result; //전송 정상적으로 처리됨
        } catch(Exception e) {
            e.printStackTrace();
            return result;
        }
        
    } //end sendMailTest()
    
    
    // 현아 추가. 등록작품페이지!
    @GetMapping("/my-page/artlist")
    public void artlistGET(Model model, HttpServletRequest request, 
    		Integer page, Integer numsPerPage) {
		logger.info("artlistGET() 호출");
		logger.info("page = "+page+", numsPerPage = "+numsPerPage);

		// TODO : 작품 등록이 안되어있는 상황도 봐야함!
		
		PageCriteria criteria = new PageCriteria();
		if(page !=null) {
			criteria.setPage(page);
		}
		if(numsPerPage!=null) {
			criteria.setNumsPerPage(numsPerPage);
		}

		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");

		List<ArtVO> list = artService.readByMemberId(criteria, memberId);
		model.addAttribute("list", list);
		
		PageMaker pageMaker=new PageMaker();
		pageMaker.setCriteria(criteria);
		pageMaker.setTotalCount(artService.getTotalMyArt(memberId));
		pageMaker.setPageData();
		logger.info("이전 버튼 존재 유무 : "+pageMaker.isHasPrev());
		logger.info("다음 버튼 존재 유무 : "+pageMaker.isHasNext());
		model.addAttribute("pageMaker", pageMaker);
		
		//수익금 내역
		try {
			double profit=memberService.readProfit(memberId); //총 수익금
			//정산받은 금액이 있다면 빼기
			Integer refund=memberService.readRefund(memberId);
			profit=profit-refund;
			profit= profit - (profit*0.05);
			model.addAttribute("profit", profit);
		} catch (NullPointerException e) {
			model.addAttribute("profit", 0);
		}
		

	} // end artlistGET()

    @GetMapping("/my-page/shopping-list")
    public void shoppingList(Model model, HttpServletRequest request, Integer page, Integer numsPerPage) {
    	logger.info("shoppingList() 호출");
    	
    	PageCriteria criteria = new PageCriteria();
		if(page !=null) {
			criteria.setPage(page);
		}
		if(numsPerPage!=null) {
			criteria.setNumsPerPage(numsPerPage);
		}

		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		
		List<PaymentVO> list=memberService.readPaymentAll(memberId);
		for (PaymentVO vo : list) {
			System.out.println(vo.toString());
		}
		if(list != null) {
			model.addAttribute("list", list);			
		}
		
		PageMaker pageMaker=new PageMaker();
		pageMaker.setCriteria(criteria);
		pageMaker.setPageData();
		model.addAttribute("pageMaker", pageMaker);
		
    } //end shoppingList()

	
} // end class
