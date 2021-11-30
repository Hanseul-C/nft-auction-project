package project.spring.nft.controller;

import java.io.FileInputStream;
import java.io.InputStream;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.aspectj.weaver.AjAttribute.DeclareAttribute;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import project.spring.nft.domain.ArtVO;
import project.spring.nft.domain.AuctionVO;
import project.spring.nft.domain.MemberVO;
import project.spring.nft.domain.PaymentVO;
import project.spring.nft.service.ArtService;
import project.spring.nft.service.MemberService;
import project.spring.nft.service.PaymentService;
import project.spring.nft.util.MediaUtil;

@Controller
@RequestMapping(value="/arts")
public class PaymentController {
	private static final Logger logger = LoggerFactory.getLogger(PaymentController.class);
	
	@Autowired
	MemberService memberservice;
	
	@Autowired
	PaymentService paymentservice;
	
	@Autowired
	ArtService artservice;
	
	@Resource(name ="uploadPath")
	private String uploadPath;
	
	@GetMapping("/pay")
	public void  payGET(Model model, int artNo, String type, HttpServletRequest request) {
		logger.info("payGET() 호출");
		
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		logger.info("memberId : "+memberId);
		if(memberId == null) {
			logger.info("비회원 접근 불가");
			model.addAttribute("payResult", "fail");
		}else {
			MemberVO vo = memberservice.readByMemberId(memberId);
			logger.info("구매자 정보 : " + vo.toString());
			
			ArtVO avo = artservice.readArtno(artNo);
			logger.info("구매작품 정보 : "+avo.toString());
			
			if(type.equals("A")) {
				AuctionVO auvo=paymentservice.readArtNo(artNo);			
				logger.info("경매 낙찰 정보 : "+auvo.toString());
				model.addAttribute("auvo", auvo);
			}
			logger.info("결제 유형 : "+type);
			model.addAttribute("typeResult", type);
			model.addAttribute("avo", avo);
			model.addAttribute("vo", vo);
		}
		
	} //end payGET()
	
	
	@GetMapping("/result")
	public void resultGET(int artNo, Model model) {
		logger.info("resultGET() 호출");
		PaymentVO vo = paymentservice.selectByArtNo(artNo);
		logger.info("결제 정보 : " + vo.toString()); 
		model.addAttribute("vo", vo);
	}
	
	@PostMapping("/result")
	public void resultPOST(@RequestBody PaymentVO vo, HttpServletRequest request, RedirectAttributes reAttr) {
		logger.info("resultPOST() 호출");
		logger.info(vo.toString());
		String memberId = null;
		int result = 0;
		result = paymentservice.insertPayment(vo);
		logger.info(result + "개 입력");
		if(result == 1) {
			HttpSession session = request.getSession();
			session.setAttribute(vo.getMemberId(), memberId);
		} else {
			logger.info("외않되");
		}
	}
	
	@GetMapping("/pay/display")
	public ResponseEntity<byte[]> display(String fileName) throws Exception{
		//이미지도 데이터. byte형태를 가지고 있음
		logger.info("display() 호출");
		ResponseEntity<byte[]> entity=null;
		InputStream in=null;
		
		//파일 확장자
		String extension=fileName.substring(fileName.lastIndexOf(".")+1);
		logger.info(extension);
		
		if(extension.equals("gif")) { //확장자가 gif인 경우
			fileName=fileName.replace("s_", "");
		}
		
		String filePath=uploadPath+fileName;
		in=new FileInputStream(filePath); //파일넣기
		
		//응답헤더(response header) org.springframework.http에 Content-Type 설정
		HttpHeaders httpHeaders=new HttpHeaders();
		httpHeaders.setContentType(MediaUtil.getMediaType(extension));
		
		//데이터 전송
		entity=new ResponseEntity<byte[]>(
				IOUtils.toByteArray(in), //파일에서 읽은 데이터
				httpHeaders, //응답헤더
				HttpStatus.OK);
		
		return entity;
	} //end display()
	
}
