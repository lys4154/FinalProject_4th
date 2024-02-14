package com.multi.crowd;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import funding.dto.FundingDTO;
import funding.service.FundingService;
import project.dao.ProjectDAO;
import project.dto.ProjectDTO;

@Controller
public class TestController {
	
	@Autowired
	ProjectDAO dao;
	@Autowired
	FundingService fundingService;
	
	@GetMapping("/testenum")
	public ModelAndView testeEum(){

		ModelAndView mv = new ModelAndView();
		mv.setViewName("test");
		return mv;
	}
	
	@GetMapping("/test2")
	public ModelAndView test2(){
		ModelAndView mv = new ModelAndView();
		FundingDTO dto = fundingService.getPaymentInfo(8);
		mv.addObject("dto", dto);
		mv.setViewName("test2");
		return mv;
	}
}
