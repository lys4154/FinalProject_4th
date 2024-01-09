package project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import project.dao.ProjectDAO;
import project.dto.ProjectDTO;

@Service
public class ProjectService {
	
	@Autowired
	private ProjectDAO projectDao;

	public List<ProjectDTO> getProjectsByMemberSeq(int memberSeq) {
		return projectDao.getProjectsByMemberSeq(memberSeq);
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
	
	
	


}
