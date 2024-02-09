package approvalRequest.controller;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import approvalRequest.dto.ApprovalRequestDTO;
import approvalRequest.service.ApprovalRequestService;
import jakarta.servlet.http.HttpSession;
import project.dto.ProjectDTO;
import project.service.ProjectService;

@Controller
public class ApprovalRequestController {
	@Autowired
	private ApprovalRequestService approvalService;
	
	@Autowired
	private ProjectService projectService;
	
	@PostMapping("post_project_reject")
	public String InsertProjectReject(@RequestParam String content, 
			@RequestParam int project_seq) {

		ProjectDTO project_detail = projectService.getProjectDetail(project_seq);
		

		String user_account = project_detail.getAccount();

		int tmpCommission = 10;
		LocalDateTime req_date = LocalDateTime.now();
		
		ApprovalRequestDTO approvalDTO = new ApprovalRequestDTO();
		approvalDTO.setApproval_reason(content);
		approvalDTO.setApproval_status(1);
		approvalDTO.setManager_account(user_account);
		approvalDTO.setCommission(tmpCommission);
		approvalDTO.setApproval_req_date(req_date);
		approvalDTO.setProject_seq(project_seq);
		
		

		approvalService.insertApprovalReject(approvalDTO);
		approvalService.updateProjectApprovalStatus(project_seq);
		
		
		
		return "redirect:project_approve_list";
	}
	@GetMapping("project_approve_accept/{project_seq}")
	public String AcceptProjectApprove(Model model, 
			@PathVariable("project_seq") int project_seq, HttpSession session) {
		
		ProjectDTO project_detail = projectService.getProjectDetail(project_seq);
		

		String user_account = project_detail.getAccount();

		int tmpCommission = 10;
		LocalDateTime req_date = LocalDateTime.now();
		
		ApprovalRequestDTO approvalDTO = new ApprovalRequestDTO();
		approvalDTO.setApproval_status(3);
		approvalDTO.setManager_account(user_account);
		approvalDTO.setCommission(tmpCommission);
		approvalDTO.setApproval_req_date(req_date);
		approvalDTO.setProject_seq(project_seq);
		
		approvalService.insertAcceptRequest(approvalDTO);
		approvalService.updateProjectAcceptApprovalStatus(project_seq);
		
		return "redirect:/project_approve_list";
	}
	
}
