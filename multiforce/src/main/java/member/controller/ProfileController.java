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
	
	
	//마이 프로필 - 로그인 회원 정보
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
		
	
	//마이 프로필 - 올린 프로젝트
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
    }
    
    
    
    //마이 프로필 - 후원한 프로젝트
    @PostMapping("/getFunded")
    @ResponseBody
    List<ProjectDTO> getFunded(HttpSession session) { 
		//실제 로그인 시 수정할 부분
		 session.setAttribute("member_seq", 6);

		int memberSeq = (int)session.getAttribute("member_seq");
		List<FundingDTO> ongoingFunded = fundingservice.ongoingFunded(memberSeq); //후원 진행중
		List<Integer> ongoingProjectSeq = new ArrayList<>();
		for (FundingDTO projectSeq : ongoingFunded) {
			ongoingProjectSeq.add(projectSeq.getProject_seq());
		}
		List<ProjectDTO> ongoingProject = projectservice.ongoingProject(ongoingProjectSeq);
		//후원 진행중 ProjectDTO	
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("ongoingProject", ongoingProject);
	
		return ongoingProject;    	
    }
	

    
    //마이 프로필 - 팔로워
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
    }
    
    
    
    //마이 프로필 - 팔로잉
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
    }
 
	
	
    
    //후원한 프로젝트 페이지
	@RequestMapping("/funded")
	ModelAndView fundedProject (HttpSession session) {
		//실제 로그인 시 수정할 부분
		session.setAttribute("member_seq", 6);										

		int memberSeq = (int)session.getAttribute("member_seq");		

		List<FundingDTO> ongoingFunded = fundingservice.ongoingFunded(memberSeq); //후원 진행중
		List<FundingDTO> successFunded = fundingservice.successFunded(memberSeq); //후원 성공
		List<FundingDTO> cancelFunded = fundingservice.cancelFunded(memberSeq); //후원 취소


		List<Integer> ongoingProjectSeq = new ArrayList<>();
		for (FundingDTO projectSeq : ongoingFunded) {
			ongoingProjectSeq.add(projectSeq.getProject_seq());
		}
		List<ProjectDTO> ongoingProject = projectservice.ongoingProject(ongoingProjectSeq);
		//후원 진행중 ProjectDTO		
		
		
		List<Integer> successProjectSeq = new ArrayList<>();
		for (FundingDTO projectSeq : successFunded) {
			successProjectSeq.add(projectSeq.getProject_seq());
		}
		List<ProjectDTO> successProject = projectservice.successProject(successProjectSeq);
		// 후원 진행중 ProjectDTO		
		
		
		List<Integer> cancelProjectSeq = new ArrayList<>();
		for (FundingDTO projectSeq : cancelFunded) {
			cancelProjectSeq.add(projectSeq.getProject_seq());
		}
		List<ProjectDTO> cancelProject = projectservice.cancelProject(cancelProjectSeq);
		//후원 취소 ProjectDTO

		
		ModelAndView mv = new ModelAndView();
		mv.addObject("ongoingFunded", ongoingFunded);		
		mv.addObject("successFunded", successFunded);
		mv.addObject("cancelFunded", cancelFunded);
		mv.addObject("ongoingProject", ongoingProject);
		mv.addObject("successProject", successProject);
		mv.addObject("cancelProject", cancelProject);
		
		mv.setViewName("member/funded");
		
		//쿼리 조회문에 정렬 넣어야한다!!
		return mv;
	}


    

	//후원한 프로젝트 페이지 - 검색
    @GetMapping("/funded_search")
    @ResponseBody
    List<ProjectDTO> fundedSearch(String keyword, HttpSession session) { 
		//실제 로그인 시 수정할 부분
		session.setAttribute("member_seq", 6);

		int memberSeq = (int)session.getAttribute("member_seq");
//		List<ProjectDTO> myprojectList = projectservice.getProjectsByMemberSeq(memberSeq); // 회원의 모든 프로젝트
//		System.out.println(myprojectList); //4개 확인		
		System.out.println(keyword.toString());//키워드 확인
		
		String searchKeyword = keyword.toString();
		List<ProjectDTO> searchFunded = projectservice.searchFunded(searchKeyword, memberSeq); //프로젝트 긴제목 또는 짧은제목 + 회원번호 일치 조건
																								//선물 이름으로도 검색 가능하게.
																								//지금 클릭이벤트인데 체인지로 변경, 검색창이 null일때는 전체 나오게 
		ModelAndView mv = new ModelAndView();
		mv.addObject("searchFunded", searchFunded);

		return searchFunded;    	
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
