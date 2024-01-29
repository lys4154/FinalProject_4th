package project.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import admin.dto.NoticeDTO;
import admin.service.NoticeService;

@Controller
public class MainPageController {
	
	@Autowired
	NoticeService noticeService;
	
	@GetMapping("/")
	public ModelAndView mainpage() {
		ModelAndView mv = new ModelAndView();
		HashMap<String, String> map = noticeService.getOnGoingEvent();
		mv.addObject("eventmap", map);
		mv.setViewName("common/mainpage");
		return mv;
	}
}
