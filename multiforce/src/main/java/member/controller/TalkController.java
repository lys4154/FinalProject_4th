package member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import member.service.TalkService;

@Controller
public class TalkController {
	@Autowired
	TalkService talkService;
	
	@PostMapping("/talk")
	public ModelAndView talk(String login_user_seq) {
		ModelAndView mv = new ModelAndView();
		System.out.println(login_user_seq);
		mv.setViewName("member/talk");
		return mv;
	}
	
	@PostMapping(value="/insertmytalk", produces = {"application/json;charset=utf-8"})
	@ResponseBody
	public String insertMyTalk(String my_talk){
		int result = 0;//talkService.insertMyTalk;
		return"{\"result\":\"" + result +"\"}";
	}
}
