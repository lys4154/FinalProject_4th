package board.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ProfileController {
	
	@GetMapping("/profile")
	public String profile() {
		
		return "member/profile";
	}
	
	
	@GetMapping("/myprofile")
	public String myprofile() {
		
		return "member/myprofile";
	}
	
	
	
	@GetMapping("/funded")
	public String funded() {
		
		return "member/funded";
	}	
	
	
	@GetMapping("/funded_detail")
	public String funded_detail() {
		
		return "member/funded_detail";
	}
	
	
	
	@GetMapping("/mydibs")
	public String mydibs() {
		
		return "member/mydibs";
	}
	
	
	
	
	@GetMapping("/follow")
	public String follow() {
		
		return "member/follow";
	}
	


	
	
}
