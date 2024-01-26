package com.multi.crowd;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import project.dao.ProjectDAO;
import project.dto.ProjectDTO;

@Controller
public class TestController {
	
	@Autowired
	ProjectDAO dao;
	
	@GetMapping("/testenum")
	public ModelAndView testeEum(){

		ModelAndView mv = new ModelAndView();
		mv.setViewName("test");
		return mv;
	}
	
}
