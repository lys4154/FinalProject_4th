package member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpSession;
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
			session.setAttribute("login_user_name", "테스트용 이름");
			session.setAttribute("login_user_seq", "");
			
			System.out.println("return 전 from: " + from);
			if(from.equals("mainpage")) {
				System.out.println("메인페이지 from: " + from);
				return "redirect:/";
			}
			System.out.println("메인페이지 이외 from: " + from);
			return "redirect:/" + from;
		}else {
			m.addAttribute("fail_id", id);
			m.addAttribute("result", "실패");
			return "member/login";
		}
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
}
