package project.spring.nft.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import project.spring.nft.domain.RefundVO;
import project.spring.nft.service.RefundService;

@Controller
public class RefundController {
	private static final Logger logger=
			LoggerFactory.getLogger(RefundController.class);
	
	@Autowired
	private RefundService refundService;
	
	@GetMapping("/members/my-page/refund")
	public void refundGET() {
		logger.info("refundGET() 호출");
	} //end refundGET()
	
	@PostMapping("/members/my-page/refund")
	public void refundPOST(RefundVO vo, Model model) {
		logger.info("refundPOST() 호출 : vo = "+ vo.toString());
		int result=refundService.create(vo);
		
		if(result==1) {
			model.addAttribute("refundResult", "success");
		}else {
			model.addAttribute("refundResult", "fail");
		}
		
	} //end refundPOST()
}
