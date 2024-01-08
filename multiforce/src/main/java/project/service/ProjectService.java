package project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import member.dao.MemberDAO;
import member.dto.MemberDTO;
import project.dao.ProjectDAO;
import project.dto.ProjectDTO;

@Service
public class ProjectService {
	
	@Autowired
	private ProjectDAO projectDao;

	public List<ProjectDTO> getProjectsByMemberSeq(int memberSeq) {
		return projectDao.getProjectsByMemberSeq(memberSeq);
	}
	



}
