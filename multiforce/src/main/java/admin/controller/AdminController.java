package admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AdminController {
	
	@GetMapping("/event")
	public ModelAndView event() {
		ModelAndView mv = new ModelAndView();
		//이벤트 게시물 dto list를 모델로 넣어주기 
		mv.setViewName("admin/event");
		return mv;
	}
}
