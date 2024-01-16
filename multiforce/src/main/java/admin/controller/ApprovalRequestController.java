package admin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import approvalRequest.dto.ApprovalRequestDTO;
import approvalRequest.service.ApprovalRequestService;

@Controller
public class ApprovalRequestController {
	@Autowired
	private ApprovalRequestService ApprovalService;
	
	@PostMapping("project_reject")
	public String InsertProjectReject(@RequestParam String content, 
			@RequestParam String project_seq) {
		
		int tmpUser = 1;
		ApprovalRequestDTO approvalDTO = new ApprovalRequestDTO();
		approvalDTO.setApproval_reason(content);
		approvalDTO.setMember_seq(tmpUser);
		
		
		return null;
	}
	
}
