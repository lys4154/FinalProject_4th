package approvalRequest.controller;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import approvalRequest.dto.ApprovalRequestDTO;
import approvalRequest.service.ApprovalRequestService;

@Controller
public class ApprovalRequestController {
	@Autowired
	private ApprovalRequestService approvalService;
	
	@PostMapping("post_project_reject")
	public String InsertProjectReject(@RequestParam String content, 
			@RequestParam String project_seq) {
		System.out.println("APPROVAL");
		int tmpUser = 1;
		int tmpManager = 2;
		String tmpManagerAccount = "23423423";
		int tmpCommission = 3;
		LocalDateTime tmpDate = LocalDateTime.of(2024, 1, 16, 12, 34, 56);
		
		ApprovalRequestDTO approvalDTO = new ApprovalRequestDTO();
		approvalDTO.setApproval_reason(content);
		approvalDTO.setManager_seq(tmpManager);
		approvalDTO.setApproval_status(1);
		approvalDTO.setMember_seq(tmpUser);
		approvalDTO.setManager_account(tmpManagerAccount);
		approvalDTO.setCommission(tmpCommission);
		approvalDTO.setApproval_req_date(tmpDate);
		
		
		System.out.println("APPROVAL");
		approvalService.insertApprovalReject(approvalDTO);
		
		
		
		return "boardwrite";
	}
	
}
