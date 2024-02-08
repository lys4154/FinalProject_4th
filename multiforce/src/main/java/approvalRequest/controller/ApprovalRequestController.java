package approvalRequest.controller;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import approvalRequest.dto.ApprovalRequestDTO;
import approvalRequest.service.ApprovalRequestService;
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
		
		int user = project_detail.getMember_seq();
		String user_account = project_detail.getAccount();

		int tmpCommission = 10;
		LocalDateTime req_date = LocalDateTime.now();
		
		ApprovalRequestDTO approvalDTO = new ApprovalRequestDTO();
		approvalDTO.setApproval_reason(content);
		approvalDTO.setManager_seq(user);
		approvalDTO.setApproval_status(1);
		approvalDTO.setManager_account(user_account);
		approvalDTO.setCommission(tmpCommission);
		approvalDTO.setApproval_req_date(req_date);
		approvalDTO.setProject_seq(project_seq);
		
		

		approvalService.insertApprovalReject(approvalDTO);
		
		
		
		return "boardwrite";
	}
	
}
