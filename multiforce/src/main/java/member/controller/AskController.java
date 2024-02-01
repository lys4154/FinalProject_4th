package member.controller;

import java.util.HashMap;
import java.util.List;

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
	
	@PostMapping("/allask")
	public ModelAndView allAsk(int login_user_seq) {
		ModelAndView mv = new ModelAndView();
		HashMap<String, List<AskDTO>> map = askService.selectAllChatRoom(login_user_seq);
		mv.addObject("collector", map.get("collector"));
		mv.addObject("asker", map.get("asker"));
		mv.setViewName("member/all_ask");
		return mv;
	}
	
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
	public HashMap<String, Object> insertMyFirstChat(int project_seq, int collector_seq, int asker_seq,
			String my_chat, String last_chat){
		HashMap<String, Object> map = askService.insertMyFirstChat(project_seq, collector_seq, asker_seq, my_chat, last_chat);
		//채팅방 번호도 같이 return 해줘야함
		return map;
	}
	
	@PostMapping(value="/insertmychat", produces = {"application/json;charset=utf-8"})
	@ResponseBody
	public String insertMyChat(String who_am_i, String my_chat, int chatroom_seq, int read_at, String last_chat){
		int result = askService.insertMyChat(who_am_i, my_chat, chatroom_seq, read_at, last_chat);
		System.out.println("result: " + result);
		return"{\"result\":\"" + result +"\"}";
	}
	
	@PostMapping(value="/updatemyread", produces = {"application/json;charset=utf-8"})
	@ResponseBody
	public String updateMyRead(String who_am_i, int chatroom_seq, int read_at){
		int result = askService.updateMyRead(who_am_i, chatroom_seq, read_at);
		System.out.println("result: " + result);
		return"{\"result\":\"" + result +"\"}";
	}
	
	@PostMapping(value="/findchatroom", produces = {"application/json;charset=utf-8"})
	@ResponseBody
	public AskDTO findChatroom(String who_am_i, int chatroom_seq){
		AskDTO dto = askService.findChatroom(who_am_i, chatroom_seq);
		return dto;
	}
}
