package approvalRequest.dto;

import java.time.LocalDateTime;

import org.springframework.stereotype.Component;

@Component
public class ApprovalRequestDTO {
	private int manager_seq;

    private int project_seq;
    private int approval_status;
    private String approval_reason;
    private String manager_account;
    private int commission;
    private LocalDateTime approval_req_date;
    private LocalDateTime evaluation_date;
	public int getManager_seq() {
		return manager_seq;
	}
	public void setManager_seq(int manager_seq) {
		this.manager_seq = manager_seq;
	}

	public int getProject_seq() {
		return project_seq;
	}
	public void setProject_seq(int project_seq) {
		this.project_seq = project_seq;
	}
	public int getApproval_status() {
		return approval_status;
	}
	public void setApproval_status(int approval_status) {
		this.approval_status = approval_status;
	}
	public String getApproval_reason() {
		return approval_reason;
	}
	public void setApproval_reason(String approval_reason) {
		this.approval_reason = approval_reason;
	}
	public String getManager_account() {
		return manager_account;
	}
	public void setManager_account(String manager_account) {
		this.manager_account = manager_account;
	}
	public int getCommission() {
		return commission;
	}
	public void setCommission(int commission) {
		this.commission = commission;
	}
	public LocalDateTime getApproval_req_date() {
		return approval_req_date;
	}
	public void setApproval_req_date(LocalDateTime approval_req_date) {
		this.approval_req_date = approval_req_date;
	}
	public LocalDateTime getEvaluation_date() {
		return evaluation_date;
	}
	public void setEvaluation_date(LocalDateTime evaluation_date) {
		this.evaluation_date = evaluation_date;
	}
    
    
    
    
}
