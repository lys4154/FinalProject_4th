package approvalRequest.dao;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import approvalRequest.dto.ApprovalRequestDTO;

@Repository
@Mapper
public interface ApprovalRequestDAO {

	void insertApprovalReject(ApprovalRequestDTO dto);

	void updateProjectApprovalStatus(int project_seq);

	void insertAcceptRequest(ApprovalRequestDTO approvalDTO);

	void updateProjectAcceptApprovalStatus(int project_seq);

}
