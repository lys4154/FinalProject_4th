package project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;



import project.dto.ProjectDTO;
import project.service.ProjectService;

@Controller
public class ProjectController {
	@Autowired
	private ProjectService projectService;
	
	@RequestMapping("/projectdesign")
	public String projectDesign() {
		return "project/projectdesign";
	}
	
	@RequestMapping("/projectinform")
	public String projectInform() {
		return "project/projectinform";
	}
	
	@RequestMapping("/projectmanagement")
	public String projectManagement() {
		return "project/projectmanagement";
	}

	//프로젝트 승인 리스트
	@GetMapping("project_approve_list")
	public String showAppoveList(Model model) {
		List<ProjectDTO> projects = projectService.getAllProjects(); 
		
		
        model.addAttribute("projects", projects);
		return "project/project_approve_list";
		
	}
	
	//프로젝트 상세
	@GetMapping("project_detail")
	public String ShowProjectDetail() {
		return "project/project_detail";
	}
	
	//프로젝트 상세 내 커뮤니티
	@GetMapping("project_detail/community")
	public String ShowProjectCommunity() {
		return "project/project_community";
	}
	
	@RequestMapping("/tab_info")
	public String tabInfo() {
		return "project/tab_info";
	}
	
	@RequestMapping("/tab_fundingPlan")
	public String tabFundingPlan() {
		return "project/tab_fundingPlan";
	}
	
	@RequestMapping("/tab_gift")
	public String tabGift() {
		return "project/tab_gift";
	}
	
	@RequestMapping("/tab_projectPlan")
	public String tabProjectPlan() {
		return "project/tab_projectPlan";

	}
}
