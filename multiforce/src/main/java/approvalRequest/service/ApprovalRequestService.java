package approvalRequest.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import approvalRequest.dao.ApprovalRequestDAO;

@Service
public class ApprovalRequestService {
	@Autowired
	private ApprovalRequestDAO approvalRequestDAO;
	
	
}
