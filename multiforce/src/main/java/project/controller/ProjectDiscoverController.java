package project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import project.dto.ProjectDTO;
import project.service.ProjectDiscoverService;
import project.service.ProjectService;

@Controller
public class ProjectDiscoverController {
	
	@Autowired
	ProjectService projectService;
	@Autowired
	ProjectDiscoverService discoverService;
	
	@GetMapping("/discover")
	public ModelAndView projectDiscover() {
		List<ProjectDTO> list = projectService.getAllApprovedProjects();
		ModelAndView mv = new ModelAndView();
		mv.addObject("list", list);
		mv.setViewName("project/project_discover");
		return mv;
	}
}
