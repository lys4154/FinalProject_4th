package project.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oracle.wls.shaded.org.apache.regexp.recompile;

import jakarta.servlet.http.HttpSession;
import member.dto.MemberDTO;
import project.dao.ProjectDAO;
import project.dto.ProjectDTO;
import project.dto.ProjectMemberDTO;

@Service
public class ProjectService {
	
	@Autowired
	private ProjectDAO projectDao;

	public List<ProjectDTO> getProjectsByMemberSeq(int memberSeq) {
		return projectDao.getProjectsByMemberSeq(memberSeq);
	}
	

	public List<ProjectDTO> getAllProjects() {
        return projectDao.getAllProjects(); 
    }
	
	public List<ProjectDTO> getAllApprovedProjects() {
        return projectDao.getAllApprovedProjects(); 
    }
	
	public List<ProjectDTO> getAllUnapprovedProjects() {
        return projectDao.getAllUnapprovedProjects(); 
    }
	
	//반려이유 가져오기
	public String getRejectReason(int project_seq) {
		System.out.println("Reason:"+projectDao.getRejectReason(project_seq));
		return projectDao.getRejectReason(project_seq);
	}
	
	//승인 프로젝트 개수
	public int approvedCount() {
		return projectDao.approvedCount();
	}
		
	//승인 프로젝트 개수
	public int unapprovedCount() {
		return projectDao.unapprovedCount();
	}

	//후원 페이지 - 진행중
	public List<ProjectDTO> ongoingProject(List<Integer> ongoingProjectSeq) {
		return projectDao.ongoingProject(ongoingProjectSeq);
	}

	//후원 페이지 - 성공
	public List<ProjectDTO> successProject(List<Integer> successProjectSeq) {
		return projectDao.successProject(successProjectSeq);
	}

	//후원 페이지 - 취소
	public List<ProjectDTO> cancelProject(List<Integer> cancelProjectSeq) {
		return projectDao.cancelProject(cancelProjectSeq);
	}
	
	//후원 페이지 - 검색
	public List<ProjectDTO> searchFunded(String searchKeyword, int memberSeq) {
		return projectDao.searchFunded(searchKeyword, memberSeq);		
	}

	//후원한 프로젝트 페이지 -> 후원 내역 상세
	public ProjectMemberDTO getProjectDetail(int projectSeq) {
		return projectDao.getProjectDetail(projectSeq);
	}

	//관심 프로젝트 - 전체
	public List<ProjectMemberDTO> myDibsProject(List<Integer> dibsList) {
		return projectDao.myDibsProject(dibsList);
	}

	//관심 프로젝트 - 진행중
	public List<ProjectMemberDTO> dibsOngoing(List<Integer> projectSeqArray) {
		return projectDao.dibsOngoing(projectSeqArray);
	}

	//찜한 프로젝트 - 종료된
	public List<ProjectMemberDTO> dibsEnd(List<Integer> projectSeqArray) {
		return projectDao.dibsEnd(projectSeqArray);
	}

	//마이프로필 - 팔로워의 올린프로젝트 찾기
	public int getProjectCount(Integer followerSeq) {
		return projectDao.getProjectCount(followerSeq);
	}


	//member_seq 받아오기
	
	// 프로젝트 생성
	public void createProject(ProjectDTO project, HttpSession session) {
		int member_seq = projectDao.getMember_seq((String)session.getAttribute("login_user_id"));
		project.setMember_seq(member_seq);
		System.out.println(project.getMember_seq());
        projectDao.insertProject(project);
    }
	
	public void createProjectPlan(ProjectDTO project, HttpSession session) {
		int member_seq = projectDao.getMember_seq((String)session.getAttribute("login_user_id"));
		int project_seq = projectDao.getProject_seq(member_seq);
		project.setProject_seq(project_seq);
		project.getProject_seq();
		System.out.println(project.getProject_seq());
		projectDao.insertProjectPlan(project);
	}

	//관심 프로젝트 - 관심 취소
	public int dibsDelete(int projectSeq) {
		return projectDao.dibsDelete(projectSeq);
	}
	
	// 프로젝트 불러오기
	public List<ProjectDTO> getProject(int memberSeq) {
        return projectDao.getProject(memberSeq);
    }

	//내가 올린 프로젝트 - 작성중
	public List<ProjectDTO> writeIncomplete(int memberSeq) {
		return projectDao.writeIncomplete(memberSeq);
	}

	//내가 올린 프로젝트 - 심사중
	public List<ProjectDTO> requestApproval(int memberSeq) {
		return projectDao.requestApproval(memberSeq);
	}


	//내가 올린 프로젝트 - 반려
	public List<ProjectDTO> requestReject(int memberSeq) {
		return projectDao.requestReject(memberSeq);
	}

	//내가 올린 프로젝트 - 승인완료
	public List<ProjectDTO> requestAdmit(int memberSeq) {
		return projectDao.requestAdmit(memberSeq);
	}


	//내가 올린 프로젝트 - 진행중
	public List<ProjectDTO> fundingStart(int memberSeq) {
		return projectDao.fundingStart(memberSeq);
	}

	//내가 올린 프로젝트 - 펀딩 실패
	public List<ProjectDTO> fundingFailed(int memberSeq) {
		return projectDao.fundingFailed(memberSeq);
	}


	//내가 올린 프로젝트 - 펀딩 성공
	public List<ProjectDTO> fundingSuccess(int memberSeq) {
		return projectDao.fundingSuccess(memberSeq);
	}

	//내가 올린 프로젝트 - 종료
	public List<ProjectDTO> fundingComplete(int memberSeq) {
		return projectDao.fundingComplete(memberSeq);
	}

	//내가 올린 프로젝트 - 삭제
	public int projectDelete(int projectSeq) {
		System.out.println("프로젝트 삭제 서비스 ");
		return projectDao.projectDelete(projectSeq);
	}
	
	// 펀딩계획 저장
	public void insertFundingPlan(ProjectDTO fundingPlan) {
        projectDao.insertFundingPlan(fundingPlan);
    }

	//회원탈퇴 - 프로젝트삭제
	public int unregisterProjectDelete(int memberSeq) {
		return projectDao.unregisterProjectDelete(memberSeq);
	}

	//내가 올린 프로젝트 - 전체
	public List<ProjectDTO> getAllProjectsMemberSeq(int memberSeq) {
		return projectDao.getAllProjectsMemberSeq(memberSeq);
	}



	public int rejectedCount() {
		return projectDao.rejectedCount();
	}


	public List<ProjectDTO> getAllRejectedProject() {
		return projectDao.getAllRejectedProject();
  }

	public int viewCountUpdate(int project_seq) {
		int result = projectDao.updateViewCount(project_seq);
		return result;
	}



	public List<ProjectDTO> getApprovedProjectsPage(int page, int pageSize) {
		int offset = page * pageSize;
		return projectDao.getApprovedProjectsPage(offset, pageSize);
	}
	
	public List<ProjectDTO> getUnapprovedProjects(int page, int pageSize) {
		int offset = page * pageSize;
		return projectDao.getUnapprovedProjectsPage(offset, pageSize);
	}

	public List<ProjectDTO> getRejectedProjectsPage(int page, int pageSize) {
		int offset = page * pageSize;
		return projectDao.getRejectedProjectsPage(offset, pageSize);
	}

	public ProjectDTO getProjectMember(int project_seq) {
		ProjectDTO dto = projectDao.getProjectMember(project_seq);
		return dto;

	}



}
