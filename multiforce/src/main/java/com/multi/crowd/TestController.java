package com.multi.crowd;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TestController {
	
	@GetMapping("/")
	public String mainpage() {
		return "common/mainpage";
	}
	
	@GetMapping("/login")
	public String login() {
		return "member/login";
	}
	
}
