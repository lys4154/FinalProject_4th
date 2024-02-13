package funding.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.JsonNode;

import funding.dto.FundingDTO;
import funding.service.FundingService;
import jakarta.servlet.http.HttpSession;
import member.dto.MemberDTO;
import member.service.MemberService;

@Controller
public class FundingController {
	
	@Autowired
	FundingService fundingService;
	@Autowired
	MemberService memberService;
	
	@RequestMapping("/patronmanagement")
	public String patronManagement() {
		return "funding/patronmanagement";
	}
	
	@GetMapping("/payment")
	public ModelAndView payment(HttpSession session) {
		int userSeq = (int)session.getAttribute("login_user_seq");
		MemberDTO dto = memberService.loginMemberSeq(userSeq);
		ModelAndView mv = new ModelAndView();
		mv.addObject("dto", dto);
		mv.setViewName("funding/payment");
		return mv;
	}
	
	@PostMapping("/payment")
	@ResponseBody
	public int receivePaymentInfo(@RequestBody List<Map<String,Object>> list, HttpSession session) {
		session.setAttribute("paymentList", list);
		return 0;
	}
	
	
	@PostMapping("/payresult")
	public String payResult(FundingDTO dto, HttpSession session) {
		List<Map<String,Object>> list = (List<Map<String,Object>>)session.getAttribute("paymentList");
		HashMap<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("dto", dto);
		int result = fundingService.insertFunding(map);
		return "funding/payresult";
	}
	
	@RequestMapping("/cardpay")
	public String cardPay() {
		return "funding/cardpay";
	}
	
	@RequestMapping("/cashpay")
	public String cashPay() {
		return "funding/cashpay";
	}
}
