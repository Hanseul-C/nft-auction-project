package project.spring.nft.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.io.IOUtils;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import project.spring.nft.domain.ArtVO;
import project.spring.nft.domain.AuctionVO;
import project.spring.nft.pageutil.PageCriteria;
import project.spring.nft.pageutil.PageMaker;
import project.spring.nft.service.ArtService;
import project.spring.nft.service.AuctionService;
import project.spring.nft.util.FileUploadUtil;
import project.spring.nft.util.MediaUtil;

@Controller
public class ArtController {
	// 로거
	private static final Logger logger=
			LoggerFactory.getLogger(ArtController.class);
	
	@Resource(name ="uploadPath")
	private String uploadPath;
	
	@Autowired
	private ArtService artService;
	
	@GetMapping("main")
	public void main(Model model, Integer page, Integer numsPerPage) {
		logger.info("readMain() 호출");
		logger.info("page = "+page+", numsPerPage = "+numsPerPage);
		currentAllList(model, page, numsPerPage);
	} //end main()
	
	@GetMapping("cur")
	public String currentSort(Model model, Integer page, Integer numsPerPage) {
		logger.info("currentSort() 호출");
		logger.info("page = "+page+", numsPerPage = "+numsPerPage);
		currentAllList(model, page, numsPerPage);
		
		return "main";
	} //end currentSort()
	
	private void currentAllList(Model model, Integer page, Integer numsPerPage) {
		logger.info("currentAllList() 호출");
		
		PageCriteria criteria = new PageCriteria();
		if(page !=null) {
			criteria.setPage(page);
		}
		if(numsPerPage!=null) {
			criteria.setNumsPerPage(numsPerPage);
		}
		
		List<ArtVO> list=artService.readCurrentArt(criteria);
		model.addAttribute("list", list); //list 데이터 보내기
		
		PageMaker pageMaker=new PageMaker();
		pageMaker.setCriteria(criteria);
		pageMaker.setTotalCount(artService.getTotalNumsOfRecords());
		pageMaker.setPageData();
		logger.info("이전 버튼 존재 유무 : "+pageMaker.isHasPrev());
		logger.info("다음 버튼 존재 유무 : "+pageMaker.isHasNext());
		model.addAttribute("pageMaker", pageMaker);
	} //end currentAllList()
	
	@GetMapping("wish")
	public String wishSort(Model model, Integer page, Integer numsPerPage) {
		logger.info("wishSort() 호출");
		logger.info("page = "+page+", numsPerPage = "+numsPerPage);

		PageCriteria criteria = new PageCriteria();
		if(page !=null) {
			criteria.setPage(page);
		}
		if(numsPerPage!=null) {
			criteria.setNumsPerPage(numsPerPage);
		}
		
		List<ArtVO> list=artService.readWishArt(criteria);
		model.addAttribute("list", list); //list 데이터 보내기
		
		PageMaker pageMaker=new PageMaker();
		pageMaker.setCriteria(criteria);
		pageMaker.setTotalCount(artService.getTotalNumsOfRecords());
		pageMaker.setPageData();
		model.addAttribute("pageMaker", pageMaker);
		
		return "main";
	} //end wishSort()
	
	@GetMapping("view")
	public String viewSort(Model model, Integer page, Integer numsPerPage) {
		logger.info("viewSort() 호출");
		logger.info("page = "+page+", numsPerPage = "+numsPerPage);

		PageCriteria criteria = new PageCriteria();
		if(page !=null) {
			criteria.setPage(page);
		}
		if(numsPerPage!=null) {
			criteria.setNumsPerPage(numsPerPage);
		}
		
		List<ArtVO> list=artService.readViewArt(criteria);
		model.addAttribute("list", list); //list 데이터 보내기
		
		PageMaker pageMaker=new PageMaker();
		pageMaker.setCriteria(criteria);
		pageMaker.setTotalCount(artService.getTotalNumsOfRecords());
		pageMaker.setPageData();
		model.addAttribute("pageMaker", pageMaker);
		
		return "main";
	} //end viewSort()
	
	@GetMapping("search")
	public String search(Model model, Integer page, Integer numsPerPage,
			String category, String keyword) {
		logger.info("search() 호출 : category = "+category+", keyword = "+keyword);	
		logger.info("page = "+page+", numsPerPage = "+numsPerPage);

		PageCriteria criteria = new PageCriteria();
		if(page !=null) {
			criteria.setPage(page);
		}
		if(numsPerPage!=null) {
			criteria.setNumsPerPage(numsPerPage);
		}
		
		List<ArtVO> list=null;
		PageMaker pageMaker=new PageMaker();
		
		if(category.equals("artName")) { //직품명 검색
			list=artService.readArtName(criteria, keyword);	
			logger.info("검색 완료");
			pageMaker.setTotalCount(artService.getArtNameNumsOfRecords(keyword));
		}else { //작가닉네임 검색
			list=artService.readMemberNickname(criteria, keyword);		
			pageMaker.setTotalCount(artService.getNicknameNumsOfRecords(keyword));

		}
		model.addAttribute("list", list);
		

		pageMaker.setCriteria(criteria);
		pageMaker.setPageData();
		model.addAttribute("pageMaker", pageMaker);
		
		return "main";
	} //end search()

	@GetMapping("/arts/register")
	public void registerGET() {
		logger.info("registerGET() 호출");
	} //end registerGET()
	
	@PostMapping("/arts/register")
	public String registerPOST(ArtVO vo, RedirectAttributes reAttr) {
		logger.info("registerPOST() 호출 : vo = "+vo.toString());
		int result=artService.createArt(vo);
		logger.info(result+"행 삽입");
		
		if(result==1) {
			int nicknameUpdate=artService.updateNickname(vo.getMemberId());
			logger.info(nicknameUpdate+"개 nickname 등록. art 등록 최종완료");
			reAttr.addFlashAttribute("registerResult", "success"); 
			//TODO : main에서 등록 성공 alert 띄우기
			return "redirect:/main"; 
		}else {
			return "redirect:/arts/register";
		}
	} //end registerPOST()
	
	@GetMapping("/arts/upload-ajax")
	public void uploadAjaxGET() {
		logger.info("uploadAjaxGET() 호출");
	} //end uploadAjaxGET()
	
	@PostMapping("/arts/upload-ajax")
	@ResponseBody
	public ResponseEntity<String> uploadAjaxPOST(MultipartFile[] files) throws IOException {
		logger.info("uploadAjaxPOST() 호출");
		
		//파일 하나만 저장
		String result=null; //파일 경로 및 썸네일 이미지 이름
		result=FileUploadUtil.saveUploadedFile(
				uploadPath, files[0].getOriginalFilename(), files[0].getBytes()); 
		
		return new ResponseEntity<String>(result, HttpStatus.OK);
	} //end uploadAjaxPOST()
	
	@GetMapping("/arts/display")
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
	
	@GetMapping("/arts/detail")
	public void detail(Model model, Integer artNo, Integer page) {
		logger.info("detail() 호출 : artNo = "+artNo+", page = "+page);
		Map<String, Object> readMap=artService.readArtNo(artNo);
		ArtVO vo=(ArtVO)readMap.get("vo");
		if(readMap.containsKey("maxMoney")) { //maxMoney가 있으면
			int maxMoney=(Integer)readMap.get("maxMoney");
			model.addAttribute("maxMoney", maxMoney);			
		}
		model.addAttribute("vo", vo);
		model.addAttribute("page", page);
	} //end detail()
}
