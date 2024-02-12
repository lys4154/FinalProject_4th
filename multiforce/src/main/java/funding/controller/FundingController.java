package funding.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.JsonNode;

import funding.dto.FundingDTO;
import funding.service.FundingService;

@Controller
public class FundingController {
	
	@Autowired
	FundingService fundingService;
	
	@RequestMapping("/patronmanagement")
	public String patronManagement() {
		return "funding/patronmanagement";
	}
	
	@GetMapping("/payment")
	public ModelAndView payment() {
		
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("funding/payment");
		return mv;
	}
	
//	@PostMapping("/payment")
//	@ResponseBody
//	public JsonNode receivePaymentInfo() {
//		return null;
//	}
	
	
	@RequestMapping("/payresult")
	public String payResult() {
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
