package project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.dao.ProjectDAO;
import project.dto.ProjectDTO;

@Service
public class ProjectDiscoverService {
	
	@Autowired
	ProjectDAO projectDao;
	
	/* <분류 기준>
	 * 인기의 기준??
	 * 최신순: 시작일자 빠른 것
	 * 최다 후원금순: 후원금 많은 순
	 * 최다 후원자순: 후원자 많은 순
	 */
	//일단은 카테고리 전체 정렬 순서는 최신순
	public List<ProjectDTO> projectDiscover(){
		List<ProjectDTO> list = projectDao.getAllApprovedProjectsOrderByStartDate();
		return list;
	}
}
