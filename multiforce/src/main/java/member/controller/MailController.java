package member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import member.dto.MemberDTO;
import member.service.MailService;
import member.service.MemberService;

@Controller
public class MailController {
	
	@Autowired
	MailService mailService;
	@Autowired
	MemberService memberService;
	
	@PostMapping(value="/mailauth", produces = {"application/json;charset=utf-8"})
	@ResponseBody String mailAuth(String email) {
		//중복된 이메일이 있는가 없는가 확인 후 없으면 메일 보내기 있으면 있다고
		MemberDTO result = memberService.emailDupCheck(email);
		boolean isUniqueEmail = false;
		//중복된 이메일이 없다
		if(result == null) {
			isUniqueEmail = true;
			String authCode = mailService.sendAuthEmail(email);
			return "{"
			+ "\"authCode\": \"" + authCode + "\","
			+ "\"isUniqueEmail\": \"" + isUniqueEmail + "\""
			+ "}";
		//중복된 이메일이 있다
		}else {
			isUniqueEmail = false;
			return "{\"isUniqueEmail\": \"" + isUniqueEmail + "\"}";
		}
	}
	
	@PostMapping(value="/findid", produces = {"application/json;charset=utf-8"})
	@ResponseBody
	public String findIdProcess(String email) {
		String result = mailService.sendIdEmail(email);
		return "{\"result\": \"" + result + "\"}";
	}
	
	@PostMapping(value="/resetpw", produces = {"application/json;charset=utf-8"})
	@ResponseBody
	public String resetPwProcess(String email, String id) {
		String result = mailService.sendTempPwEmail(email, id);
		return "{\"result\": \"" + result + "\"}";
	}
	
}
