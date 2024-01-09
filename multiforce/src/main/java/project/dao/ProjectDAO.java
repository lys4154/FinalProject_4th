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
	
}
