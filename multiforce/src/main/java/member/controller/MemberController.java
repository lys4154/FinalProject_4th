package member.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpSession;
import member.dto.MemberDTO;
import member.service.MemberService;
import project.service.ProjectDibsService;


@Controller
public class MemberController {
	
	@Autowired
	MemberService memberService;
	@Autowired
	ProjectDibsService dibsService;

	@GetMapping("/login")
	public String login() {
		return "member/login";
	}
	
	@PostMapping("/login")
	public String loginProcess(String id, String pw, String from, HttpSession session, Model m) {
	
		MemberDTO result = memberService.loginProcess(id, pw);
		if(result != null) {
			//김소영 추가, 탈퇴날짜 있으면 로그인 불가
            if (result.getResign_date() != null) {
                m.addAttribute("fail_id", id);
                m.addAttribute("result", "실패");
                return "member/login";
            }
			
			session.setAttribute("login_user_id", result.getMember_id());
			session.setAttribute("login_user_level", result.getLevel());
			session.setAttribute("login_user_name", result.getMember_name());
			session.setAttribute("login_user_seq", result.getMember_seq());
			session.setAttribute("login_user_nickname", result.getNickname());
			session.setAttribute("login_user_img", result.getProfile_img());

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
		boolean isUniqueId = false;
		MemberDTO result = memberService.idDupCheck(id);
		if(result != null) {
			isUniqueId = false;
		}else {
			isUniqueId = true;
		}
		return "{\"isUniqueId\": \"" + isUniqueId + "\"}";
	}
	
	@PostMapping("/nicknamedupcheck")
	@ResponseBody
	public String nicknameDupCheck(String nickname) {
		boolean isUniqueNickname = false;
		MemberDTO result = memberService.nicknameDupCheck(nickname);
		if(result != null) {
			isUniqueNickname = false;
		}else {
			isUniqueNickname = true;
		}
		return "{\"isUniqueNickname\": \"" + isUniqueNickname + "\"}";
	}
	
	@PostMapping("/welcome")
	public String enrollMember(MemberDTO dto, Model m){
		int result = memberService.signUp(dto);
		if(result == 1) {
			m.addAttribute("result", "true");
			m.addAttribute("member_name", dto.getMember_name());
			return "member/welcome";
		}else {
			m.addAttribute("result", "false");
			return "member/welcome";
		}
	}

	@GetMapping("/findid")
	public String findId() {
		return "member/find_id";
	}
	
	@GetMapping("/resetpw")
	public String resetPw() {
		return "member/reset_pw";
	}
	
	
}
