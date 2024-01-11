package project.dao;


import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;



import project.dto.ProjectDTO;

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

	//후원 페이지 - 검색
	List<ProjectDTO> searchFunded(String searchKeyword, int memberSeq);
	
	//전체 프로젝트
	List<ProjectDTO> getAllProjects();

	//후원한 프로젝트 페이지 -> 후원 내역 상세
	ProjectDTO getProjectDetail(int projectSeq);

	//only 승인
	List<ProjectDTO> getAllApprovedProjects();
	
	//only 승인 대기
	List<ProjectDTO> getAllUnapprovedProjects();
	
	//승인된 프로젝트 개수
	int approvedCount();
	
	//승인 대기 프로젝트 개수
	int unapprovedCount();
	
	


}
