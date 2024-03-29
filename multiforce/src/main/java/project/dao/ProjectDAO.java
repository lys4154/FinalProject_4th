package project.dao;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import member.dto.MemberDTO;
import project.dto.ProjectDTO;
import project.dto.ProjectDiscoverDTO;
import project.dto.ProjectMemberDTO;

@Repository
@Mapper
public interface ProjectDAO {

	List<ProjectDTO> getProjectsByMemberSeq(int memberSeq);

	//후원 페이지 - 진행중
	List<ProjectDTO> ongoingProject(List<Integer> ongoingProjectSeq);
	
	//후원 페이지 - 성공
	List<ProjectDTO> successProject(List<Integer> successProjectSeq);

	//후원 페이지 - 취소
	List<ProjectDTO> cancelProject(List<Integer> cancelProjectSeq);
	
	//전체 프로젝트
	List<ProjectDTO> getAllProjects();

	//후원한 프로젝트 페이지 -> 후원 내역 상세
	ProjectMemberDTO getProjectDetail(int projectSeq);

	//only 승인
	List<ProjectDTO> getAllApprovedProjects();
	
	//only 승인 대기
	List<ProjectDTO> getAllUnapprovedProjects();
	
	//승인된 프로젝트 개수
	int approvedCount();
	
	//승인 대기 프로젝트 개수
	int unapprovedCount();
	
	//관심 프로젝트 - 전체
	List<ProjectMemberDTO> myDibsProject(List<Integer> dibsList);
	
	//관심 프로젝트 - 진행중
	List<ProjectMemberDTO> dibsOngoing(List<Integer> projectSeqArray);
	
	//승인된 프로젝트 + 시작날짜 기준 최신순으로 정렬해서 들고오기
	List<ProjectDTO> getAllApprovedProjectsOrderByStartDate();

	//찜한 프로젝트 - 종료된
	List<ProjectMemberDTO> dibsEnd(List<Integer> projectSeqArray);

	// 프로젝트 작성
	void insertProject(ProjectDTO project);
	
	//member_seq불러오기
	Integer getMember_seq(String member_id);
	

	
	// 프로젝트 불러오기
	List<ProjectDTO> getProject(int memberSeq);

	//마이프로필 - 팔로워의 올린프로젝트 찾기
	int getProjectCount(Integer followerSeq);

	//관심 프로젝트 - 관심 취소
	int dibsDelete(int projectSeq);
	
	//프로젝트 실패 업데이트
	int projectFailUpdate();
	// 성공업데이트
	int projectSuccessUpdate();
	//시작 업데이트
	int projectStartUpdate();
	//내가 올린 프로젝트 - 작성중
	List<ProjectDTO> writeIncomplete(int memberSeq);

	//내가 올린 프로젝트 - 심사중
	List<ProjectDTO> requestApproval(int memberSeq);

	//내가 올린 프로젝트 - 반려
	List<ProjectDTO> requestReject(int memberSeq);

	//내가 올린 프로젝트 - 승인완료
	List<ProjectDTO> requestAdmit(int memberSeq);

	//내가 올린 프로젝트 - 진행중
	List<ProjectDTO> fundingStart(int memberSeq);

	//내가 올린 프로젝트 - 펀딩 실패
	List<ProjectDTO> fundingFailed(int memberSeq);

	//내가 올린 프로젝트 - 펀딩 성공
	List<ProjectDTO> fundingSuccess(int memberSeq);

	//내가 올린 프로젝트 - 종료
	List<ProjectDTO> fundingComplete(int memberSeq);

	//내가 올린 프로젝트 - 삭제
	int projectDelete(int projectSeq);
	
	//펀딩계획
	void insertFundingPlan(ProjectDTO fundingPlan);
	
	void insertProjectPlan(ProjectDTO projectPlan);
	
	//project_seq 가져오기
	Integer getProject_seq(int member_seq);

	List<ProjectMemberDTO> selectSupporterFundFail(int project_seq);
	List<Integer> selectDibsFundStart(int project_seq);
	List<ProjectMemberDTO> selectCollectorFundFail();

	List<ProjectMemberDTO> selectCollectorFundSuccess();

	List<ProjectMemberDTO> selectCollectorFundstart();

	List<Integer> selectFollowerFundStart(int member_seq);

	List<ProjectMemberDTO> selectDidsFundEnd();

	ProjectMemberDTO selectProjectMember(int project_seq);

	//회원탈퇴 - 프로젝트삭제
	int unregisterProjectDelete(int memberSeq);

	//내가 올린 프로젝트 - 전체
	List<ProjectDTO> getAllProjectsMemberSeq(int memberSeq);
	
	//조회수 증가
	int updateViewCount(int project_seq);

	int rejectedCount();

	List<ProjectDTO> getAllRejectedProject();


	List<ProjectDTO> getApprovedProjectsPage(int offset, int pageSize);

	List<ProjectDTO> getUnapprovedProjectsPage(int offset, int pageSize);

	List<ProjectDTO> getRejectedProjectsPage(int offset, int pageSize);

	ProjectDTO getProjectMember(String url);

	String getRejectReason(int project_seq);

	//메인페이지 - 업데이트 프로젝트
	List<ProjectMemberDTO> newUpdateProject();
	
	//메인페이지 - 인기 프로젝트
	List<ProjectMemberDTO> popularProject();

	int updateCollectionAmount(int projectSeq, int price);

	void updateDibsCount(int project_seq, int i);

	List<ProjectDTO> getSuccessIn7();

	//작성중이던 프로젝트 가져오기
	ProjectDTO loadProjectPlan(int project_seq);


}

