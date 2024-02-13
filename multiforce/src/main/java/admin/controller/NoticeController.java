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
	public ModelAndView notices(String category, String page, String query) {
		HashMap<String, Object> resultMap = null;
		if(page == null || page.equals("") || page.equals("0")) {
			page = "1";
		}
		int parsedPage = Integer.parseInt(page);
		
		if(category == null || category.equals("")) {
			category = "notice";
		}
		if(query == null || query.equals("")) {
			resultMap = service.selectPagingNotices(category, parsedPage);
		}else {
			resultMap = service.selectPagingNoticesWithQuery(category, parsedPage, query);
		}
		
		@SuppressWarnings("unchecked")
		List<NoticeDTO> list = (List<NoticeDTO>)resultMap.get("list");
		Integer totalPage = (Integer)resultMap.get("totalPage");
		Integer nowPage = (Integer)resultMap.get("nowPage");
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("list", list);
		mv.addObject("totalPage", totalPage);
		mv.addObject("nowPage", nowPage);
		mv.addObject("category", category);
		mv.addObject("query", query);
		mv.setViewName("admin/notices");
		return mv;
	}
	
	@GetMapping("/notices/write")
	public String noticesWrite(String seq, Model m) {
		if(seq != null && !seq.equals("")) {
			int parsedSeq = Integer.parseInt(seq);
			NoticeDTO dto = service.selectNotice(parsedSeq);
			m.addAttribute("dto", dto);
		}
		return "admin/notice_write";
	}
		
	@GetMapping("/notices/detail")
	public ModelAndView noticeDetail(String seq, NoticeDTO dtoAfterInsert) {
		ModelAndView mv = new ModelAndView();
		if(seq == null || seq.equals("")) {
			//seq없이 접근 시도시
		}
		int parsedSeq = Integer.parseInt(seq);
		if(dtoAfterInsert.getTitle() == null) {
			NoticeDTO dto = service.selectNotice(parsedSeq);
			if(dto == null || dto.getTitle() == null) {
				System.out.println("if내부");
				mv.addObject("result", "false");
			}else {
				mv.addObject("result", "true");
				mv.addObject("dto", dto);
			}
			mv.setViewName("admin/notice_detail");
		}else {
			System.out.println("else내부");
			mv.addObject("dto", dtoAfterInsert);
			mv.setViewName("admin/notice_detail");
		}
		return mv;
	}
	
	@PostMapping("/notices/detail")
	public ModelAndView enrollNotice(NoticeDTO dto) {
		System.out.println("post detail");
		NoticeDTO enrolledNotice = service.enrollNotice(dto);
		return noticeDetail(""+enrolledNotice.getNotice_seq(), enrolledNotice);
	}
	
	@PostMapping("/notice/modify")
	public ModelAndView modifyNotice(NoticeDTO dto) {
		NoticeDTO dto2 = service.modifyNotice(dto);
		return noticeDetail(dto2.getNotice_seq() + "", dto2);
	}
	
	@PostMapping("deletenotice")
	@ResponseBody
	public String deleteNotice(int notice_seq) {
		int result = service.deleteNotice(notice_seq);
		if(result == 0) {
			return "{\"result\": \"" + false + "\"}";
		}else {
			return "{\"result\": \"" + true + "\"}";
		}
	}
	
	@GetMapping("/notices/discover")
	public ModelAndView discoverNotice(String query, String category) {
		return notices(category, "", query);
	}
	
	
}
