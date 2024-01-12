package project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import board.dto.BoardDTO;
import board.dto.CommunityDTO;
import board.service.boardService;
import project.dto.ProjectDTO;
import project.service.ProjectService;

@Controller
public class ProjectController {
	@Autowired
	private ProjectService projectService;
	
	@Autowired
	private boardService boardService;
	
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
		int approvedCount = projectService.approvedCount(); 
		int unapprovedCount = projectService.unapprovedCount();
		
		
		model.addAttribute("approvedCount", approvedCount);
		model.addAttribute("unapprovedCount", unapprovedCount);
		return "project/project_approve_list";
		
	}
	
	//승인 리스트
	@GetMapping("approve_list/approved")
	public String showApprovedOnly(Model model) {
		List<ProjectDTO> projects = projectService.getAllApprovedProjects(); 
		
		
        model.addAttribute("projects", projects);
		return "project/approve_list_table";
		
	}
	
	//승인 대기 리스트
	@GetMapping("approve_list/unapproved")
	public String showUnapprovedOnly(Model model) {
		List<ProjectDTO> projects = projectService.getAllUnapprovedProjects(); 
		
		
        model.addAttribute("projects", projects);
		return "project/approve_list_table";
		
	}
	
	//프로젝트 상세
	@GetMapping("project_detail")
	public String ShowProjectDetail() {
		return "project/project_detail";
	}
	
	//프로젝트 상세 내 커뮤니티
	@GetMapping("project_detail/community/{project_seq}")
	public String ShowProjectCommunity(@PathVariable("project_seq") int project_seq,
			Model model) {
		
		ProjectDTO project_info = projectService.getProjectDetail(project_seq);
		model.addAttribute("projects", project_info);
		
		return "project/project_community";
	}
	
	@PostMapping("community_post")
	public String saveCommunityPost(@RequestParam String post_category, @RequestParam int post_id, 
			@RequestParam String content) {
		
		int tmpUser = 1;
		CommunityDTO com_post = new CommunityDTO();
		com_post.setProject_seq(post_id);
		com_post.setContent(content);
		com_post.setCategory(post_category);
		com_post.setMember_seq(tmpUser);
		
		boardService.saveCommunityPost(com_post);
		
		return "redirect:project_detail/community/"+post_id;
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
