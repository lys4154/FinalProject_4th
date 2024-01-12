package admin.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
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
import admin.service.NoticeService;

@Controller
public class NoticeController {
	@Autowired
	NoticeService service;
	@GetMapping("/notices")
	public ModelAndView notices(String category, String page) {
		if(page == null || page.equals("")) {
			page = "1";
		}
		if(category == null || category.equals("")) {
			category = "notice";
		}
		int parsedPage = Integer.parseInt(page);
		HashMap<String, Object> resultMap = service.selectPagingNotices(category, parsedPage);
		@SuppressWarnings("unchecked")
		List<NoticeDTO> list = (List<NoticeDTO>)resultMap.get("list");
		Integer totalPage = (Integer)resultMap.get("totalPage");
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("list", list);
		mv.addObject("totalPage", totalPage);
		mv.addObject("nowPage", parsedPage);
		mv.addObject("category", category);
		mv.setViewName("admin/notices");
		return mv;
	}
	
	@GetMapping("/notices/write")
	public String noticesWrite(String seq, Model m) {
		if(seq != null) {
			//seq로 dto 채워오기
			//dto Model에 추가
			if(seq.equals("")) {
				System.out.println("seq테스트");
			}
			NoticeDTO dto = new NoticeDTO();
			dto.setCategory("event");
			dto.setNotice_seq(1);
			dto.setTitle("테스트");
			dto.setWrite_date("2023-01-02");
			dto.setContent("<h1>테스트qwdqwwqdwdwq</h1>");
			m.addAttribute("dto", dto);
			System.out.println("작동확인");
		}
		return "admin/notice_write";
	}
		
	@GetMapping("/notices/detail")
	public ModelAndView noticeDetail(String seq, NoticeDTO dtoAfterInsert) {
		if(seq == null || seq.equals("")) {
			//seq없이 접근 시도시
		}
		int parsedSeq = Integer.parseInt(seq);
		ModelAndView mv = new ModelAndView();
		
		if(dtoAfterInsert.getTitle() == null) {
			//seq로 dto 채워오기
			NoticeDTO dto = service.selectNotice(parsedSeq);
			mv.addObject("dto", dto);
			mv.setViewName("admin/notice_detail");
		}else {

			mv.addObject("dto", dtoAfterInsert);
			mv.setViewName("admin/notice_detail");
		}
		return mv;
	}
	
	@PostMapping("/notices/detail")
	public ModelAndView enrollNotice(NoticeDTO dto) {
		NoticeDTO enrolledNotice = service.enrollNotice(dto);
		return noticeDetail(enrolledNotice.getNotice_seq() + "", enrolledNotice);
	}
	
	@PostMapping("/notice/modify")
	public ModelAndView modifyNotice(NoticeDTO dto) {
		//dto db 수정
		return noticeDetail("", dto);
	}
}
