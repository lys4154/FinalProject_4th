package member.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpSession;
import member.dto.MemberDTO;
import member.service.MemberService;


@Controller
public class MemberController {
	

	@Autowired
	MemberService memberService;

	
	@GetMapping("/login")
	public String login() {
		return "member/login";
	}
	
	@PostMapping("/login")
	public String loginProcess(String id, String pw, String from, HttpSession session, Model m) {
	
		if(id.equals("test") && pw.equals("1234")) {
			session.setAttribute("login_user_id", id);
			session.setAttribute("login_user_level", 1);
			session.setAttribute("login_user_name", "일반회원");
			session.setAttribute("login_user_seq", "");
			if(from.equals("mainpage")) {
				return "redirect:/";
			}
			return "redirect:/" + from;
		}else if(id.equals("admin") && pw.equals("1234")) {
			session.setAttribute("login_user_id", id);
			session.setAttribute("login_user_level", 2);
			session.setAttribute("login_user_name", "관리자용");
			session.setAttribute("login_user_seq", "");
			if(from.equals("mainpage")) {
				return "redirect:/";
			}
			return "redirect:/" + from;
		}else {
			m.addAttribute("fail_id", id);
			m.addAttribute("result", "실패");
			return "member/login";
		}
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("login_user_id");
		session.removeAttribute("login_user_level");
		session.removeAttribute("login_user_name");
		session.removeAttribute("login_user_seq");
		
		return "redirect:/";
	}
	
	@GetMapping("/signup")
	public String signUp() {
		return "member/sign_up";
	}
	
	@PostMapping("/iddupcheck")
	@ResponseBody
	public String idDupCheck(String id) {
		boolean isUniqueId = true;
		if(id.equals("testid")) {
			isUniqueId = false;
		}else {
			isUniqueId = true;
		}
		return "{\"isUniqueId\": \"" + isUniqueId + "\"}";
	}
	
	@PostMapping("/nicknamedupcheck")
	@ResponseBody
	public String nicknameDupCheck(String nickname) {
		boolean isUniqueNickname = true;
		if(nickname.equals("testnn")) {
			isUniqueNickname = false;
		}else {
			isUniqueNickname = true;
		}
		return "{\"isUniqueNickname\": \"" + isUniqueNickname + "\"}";
	}
	
	@PostMapping("/welcome")
	public ModelAndView welcome(MemberDTO dto) {
		System.out.println(dto.getAddress());
		System.out.println(dto.getEmail());
		System.out.println(dto.getMember_id());
		System.out.println(dto.getMember_name());
		System.out.println(dto.getNickname());
		System.out.println(dto.getPassword());
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("member_name", dto.getMember_name());
		mv.setViewName("member/welcome");
		return mv;
	}
	
	@GetMapping("/findid")
	public String findId() {
		return "member/find_id";
	}
	
	
}
