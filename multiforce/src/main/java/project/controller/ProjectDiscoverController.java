package project.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import project.dao.ProjectDiscoverDAO;
import project.dto.ProjectDTO;
import project.dto.ProjectDiscoverDTO;
import project.service.ProjectDiscoverService;
import project.service.ProjectService;

@Controller
public class ProjectDiscoverController {
	
	@Autowired
	ProjectService projectService;
	@Autowired
	ProjectDiscoverService discoverService;
	@Autowired
	ProjectDiscoverDAO discoverDao;
	int projectNumber = 16;
	
	@GetMapping("/discover")
	public ModelAndView projectDiscover(String category, String query, String sort, String process) {
		//분류기준 카테고리, 검색어, 정렬 순서(인기순, 등록순, 마감일자순), 
		//기본 카테고리: 전체 / 쿼리: "" / 정렬: 인기 / 진행상황: 4(진행중), 3(예정), 6(성공)
		String column = "";
		int start = 0;
		
		if(sort == null || sort.equals("")) {
			sort = "popular";
		}
		if(sort.equals("popular")) {
			column = "view_count";
		}
		if(sort.equals("new")) {
			column = "start_date";
		}
		if(sort.equals("end")) {
			column = "due_date";
		}
		if(query == null) {
			query = "";
		}
		if(category == null || category.equals("")) {
			category = "all";
		}
		if(process == null || process.equals("")) {
			process = "0";
		}
		int parsedProcess = Integer.parseInt(process);
		int step = 4;
		HashMap<String, Object> resultMap 
			= discoverService.discoverProjects(category, query, column, parsedProcess, start, projectNumber, step);
		
		int count = discoverService.countProjects(category, query, parsedProcess);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("list", resultMap.get("list"));
		mv.addObject("category", category);
		mv.addObject("query", query);
		mv.addObject("sort", sort);
		mv.addObject("process", process);
		mv.addObject("projectNumber", projectNumber);
		mv.addObject("count", count);
		mv.addObject("step", resultMap.get("step"));
		mv.addObject("start", resultMap.get("start"));
		mv.setViewName("project/project_discover");
		
		return mv;
	}
	@PostMapping(value="/moreproject", produces = {"application/json;charset=utf-8"})
	@ResponseBody
	public List<ProjectDiscoverDTO> moreProject(String category, String query, String sort, int process, int start, int step){
		String column = "";
		if(sort.equals("popular")) {
			column = "view_count";
		}
		if(sort.equals("new")) {
			column = "start_date";
		}
		if(sort.equals("end")) {
			column = "due_date";
		}
		HashMap<String, Object> resultMap
			= discoverService.discoverProjects(category, query, column, process, start, projectNumber, step);
		
		return (List<ProjectDiscoverDTO>) resultMap.get("list");
	}
	
	@GetMapping("/projectdummy")
	public String createDummy() {
		int process = 0;
		int result = 0;
		for(int i = 0; i < 150; i++) {
			LocalDate date = LocalDate.now();
			int tmp = (int)((Math.random() - 0.5) * 2 * 15);
			int tmp2 = (int)((Math.random() + 1) * 10);
			LocalDate startDate = date.plusDays(tmp);
			LocalDate dueDate = startDate.plusDays(tmp2);
			String title = "테스트용 긴제목" + i;
			if(date.compareTo(startDate) < 0) {
				//시작 날짜가 오늘 이후 => 아직 안함
				process = 3;
			}else {
				if(date.compareTo(dueDate) < 0) {
					//종료 날짜가 오늘 이후 => 진행중
					process = 4;
				}else {
					//오늘 또는 그 이전 => 끝
					process = 6;
				}
			}
			String url = "임시url" + i;
			String category = "";
			if(i % 2 == 0) {
				category = "board_game";
			}else {
				category = "digital_game";
			}
			result += discoverDao.insertDummyProject(startDate.toString(), dueDate.toString(), process, url, category, title);
			System.out.println(result);
		}
		System.out.println(result);
		return "common/mainpage";
	}
}
