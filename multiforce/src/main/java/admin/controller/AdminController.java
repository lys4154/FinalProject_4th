package admin.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.UUID;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import admin.dto.NoticeDTO;

@Controller
public class AdminController {
	
	@GetMapping("/notices")
	public ModelAndView notices() {
		ModelAndView mv = new ModelAndView();
		//이벤트 게시물 dto list를 모델로 넣어주기 
		mv.setViewName("admin/notices");
		return mv;
	}
	
	@GetMapping("/notices/write")
	public String noticesWrite(String seq, Model m) {
		if(!seq.equals("")) {
			//seq로 dto 채워오기
			//dto Model에 추가
		}
		return "admin/notice_write";
	}
	
	@PostMapping(value="/uploadSummernoteImageFile", produces = "application/json")
	@ResponseBody
	public JsonNode uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile) {
		
		ObjectMapper mapper = new ObjectMapper();
		HashMap<String, Object> resultMap = new HashMap<>();
		
//		String fileRoot = "C:\\fullstack\\workspace_springboot\\FinalProject_4th\\"
//							+ "multiforce\\src\\main\\resources\\static\\images\\notices\\";
		String fileRoot = "C:\\fullstack\\workspace_springboot\\images\\notices\\";
		String originalFileName = multipartFile.getOriginalFilename();	//오리지날 파일명
		String extension = originalFileName.substring(originalFileName.lastIndexOf("."));//파일 확장자
		String savedFileName = UUID.randomUUID() + extension;//저장될 파일 명

		try {
			File targetFile = new File(fileRoot + savedFileName);//파일저장
			multipartFile.transferTo(targetFile);
			System.out.println("try 작동");
			//resultMap.put("url", "/images/notices/"+savedFileName);
			resultMap.put("url", "/noticesimages/"+savedFileName);
			resultMap.put("responseCode", "success");
		} catch (IOException e) {
			resultMap.put("responseCode", "false");
			e.printStackTrace();
		}
		JsonNode resultJsonNode = mapper.convertValue(resultMap, JsonNode.class);
		return resultJsonNode;
	}
	
	@GetMapping("/notices/detail")
	public ModelAndView noticeDetail(String seq, NoticeDTO dto) {
		if(seq == null || seq.equals("")) {
			//seq없이 접근 시도시
		}
		ModelAndView mv = new ModelAndView();
		
		if(dto.getTitle() == null) {
			//seq로 dto 채워오기
			System.out.println("dto2");
			NoticeDTO dto2 = new NoticeDTO();
			dto2.setCategory("notice");
			dto2.setContent("<h1>테스트</h1>");
			dto2.setTitle("테스트");
			dto2.setWrite_date("2023-10-23");
			
			mv.addObject("dto", dto2);
			mv.setViewName("admin/notice_detail");
		}else {
			System.out.println("dto1");
			mv.addObject("dto", dto);
			mv.setViewName("admin/notice_detail");
		}
		return mv;
	}
	
	@PostMapping("/notices/detail")
	public ModelAndView enrollNotice(NoticeDTO dto) {
//		System.out.println(dto.getTitle());
//		System.out.println(dto.getCategory());
//		if(dto.getCategory().equals("event")) {
//			System.out.println(dto.getEvent_start_date());
//			System.out.println(dto.getEvent_end_date());
//		}
//		System.out.println(dto.getContent());
		
		//1. dto db에 저장 후 where에 조건 잔뜩써서 그것만 딱 가져오게 해서 seq 뽑아내서
		//결과값을 seq 뒤에 넣어주기; return "redirect:/admin/notices_detail?seq=";
		//2. dto db에 저장 후 where에 조건 잔뜩써서 그것만 딱 가져오게 해서 dto 꽉채움
		//get매핑된 메서드에 넣어서 리턴 => 이걸로
		
		dto.setWrite_date("2023-10-23");
		return noticeDetail("", dto);
	}
	
	@PostMapping("/notice/modify")
	public ModelAndView modifyNotice(NoticeDTO dto) {
		//dto db 수정
		return noticeDetail("", dto);
	}
}
