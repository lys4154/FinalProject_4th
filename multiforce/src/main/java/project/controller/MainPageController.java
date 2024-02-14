package project.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import admin.dto.NoticeDTO;
import admin.service.NoticeService;
import project.dto.ProjectDiscoverDTO;
import project.dto.ProjectMemberDTO;
import project.service.ProjectService;

@Controller
public class MainPageController {
	
	@Autowired
	NoticeService noticeService;
	@Autowired
	ProjectService projectService;
	
	@GetMapping("/")
	public ModelAndView mainpage() {
		ModelAndView mv = new ModelAndView();
		HashMap<String, String> map = noticeService.getOnGoingEvent();
		mv.addObject("eventmap", map);
		
		//업데이트 프로젝트
		List<ProjectMemberDTO> newUpdateProject = projectService.newUpdateProject();
		mv.addObject("update", newUpdateProject);

		//인기 프로젝트
		List<ProjectMemberDTO> popularProject = projectService.popularProject();
		mv.addObject("popular", popularProject);

		mv.setViewName("common/mainpage");
		return mv;
	}
}
