package member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpSession;
import member.dto.MemberDTO;
import member.service.MemberService;

@Controller
public class ProfileController {
	
	@Autowired
	@Qualifier("memberservice")
	private MemberService memberservice;
/*	
	@PostMapping ("/myprofile")
	public String loginMember (HttpSession session){
		String email = (String) session.getAttribute("email");	
//		session.setAttribute(email, "test1@test.com");
		MemberDTO loginMember = memberservice.loginMember(email);		
		ModelAndView mv = new ModelAndView();		
		mv.addObject("loginMember",loginMember);		

		return "member/myprofile";		
	}
*/

	
	@GetMapping("/profile")
	public String profile() {		
		return "member/profile";
	}
	
	
	//마이프로필 기본화면
	@GetMapping("/myprofile")
	public String myprofile() {		
		return "member/myprofile";
	}	


	//후원한 프로젝트
	@GetMapping("/funded")
	public String funded() {		
		return "member/funded";
	}	
	
	//후원 프로젝트 상세
	@GetMapping("/funded_detail")
	public String funded_detail() {		
		return "member/funded_detail";
	}
	
	
	//후원 취소
	@GetMapping("/funded_cancel")
	public String funded_cancel() {		
		return "member/funded_cancel";
	}
	
	
	//찜한 프로젝트
	@GetMapping("/mydibs")
	public String mydibs() {		
		return "member/mydibs";
	}
	
	
	
	//팔로우
	@GetMapping("/follow")
	public String follow() {		
		return "member/follow";
	}
	


	//회원정보수정
	@GetMapping("/settings")
	public String settings() {		
		return "member/settings";
	}
	

	//내가 올린 프로젝트
	@GetMapping("/myproject")
	public String myproject() {		
		return "member/myproject";
	}
	
	
}
