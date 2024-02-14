package project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.dao.ItemDAO;
import project.dao.ProjectDibsDAO;
import project.dto.ItemDTO;

@Service
public class ProjectDibsService {
	
	@Autowired
	private ProjectDibsDAO dibsDao;

	//관심 목록
	public List<Integer> dibsList(int memberSeq) {
		return dibsDao.dibsList(memberSeq);
	}

	//관심 프로젝트 - 취소
	public int dibsCancel(int projectSeq, int memberSeq) {
		return dibsDao.dibsCancel(projectSeq, memberSeq);
	}

	public String addDibs(int member_seq, int project_seq) {
		int result2 = dibsDao.selectdibs(member_seq, project_seq);
		if(result2 >= 1) {
			int result = dibsDao.dibsCancel(project_seq, member_seq);
			if(result == 0) {
				return "오류";
			}else {
				return "취소";
			}
		}
		int result = dibsDao.insertProjectDibs(member_seq, project_seq);
		if(result == 0) {
			return "오류";
		}else {
			return "성공";
		}
	}

	
	public int selectdibs(int member_seq, int project_seq) {
		return dibsDao.selectdibs(member_seq, project_seq);
	}
	


}
