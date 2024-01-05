package funding.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class FundingController {

	@RequestMapping("/patronmanagement")
	public String patronManagement() {
		return "funding/patronmanagement";
	}
	
	@RequestMapping("/payment")
	public String payment() {
		return "funding/payment";
	}
	
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
