package funding.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class FundingController {

	@RequestMapping("/patronmanagement")
	public String patronManagement() {
		return "funding/PatronManagement";
	}
	
	@RequestMapping("/payment")
	public String payment() {
		return "funding/Payment";
	}
	
	@RequestMapping("/payresult")
	public String payResult() {
		return "funding/PayResult";
	}
}
