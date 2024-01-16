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
	


}
