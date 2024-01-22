package project.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.dao.ProjectDAO;
import project.dao.ProjectDiscoverDAO;
import project.dto.ProjectDTO;
import project.dto.ProjectDiscoverDTO;

@Service
public class ProjectDiscoverService {
	
	@Autowired
	ProjectDAO projectDao;
	@Autowired
	ProjectDiscoverDAO discoverDao;

	public List<ProjectDiscoverDTO> discoverProjects(String category, String query, 
			String column, int process, int start, int projectNumber, int step) {
		List<ProjectDiscoverDTO> list = null;
		String ascOrDesc = "";
		if(column.equals("due_date")) {
			ascOrDesc = "asc";
		}else {
			ascOrDesc = "desc";
		}
		
		if(category.equals("all")) {
			//select * where long_title like concat("%",#{query},"%") and 
			//ex)인기순, 등록순, 마감일자순
			//인기순 조회수 컬럼 order by desc => 쿼리로 해결
			//process순으로 4,3,6,5 순서
			//카테고리 있냐 없냐, process 있냐 없냐
			if(process == 0) {
				//쿼리에 4넣고 땡겨오고 size()<불러올 갯수가 되면 3에서 땡겨오고 6에서 땡겨오고
				list = sortByprocess(query, column, start, projectNumber, ascOrDesc, step, null);
				
			}else {
				list = discoverDao.dicoverAllProjects(query, column, ascOrDesc, projectNumber, start, process);
			}
		}else {
			if(process == 0) {
				list = sortByprocess(query, column, start, projectNumber, ascOrDesc, step, category);
			}else {
				list = discoverDao.discoverProjectsWithCategory(query, column, ascOrDesc, projectNumber, start, process, category);
			}
			
		}
		
		return list;
	}

	public int countProjects(String category, String query, int process) {
		int count = 0;
		if(category.equals("all")) {
			if(process == 0) {
				count = discoverDao.countAllProjects(query);
			}else {
				count = discoverDao.countProjectsWithProcess(query, process);
			}
		}else {
			if(process == 0) {
				count = discoverDao.countAllProjectsWithCategory(query, category);
			}else {
				count = discoverDao.countProjectsWithCategoryProcess(query, process, category);
			}
		}
				
		return count;
	}
	
	private List<ProjectDiscoverDTO> sortByprocess(String query, String column, int start, int projectNumber, String ascOrDesc, int step,
			String category){
		List<ProjectDiscoverDTO> list = null;
		int idx = 0;
		Integer[] stepArr = {4,3,6,7,5};
		List<Integer> stepList = Arrays.asList(stepArr);
		idx = stepList.indexOf(step);
		while(true){
			if(category == null) {
				list = discoverDao.dicoverAllProjects(query, column, ascOrDesc, projectNumber, start, step);
			}else {
				list = discoverDao.discoverProjectsWithCategory(query, column, ascOrDesc, projectNumber, start, step, category);
			}
			
			if(list == null) {
				idx++;
				start = 0;
				if(stepArr.length == idx) {
					break;
				}
				step = stepArr[idx];	
			}else {
				start = 0;
				idx++;
				if(stepArr.length == idx) {
					break;
				}
				step = stepArr[idx];
				break;
			}
		}
		if(list != null && list.size() < projectNumber) {
			while(true) {
				List<ProjectDiscoverDTO> tmplist = null;
				if(category == null) {
					tmplist = discoverDao.dicoverAllProjects(query, column, ascOrDesc, projectNumber - list.size(), start, step);
				}else {
					tmplist = discoverDao.discoverProjectsWithCategory(query, column, ascOrDesc, projectNumber - list.size(), start, step, category);
				}
				for (int i = 0; i < tmplist.size(); i++) {
					list.add(tmplist.get(i));
					start++;
				}
				if(list.size() == projectNumber) {
					break;
				}else {
					idx++;
					if(stepArr.length == idx) {
						break;
					}
					step = stepArr[idx];
				}
			}
		}
		return list;
	}
	
	
	/*		if(step == 4) {
	list = discoverDao.dicoverAllProjects(query, column, ascOrDesc, projectNumber, start, 4);
	if(list != null) {
		flg = true;
		count = list.size();
	}
	if(list == null ||list.size() < 16) {
		step = 3;
	}
}

if(step == 3) {
	if(flg) {
		start = 0;
	}
	List<ProjectDTO> tmplist = 
			discoverDao.dicoverAllProjects(query, column, ascOrDesc, projectNumber - count, start, 3);
	if(list == null) {
		list = tmplist;
	}else {
		if(tmplist != null) {
			for (ProjectDTO projectDTO : tmplist) {
				list.add(projectDTO);
				count++;
			}
		}
	}
	
	if(list != null) {
		flg = true;
	}
	if(list == null ||list.size() < 16) {
		step = 6;
	}
	System.out.println("3리스트뽑아냄");
}
if(list == null || list.size() < 16 && step == 6) {
	if(flg) {
		start = 0;
	}
	List<ProjectDTO> tmplist = 
			discoverDao.dicoverAllProjects(query, column, ascOrDesc, projectNumber - count, start, 6);
	if(list == null) {
		list = tmplist;
	}else {
		if(tmplist != null) {
			for (ProjectDTO projectDTO : tmplist) {
				list.add(projectDTO);
				count++;
			}
		}
	}
	if(list != null) {
		flg = true;
	}
	System.out.println("6리스트뽑아냄");
	if(list == null ||list.size() < 16) {
		step = 7;
	}
}
if(list == null || list.size() < 16 && step == 7) {
	if(flg) {
		start = 0;
	}
	List<ProjectDTO> tmplist = 
			discoverDao.dicoverAllProjects(query, column, ascOrDesc, projectNumber - count, start, 7);
	if(list == null) {
		list = tmplist;
	}else {
		if(tmplist != null) {
			for (ProjectDTO projectDTO : tmplist) {
				list.add(projectDTO);
				count++;
			}
		}
	}
	if(list != null) {
		flg = true;
	}
	System.out.println("7리스트뽑아냄");
	if(list == null ||list.size() < 16) {
		step = 5;
	}
}
if(list == null || list.size() < 16 && step == 5) {
	if(flg) {
		start = 0;
	}
	List<ProjectDTO> tmplist = 
			discoverDao.dicoverAllProjects(query, column, ascOrDesc, projectNumber - count, start, 5);
	if(list == null) {
		list = tmplist;
	}else {
		if(tmplist != null) {
			for (ProjectDTO projectDTO : tmplist) {
				list.add(projectDTO);
				count++;
			}
		}
	}
	if(list != null) {
		flg = true;
	}
	
	System.out.println("5리스트뽑아냄");
}
*/
}
