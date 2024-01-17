package approvalRequest.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import approvalRequest.dao.ApprovalRequestDAO;
import approvalRequest.dto.ApprovalRequestDTO;
import board.dto.BoardDTO;

@Service
public class ApprovalRequestService {
	@Autowired
	private ApprovalRequestDAO approvalRequestDAO;
	
	public void insertApprovalReject(ApprovalRequestDTO dto) {
		approvalRequestDAO.insertApprovalReject(dto);
    }
}
