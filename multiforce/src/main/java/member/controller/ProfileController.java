package member.controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import funding.dto.FundingDTO;
import funding.service.FundingService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import member.dto.MemberDTO;
import member.dto.MemberProfileImgDTO;
import member.service.FollowService;
import member.service.MemberService;
import project.dto.BundleDTO;
import project.dto.FundingBundleCountDTO;
import project.dto.ProjectDTO;
import project.dto.ItemDTO;
import project.dto.ItemOptionDTO;
import project.service.BundleService;
import project.service.FundingBundleCountService;
import project.service.ItemOptionService;
import project.service.ItemService;
import project.service.ProjectDibsService;
import project.service.ProjectService;
import org.springframework.web.multipart.MultipartFile;

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
	@Autowired
	private BundleService bundleservice;
	@Autowired
	private ItemService itemservice;
	@Autowired
	private ItemOptionService itemoptionservice;
	@Autowired
	private FundingBundleCountService countservice;
	@Autowired
	private ProjectDibsService dibsservice;

	
	@GetMapping("/profile")
	public String profile() {		
		return "member/profile";
	}
	
	
	//마이 프로필 - 로그인 회원 정보
	@GetMapping("/myprofile")
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
    @GetMapping("/getMyproject")
    @ResponseBody
    List<ProjectDTO> getMyproject(HttpSession session) { 
		//실제 로그인 시 수정할 부분
		session.setAttribute("member_seq", 2);

		int memberSeq = (int)session.getAttribute("member_seq");
		List<ProjectDTO> myprojectList = projectservice.getProjectsByMemberSeq(memberSeq);
			
		return myprojectList;    	
    }
    
    
    
    //마이 프로필 - 후원한 프로젝트
    @GetMapping("/getFunded")
    @ResponseBody
    List<ProjectDTO> getFunded(HttpSession session) { 
		//실제 로그인 시 수정할 부분
		 session.setAttribute("member_seq", 6);

		int memberSeq = (int)session.getAttribute("member_seq");
		List<FundingDTO> ongoingFunded = fundingservice.ongoingFunded(memberSeq);	//후원 진행중
		List<Integer> fundSeqList = new ArrayList<>(); 								
		for (FundingDTO fundingDTO : ongoingFunded) {
		    int fundSeq = fundingDTO.getFund_seq();
		    fundSeqList.add(fundSeq);												// fund_seq 리스트
		}
		
			
		List<Integer> ongoingProjectSeq = new ArrayList<>();						
		for (FundingDTO projectSeq : ongoingFunded) {								//poject_seq 리스트
			ongoingProjectSeq.add(projectSeq.getProject_seq());
		}
		List<ProjectDTO> ongoingProject = projectservice.ongoingProject(ongoingProjectSeq); 	//후원중 + 현재 진행중인 프로젝트의 정보들		
	
		return ongoingProject;    	
    }
	

    
    //마이 프로필 - 팔로워
    @GetMapping("/getFollower")
    @ResponseBody
    Map<String, Object> getFollower(HttpSession session) {
        // 실제 로그인 시 수정할 부분
        session.setAttribute("member_seq", 4);

        int memberSeq = (int) session.getAttribute("member_seq");

        List<Integer> getMyFollower = followservice.getMyFollower(memberSeq);		// 현재 회원의 팔로워들의 memberSeq 리스트
        List<MemberDTO> myFollower = memberservice.myFollowerList(getMyFollower);	// 위 회원들의 정보 
        
        List<Integer> followersSeq = new ArrayList<>();								// 팔로워들의 seq
        for (MemberDTO follower : myFollower) {
        	followersSeq.add(follower.getMember_seq());
        }

        Map<Integer, Integer> followerCounts = new HashMap<>();						// 팔로워들의 팔로워 찾기
        Map<Integer, Integer> followerProject = new HashMap<>();					// 팔로워들의 올린프로젝트 찾기

        for (Integer followerSeq : followersSeq) {
            Integer count = followservice.getCountByFollowingSeq(followerSeq);
            if (count == null) {
                count = 0;
            }
            followerCounts.put(followerSeq, count);

            Integer projectCount = projectservice.getProjectCount(followerSeq);
            followerProject.put(followerSeq, projectCount);
        }

        
        Map<String, Object> myFollowers = new HashMap<>();
        myFollowers.put("myFollower", myFollower);
        myFollowers.put("followerCounts", followerCounts);
        myFollowers.put("followerProject", followerProject);


        return myFollowers; 	
    }
    
  
     
    //마이 프로필 - 팔로워 - 팔로우 버튼 클릭
    @PostMapping("/follower_btn")
    @ResponseBody
    public int followerAdd(int memberSeq, HttpSession session) {
    	int followingMemberSeq = (int) session.getAttribute("member_seq"); //로그인본인seq
    	int followerMemberSeq = memberSeq;	//팔로워의seq
    	
    	int followerAdd = followservice.followerAdd(followingMemberSeq,followerMemberSeq); // 1-> insert됨,  0-> 이미 팔로우
    	System.out.println(followerAdd);
		return followerAdd;
	}
    
    
    
    //마이 프로필 - 팔로잉
    @GetMapping("/getFollowing")
    @ResponseBody
    Map<String, Object> getFollowing(HttpSession session) { 
		//실제 로그인 시 수정할 부분
		session.setAttribute("member_seq", 4);										

		int memberSeq = (int)session.getAttribute("member_seq");
		
		List<Integer> getMyFollowing = followservice.getMyFollowing(memberSeq); 		//현재 회원의 팔로잉들의 memberSeq 리스트
		List<MemberDTO> myFollowing = memberservice.myFollowingList(getMyFollowing);	//위 회원들의 정보
		
        List<Integer> followersSeq = new ArrayList<>();								// 팔로잉들의 seq
        for (MemberDTO following : myFollowing) {
        	followersSeq.add(following.getMember_seq());
        }
        
        Map<Integer, Integer> followerCounts = new HashMap<>();						// 팔로워들의 팔로워 찾기
        Map<Integer, Integer> followerProject = new HashMap<>();					// 팔로워들의 올린프로젝트 찾기

        for (Integer followerSeq : followersSeq) {
            Integer count = followservice.getCountByFollowingSeq(followerSeq);
            if (count == null) {
                count = 0;
            }
            followerCounts.put(followerSeq, count);

            Integer projectCount = projectservice.getProjectCount(followerSeq);
            followerProject.put(followerSeq, projectCount);
        }

        
        Map<String, Object> myFollowings = new HashMap<>();
        myFollowings.put("myFollowing", myFollowing);
        myFollowings.put("followerCounts", followerCounts);
        myFollowings.put("followerProject", followerProject);
        
//        System.out.println(myFollowings);

		return myFollowings;    	
    }
 
	
    
    //마이 프로필 - 팔로잉 - 팔로우 취소 클릭
    @PostMapping("/following_btn")
    @ResponseBody
    public int unfollow(int memberSeq, HttpSession session) {
			
		  int followingMemberSeq = (int) session.getAttribute("member_seq"); //로그인본인seq
		  int followerMemberSeq = memberSeq; //팔로워의seq
		  
		  int unfollow = followservice.unfollow(followingMemberSeq,followerMemberSeq); // 1-> delete됨 
		  System.out.println(unfollow);
			 
		return unfollow;
	}
    
    
    
    //팔로우 - 후원한 프로젝트의 회원 정보
    @PostMapping("/follow_getFunded")
    @ResponseBody
    Map<String, Object> fundedMembersInfo(HttpSession session) { 
		//실제 로그인 시 수정할 부분
		 session.setAttribute("member_seq", 6);

		int memberSeq = (int)session.getAttribute("member_seq");
		List<FundingDTO> ongoingFunded = fundingservice.ongoingFunded(memberSeq);	//후원 진행중
		List<Integer> fundSeqList = new ArrayList<>(); 								
		for (FundingDTO fundingDTO : ongoingFunded) {
		    int fundSeq = fundingDTO.getFund_seq();
		    fundSeqList.add(fundSeq);												// fund_seq 리스트
		}
		System.out.println(fundSeqList); //1112 
		
			
		//프로젝트 테이블에서 poject_seq로 member seq 찾아서 리스트 만들기		
		List<Integer> ongoingProjectSeq = new ArrayList<>();						
		for (FundingDTO projectSeq : ongoingFunded) {								//poject_seq 리스트
			ongoingProjectSeq.add(projectSeq.getProject_seq());
		}
		List<ProjectDTO> ongoingProject = projectservice.ongoingProject(ongoingProjectSeq); 
		
		
		List<Integer> memberSeqList = new ArrayList<>();							//member_seq 리스트
		for (ProjectDTO projectDTO : ongoingProject) {
		    memberSeqList.add(projectDTO.getMember_seq());
		}
		
		List<MemberDTO> fundedMember= memberservice.myFollowerList(memberSeqList);	//마이프로필 - 팔로워 와 같음
		
		
        Map<Integer, Integer> followerCounts = new HashMap<>();						// 팔로워들의 팔로워 찾기
        Map<Integer, Integer> followerProject = new HashMap<>();					// 팔로워들의 올린프로젝트 찾기

        for (Integer followerSeq : memberSeqList) {
            Integer count = followservice.getCountByFollowingSeq(followerSeq);
            if (count == null) {
                count = 0;
            }
            followerCounts.put(followerSeq, count);

            Integer projectCount = projectservice.getProjectCount(followerSeq);
            followerProject.put(followerSeq, projectCount);
        }
        
        System.out.println(fundedMember);
        System.out.println(followerCounts);
        System.out.println(followerProject);
        
        Map<String, Object> fundedMembersInfo = new HashMap<>();
        fundedMembersInfo.put("fundedMember", fundedMember);
        fundedMembersInfo.put("followerCounts", followerCounts);
        fundedMembersInfo.put("followerProject", followerProject);


        return fundedMembersInfo;
	   	
    }
       
    
    
    //후원한 프로젝트용
    private List<ProjectDTO> getFundedProjects(HttpSession session, List<FundingDTO> fundedList) { 
        int memberSeq = (int) session.getAttribute("member_seq");

        List<Integer> projectSeqList = new ArrayList<>();
        for (FundingDTO funded : fundedList) {
            projectSeqList.add(funded.getProject_seq());
        }
        return projectservice.ongoingProject(projectSeqList);
    }
        
    
    // 후원한 프로젝트 페이지
    @GetMapping("/funded")
    ModelAndView fundedProject(HttpSession session) {
        // 실제 로그인 시 수정할 부분
        session.setAttribute("member_seq", 6);

        int memberSeq = (int) session.getAttribute("member_seq");

        List<FundingDTO> ongoingFunded = fundingservice.ongoingFunded(memberSeq); // 후원 진행중
        List<FundingDTO> successFunded = fundingservice.successFunded(memberSeq); // 후원 성공
        List<FundingDTO> cancelFunded = fundingservice.cancelFunded(memberSeq); // 후원 취소

        List<ProjectDTO> ongoingProject = getFundedProjects(session, ongoingFunded);
        List<ProjectDTO> successProject = getFundedProjects(session, successFunded);
        List<ProjectDTO> cancelProject = getFundedProjects(session, cancelFunded);

        ModelAndView mv = new ModelAndView();
        mv.addObject("ongoingFunded", ongoingFunded);
        mv.addObject("successFunded", successFunded);
        mv.addObject("cancelFunded", cancelFunded);
        mv.addObject("ongoingProject", ongoingProject);
        mv.addObject("successProject", successProject);
        mv.addObject("cancelProject", cancelProject);

        mv.setViewName("member/funded");

        return mv;
    }

 

	//후원한 프로젝트 페이지 - 검색 --- 추가필요(선물이름, 창작자도 가능하게) 
    @GetMapping("/funded_search")
    @ResponseBody
    List<ProjectDTO> fundedSearch(@RequestParam(required = false) String keyword, HttpSession session) { 
		//실제 로그인 시 수정할 부분
		session.setAttribute("member_seq", 6);

		int memberSeq = (int)session.getAttribute("member_seq");
		List<ProjectDTO> searchFunded = projectservice.searchFunded(keyword, memberSeq); //프로젝트 긴제목		
		return searchFunded;    	
    }

	
	
    //후원한 프로젝트 - 상세페이지
    @GetMapping(value = {"/ongoing_detail/{fund_seq}", "/cancel_detail/{fund_seq}", "/success_detail/{fund_seq}"})
    ModelAndView fundedDetail(@PathVariable int fund_seq, HttpServletRequest request) {
        int fundseq = fund_seq;  //후원번호
        FundingDTO getFundedDetail = fundingservice.getFundedDetail(fundseq);	 		//후원정보
        System.out.println(getFundedDetail);

        int projectSeq = getFundedDetail.getProject_seq();								//프로젝트번호
        ProjectDTO getProjectDetail = projectservice.getProjectDetail(projectSeq); 		//프로젝트정보

        LocalDate dueDate = getProjectDetail.getDue_date();							// 남은기한
        LocalDate currentTime = LocalDate.now();
        int dDay = (int) ChronoUnit.DAYS.between(currentTime, dueDate);

        List<FundingBundleCountDTO> getCount = countservice.getCount(fundseq); 			//후원번호로 꾸러미개수 찾기
        List<Integer> bundleList = new ArrayList<>(); 									//꾸러미 번호만 담긴 리스트
        for (FundingBundleCountDTO seq : getCount) {
            bundleList.add(seq.getBundle_seq());
        }

        List<BundleDTO> getBundle = bundleservice.getBundle(bundleList);				//꾸러미 찾기

        // getBundle 리스트를 Map으로 변환
        Map<Integer, String> bundleMap = getBundle.stream()
                .collect(Collectors.toMap(BundleDTO::getBundle_seq, BundleDTO::getBundle_name));

        List<ItemDTO> getItem = itemservice.getItem(bundleList);    					//아이템 찾기
        List<Integer> itemList = new ArrayList<>();    									//아이템 번호만 담긴 리스트
        for (ItemDTO seq : getItem) {
            itemList.add(seq.getItem_seq());
        }

        Map<Integer, List<String>> bundleAndItem = new HashMap<>();						// 꾸러미 고유번호랑 아이템 이름 맵 생성
        for (ItemDTO item : getItem) {
            int bundleSeq = item.getBundle_seq();
            String itemName = item.getItem_name();
            bundleAndItem.computeIfAbsent(bundleSeq, k -> new ArrayList<>()).add(itemName);
        }

        Map<Integer, String> bundleNameMap = getBundle.stream()
                .collect(Collectors.toMap(BundleDTO::getBundle_seq, BundleDTO::getBundle_name));
      

        Map<String, List<String>> bundleItem = bundleAndItem.entrySet().stream()
                .collect(Collectors.toMap(entry -> bundleNameMap.get(entry.getKey()), entry -> entry.getValue()));       
        
        Map<String, Integer> bundleCount = getCount.stream()
                .collect(Collectors.toMap(count -> bundleMap.get(count.getBundle_seq()), FundingBundleCountDTO::getPerchase_count));
        

        List<ItemOptionDTO> getItemOption = itemoptionservice.getItemOption(itemList);	//옵션찾기
        Map<Integer, List<String>> itemAndOption = new HashMap<>(); 					// 아이템 고유번호랑 옵션 맵 생성
        for (ItemOptionDTO option : getItemOption) {
            int itemSeq = option.getItem_seq();
            String optionName = option.getItem_option_name();
            itemAndOption.computeIfAbsent(itemSeq, k -> new ArrayList<>()).add(optionName);
        }

        Map<Integer, String> itemNameMap = getItem.stream()
                .collect(Collectors.toMap(ItemDTO::getItem_seq, ItemDTO::getItem_name));

        Map<String, List<String>> itemOption = itemAndOption.entrySet().stream()
                .collect(Collectors.toMap(entry -> itemNameMap.get(entry.getKey()), entry -> entry.getValue()));

        String trackNum = (getFundedDetail.getTrack_num());   							//운송장번호.
        if (trackNum == null) {
            trackNum = "0";
            
        }

        ModelAndView mv = new ModelAndView();

        mv.addObject("trackNum", trackNum); // 운송장번호
        mv.addObject("fundedDetail", getFundedDetail); //후원정보
        mv.addObject("projectDetail", getProjectDetail); //프로젝정보
        mv.addObject("dDay", dDay); //남은기한
        mv.addObject("bundleCount", bundleCount); //꾸러미개수
        mv.addObject("bundleItem", bundleItem); //번들-아이템
        mv.addObject("itemOption", itemOption); //아이템-옵션
        
        // URL에 따라서 다른 JSP 페이지로 보내도록 설정
        if (request.getRequestURI().contains("/ongoing_detail/")) {
            mv.setViewName("member/ongoing_detail");
        } else if (request.getRequestURI().contains("/cancel_detail/")) {
            mv.setViewName("member/cancel_detail");
        } else  {
            mv.setViewName("member/success_detail");
        } 
        
        return mv;
    }
	
	
	
	//후원 취소 
    @PostMapping("/funded_cancel")
    public String funded_cancel(@RequestParam("fundSeqInput") int fundSeq,
    							@RequestParam("priceInput") int price,
					            @RequestParam("longTitleInput") String longTitle,
					            @RequestParam("dueDateInput") String dueDate,
					            @RequestParam("bundleDataInput") String bundleData,
					            Model model ) throws JsonMappingException, JsonProcessingException {
    	
        ObjectMapper objectMapper = new ObjectMapper();
        List<Map<String, Object>> bundleDataList = objectMapper.readValue(bundleData, List.class);
        
        fundingservice.delStatusChange(fundSeq);

        model.addAttribute("fundSeq", fundSeq);
        model.addAttribute("price", price);
        model.addAttribute("dueDate", dueDate);
        model.addAttribute("longTitle", longTitle);
        model.addAttribute("bundle", bundleDataList);

        return "member/funded_cancel";
    }

	
	
	//찜한 프로젝트
	@GetMapping("/mydibs")
	public ModelAndView mydibs(HttpSession session)  {
        // 실제 로그인 시 수정할 부분
        session.setAttribute("member_seq", 6);
        
        int memberSeq = (int) session.getAttribute("member_seq");
        
		List<Integer> dibsList = dibsservice.dibsList(memberSeq); //해당 회원의 관심목록
		List<ProjectDTO> myDibsProject = projectservice.myDibsProject(dibsList); //해당 프로젝트 DTO
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("myDibs",myDibsProject);
		mv.addObject("memberSeq",memberSeq);
		mv.setViewName("member/mydibs");		
		return mv;
	}
	
	
	//찜한 프로젝트 - 진행중
	@PostMapping("/getDibsOngoing")
	@ResponseBody
	List<ProjectDTO> getDibsOngoing(@RequestBody List<Integer> projectSeqArray) {
	    List<ProjectDTO> dibsOngoing = projectservice.dibsOngoing(projectSeqArray);
	    return dibsOngoing;
	}
	
	
	
	//찜한 프로젝트 - 종료된
	@PostMapping("/getDibsEnd")
	@ResponseBody
	List<ProjectDTO> getDibsEnd(@RequestBody List<Integer> projectSeqArray) {
	    List<ProjectDTO> dibsEnd = projectservice.dibsEnd(projectSeqArray);
	    return dibsEnd;
	}
	
	
	//찜한 프로젝트 - 찜 취소
    @PostMapping("/dibsCancel")
    @ResponseBody
    public int dibsCancel(int projectSeq, int memberSeq) {
 
    	int dibsCancel = dibsservice.dibsCancel(projectSeq, memberSeq); // -> 1 나와야 삭제.    	
    	int dibsDelete = projectservice.dibsDelete(projectSeq);	//해당프로젝트 dibs_count -1하기.   	
    	
    	return dibsCancel;	
    }
	
	
	//팔로우
	@GetMapping("/follow")
	public String follow() {		
		return "member/follow";
	}
	


	//회원정보수정
	@GetMapping("/settings")
	public ModelAndView settings(HttpSession session) {
        // 실제 로그인 시 수정할 부분
		session.setAttribute("member_seq", 2);	  
	    
		int memberSeq = (int) session.getAttribute("member_seq");	
		MemberDTO loginMemberSeq = memberservice.loginMemberSeq(memberSeq);
		List<FundingDTO> getFundedProject = fundingservice.getFundedProject(memberSeq);	
		
		ModelAndView mv = new ModelAndView();		
		mv.addObject("loginMember",loginMemberSeq);		
		mv.addObject("funded",getFundedProject);		
		mv.setViewName("member/settings");
		return mv;		
	}
	
	
	//회원정보수정 - 프로필사진 변경
	@PostMapping("/profileimg_upload")
	@ResponseBody
	public Map<String, Object> profileimgUpload(MemberProfileImgDTO dto) throws IllegalStateException, IOException  {
		
		String savePath = "c:/fullstack/workspace_springboot/images/members/";
		String fileName = null ;
		String newFileName = null;
		
		MultipartFile file = dto.getProfileImg();
		if(!file.isEmpty()) {
			fileName = file.getOriginalFilename();
			String before = fileName.substring(0, fileName.indexOf("."));	//파일명
			String ext = fileName.substring(fileName.indexOf("."));			//확장자
			newFileName = before+"("+UUID.randomUUID().toString()+")"+ext;	//새이름
			
			File saveFile = new File(savePath + newFileName);
			file.transferTo(saveFile);										//파일로 변경
		}	
		
		int memberSeq = dto.getMember_seq();
		String filePath = "/memberimages/" + newFileName;

		int updateProfileImg = memberservice.updateProfileImg(filePath, memberSeq);	//프로필 url 변경
		
		Map<String, Object> response = new HashMap<>();
        response.put("filePath", filePath);	
        
		return response;		
	}
	

	
	//회원정보수정 - 프로필사진 삭제
	@PostMapping("/profileimg_delete")
	@ResponseBody
	public int profileimgDelete(int memberSeq) {
		
		int profileimgDelete = memberservice.profileimgDelete(memberSeq);	//기본 프로필 사진으로 변경		
		return profileimgDelete;
	}
	

	
	//회원정보수정 - 닉네임 변경
	@PostMapping("/nickname_change")
	@ResponseBody
	public int nicknameChange(int memberSeq, String nickname) {

		int nicknameChange = memberservice.nicknameChange(memberSeq,nickname);	//닉네임 변경	
		return nicknameChange;
	}
	

	//회원정보수정 - 소개 변경
	@PostMapping("/description_change")
	@ResponseBody
	public int descriptionChange(int memberSeq, String desc) {

		int descriptionChange = memberservice.descriptionChange(memberSeq,desc);	//소개 변경
		return descriptionChange;
	}
	

	//회원정보수정 - 메일 변경
	@PostMapping("/email_change")
	@ResponseBody
	public int emailChange(int memberSeq, String email) {

		int emailChange = memberservice.emailChange(memberSeq,email);	//메일 변경
		return emailChange;
	}
	
	
	//회원정보수정 - 비밀번호 변경
	@PostMapping("/password_change")
	@ResponseBody
	public int passwordChange(int memberSeq, String newPw) {
		
		int passwordChange = memberservice.passwordChange(memberSeq,newPw);	//비번 변경
		return passwordChange;
	}
	
	
	
	//회원정보수정 - 배송지 추가
	@PostMapping("/")
	@ResponseBody
	public int deliveryAdd() {
		
		
		return 0;
	}
	
	
	
	//내가 올린 프로젝트 - 전체
    @GetMapping("/myproject")
    public ModelAndView myproject(HttpSession session) {
        // 실제 로그인 시 수정할 부분
        session.setAttribute("member_seq", 6);

        int memberSeq = (int) session.getAttribute("member_seq");
        List<ProjectDTO> myprojectList = projectservice.getProjectsByMemberSeq(memberSeq);

        ModelAndView mv = new ModelAndView("member/myproject");
        mv.addObject("myprojectList", myprojectList);		//모든프로젝트
        
        return mv;
    }
    
    
    //내가 올린 프로젝트 - 작성중
    @GetMapping("/write_incomplete")
    @ResponseBody
    public List<ProjectDTO> writeIncomplete(int memberSeq) {
    	
    	List<ProjectDTO> writeIncomplete = projectservice.writeIncomplete(memberSeq);
    	return writeIncomplete;    	
    }
   
    
    //내가 올린 프로젝트 - 심사중
    @GetMapping("/request_approval")
    @ResponseBody
    public List<ProjectDTO> requestApproval(int memberSeq) {
    	
    	List<ProjectDTO> requestApproval = projectservice.requestApproval(memberSeq);
    	return requestApproval;    
    }

    
    //내가 올린 프로젝트 - 반려
    @GetMapping("/request_reject")
    @ResponseBody
    public List<ProjectDTO> requestReject(int memberSeq) {
    	
    	List<ProjectDTO> requestReject = projectservice.requestReject(memberSeq);    	
    	return requestReject;    	
    
    }
    
    
    //내가 올린 프로젝트 - 승인
    @GetMapping("/request_admit")
    @ResponseBody
    public List<ProjectDTO> requestAdmit(int memberSeq) {
    	
    	List<ProjectDTO> requestAdmit = projectservice.requestAdmit(memberSeq);
    	System.out.println(requestAdmit);
    	return requestAdmit;    	
    
    }
    

    
    //내가 올린 프로젝트 - 진행중
    @GetMapping("/funding_start")
    @ResponseBody
    public List<ProjectDTO> fundingStart(int memberSeq) {
    	
    	List<ProjectDTO> fundingStart = projectservice.fundingStart(memberSeq);
    	System.out.println(fundingStart);
    	return fundingStart;    	
    
    }
    
    
    //내가 올린 프로젝트 - 펀딩 실패
    @GetMapping("/funding_failed")
    @ResponseBody
    public List<ProjectDTO> fundingFailed(int memberSeq) {
    	
    	List<ProjectDTO> fundingFailed = projectservice.fundingFailed(memberSeq);
    	return fundingFailed;       
    }
    
    

    //내가 올린 프로젝트 - 펀딩 성공
    @GetMapping("/funding_success")
    @ResponseBody
    public List<ProjectDTO> fundingSuccess(int memberSeq) {
    	
    	List<ProjectDTO> fundingSuccess = projectservice.fundingSuccess(memberSeq);
    	return fundingSuccess;    
    } 

    
    
    //내가 올린 프로젝트 - 종료
    @GetMapping("/funding_complete")
    @ResponseBody
    public List<ProjectDTO> fundingComplete(int memberSeq) {
    	
    	List<ProjectDTO> fundingComplete = projectservice.fundingComplete(memberSeq);
    	return fundingComplete;    
    } 
    
        
    
    //내가 올린 프로젝트 - 삭제
    @PostMapping("/project_delete")
    @ResponseBody
    public String projectDelete (int projectSeq) {
    	int projectDelete = projectservice.projectDelete(projectSeq);
        if (projectDelete == 1) {
            return "삭제 완료";
        } else {
            return "삭제 오류";
        }
    }
    
    
    
    
    
    
    
}
