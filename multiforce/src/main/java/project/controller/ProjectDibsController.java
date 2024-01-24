package project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import project.service.ProjectDibsService;

@Controller
public class ProjectDibsController {
	
	@Autowired
	ProjectDibsService dibsService;
	
	@PostMapping("/addprojectdibs")
	@ResponseBody
	public String addProjectDibs(int member_seq, int project_seq) {
		String result = dibsService.addDibs(member_seq, project_seq);
		return "{\"result\":\"" + result +"\"}" ;
		
	}
}
