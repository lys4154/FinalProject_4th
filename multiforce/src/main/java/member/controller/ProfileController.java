package member.controller;


import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.javassist.compiler.ast.Member;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import funding.dto.FundingDTO;
import funding.service.FundingService;
import jakarta.servlet.http.HttpSession;
import member.dto.FollowDTO;
import member.dto.MemberDTO;
import member.service.FollowService;
import member.service.MemberService;
import project.dto.ProjectDTO;
import project.service.ProjectService;

@Controller
public class ProfileController {
	
	@Autowired
	private MemberService memberservice;
	@Autowired
	private ProjectService projectservice;
	@Autowired 
	private FundingService fundingservice;
	@Autowired
	private FollowService followservice;

	
	@GetMapping("/profile")
	public String profile() {		
		return "member/profile";
	}
	
	
	//로그인 회원 정보
	@RequestMapping(value = {"/myprofile"}, method = RequestMethod.GET)
	public ModelAndView memberInfo (HttpSession session){		
		//실제 로그인 시 수정할 부분
		session.setAttribute("email", "test@test.com");	  
	    
		String email = (String) session.getAttribute("email");	
		MemberDTO loginMember = memberservice.loginMember(email);		
		ModelAndView mv = new ModelAndView();		
		mv.addObject("loginMember",loginMember);
		
		mv.setViewName("member/myprofile");
		return mv;		
	}
		
	
	
    @PostMapping("/getMyproject")
    @ResponseBody
    List<ProjectDTO> getMyproject(HttpSession session) { 
		//실제 로그인 시 수정할 부분
		session.setAttribute("member_seq", 2);

		int memberSeq = (int)session.getAttribute("member_seq");
		List<ProjectDTO> myprojectList = projectservice.getProjectsByMemberSeq(memberSeq);
		System.out.println(myprojectList);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("myprojectList", myprojectList);	
		return myprojectList;    	
    }//올린 프로젝트
    
    
    
    

    @PostMapping("/getFunded")//마이페이지 - 후원한 프로젝트(진행중만 나오게 수정해야함)
    @ResponseBody
    List<FundingDTO> getFunded(HttpSession session) { 
		//실제 로그인 시 수정할 부분
		 session.setAttribute("member_seq", 2);

		int memberSeq = (int)session.getAttribute("member_seq");
		List<FundingDTO> myFundedList = fundingservice.getFundedProject(memberSeq);
		System.out.println(myFundedList);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("myFundedList", myFundedList);
	
		return myFundedList;    	
    }//후원한 프로젝트
	
	

    
  
    @PostMapping("/getFollower")
    @ResponseBody
    List<MemberDTO> getFollower(HttpSession session) { 
		//실제 로그인 시 수정할 부분
		session.setAttribute("member_seq", 4);										

		int memberSeq = (int)session.getAttribute("member_seq");
		
		List<Integer> getMyFollower = new ArrayList<>();
		getMyFollower = followservice.getMyFollower(memberSeq); //4
		
	    List<MemberDTO> myFollower = new ArrayList<>();
	    myFollower = memberservice.MyFollowerList(getMyFollower);
	    System.out.println(myFollower); //1, 5
	    
		ModelAndView mv = new ModelAndView();
		mv.addObject("myFollower", myFollower);
		
		return myFollower;    	
    }//팔로워
    
    
    
    @PostMapping("/getFollowing")
    @ResponseBody
    List<MemberDTO> getFollowing(HttpSession session) { 
		//실제 로그인 시 수정할 부분
		session.setAttribute("member_seq", 4);										

		int memberSeq = (int)session.getAttribute("member_seq");
		
		List<Integer> getMyFollowing = new ArrayList<>();
		getMyFollowing = followservice.getMyFollowing(memberSeq); //4
		
	    List<MemberDTO> myFollowing = new ArrayList<>();
	    myFollowing = memberservice.MyFollowingList(getMyFollowing);
	    System.out.println(myFollowing); //3, 5
	    
		ModelAndView mv = new ModelAndView();
		mv.addObject("myFollowing", myFollowing);

		return myFollowing;    	
    }//팔로잉
 
	
	
    //후원한 프로젝트
	@RequestMapping("/funded")
	ModelAndView fundedProject (HttpSession session) {
		//실제 로그인 시 수정할 부분
		session.setAttribute("member_seq", 6);										

		int memberSeq = (int)session.getAttribute("member_seq");		

		List<FundingDTO> ongoingFunded = fundingservice.ongoingFunded(memberSeq); //후원 진행중
		List<FundingDTO> successFunded = fundingservice.successFunded(memberSeq); //후원 성공
		List<FundingDTO> cancelFunded = fundingservice.cancelFunded(memberSeq); //후원 취소
		System.out.println(cancelFunded);
		
		//프로젝트 정보도 갖구와야함.... 
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("ongoingFunded", ongoingFunded);
		mv.addObject("successFunded", successFunded);
		mv.addObject("cancelFunded", cancelFunded);
		
		mv.setViewName("member/funded");
		
		
		
		

		return mv;
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
