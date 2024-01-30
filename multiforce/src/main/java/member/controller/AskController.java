package member.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import member.dto.AskDTO;
import member.service.AskService;

@Controller
public class AskController {
	@Autowired
	AskService askService;
	
	@GetMapping("/ask")
	public ModelAndView ask(int project_seq, int collector_seq, int asker_seq) {
		ModelAndView mv = new ModelAndView();
		AskDTO dto = askService.selectChatRoom(project_seq, collector_seq, asker_seq);
		if(dto.getChatroom_seq() == 0) {
			dto.setCollector_seq(collector_seq);
			dto.setProject_seq(project_seq);
			dto.setAsker_seq(asker_seq);
			System.out.println(dto);
			mv.addObject("dto", dto);
			mv.addObject("result", "채팅기록 없음");
		}else {
			mv.addObject("dto", dto);
			mv.addObject("result", "채팅기록 있음");
		}
		mv.setViewName("member/ask");
		return mv;
	}
	
	@PostMapping(value="/insertmyfirstchat", produces = {"application/json;charset=utf-8"})
	@ResponseBody
	public HashMap<String, Object> insertMyFirstChat(int project_seq, int collector_seq, int asker_seq, String my_chat){
		HashMap<String, Object> map = askService.insertMyFirstChat(project_seq, collector_seq, asker_seq, my_chat);
		//채팅방 번호도 같이 return 해줘야함
		return map;
	}
	
	@PostMapping(value="/insertmychat", produces = {"application/json;charset=utf-8"})
	@ResponseBody
	public String insertMyTalk(String who_am_i, String my_chat, int chatroom_seq, int read_at){
		int result = askService.insertMyChat(who_am_i, my_chat, chatroom_seq, read_at);
		return"{\"result\":\"" + result +"\"}";
	}
}
