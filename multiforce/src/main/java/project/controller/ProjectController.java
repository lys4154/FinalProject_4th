package project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ProjectController {
	
	@RequestMapping("/projectdesign")
	public String projectDesign() {
		return "project/ProjectDesign";
	}
	
	@RequestMapping("/projectinform")
	public String projectInform() {
		return "project/ProjectInform";
	}
	
	@RequestMapping("/projectmanagement")
	public String projectManagement() {
		return "project/ProjectManagement";
	}
}
