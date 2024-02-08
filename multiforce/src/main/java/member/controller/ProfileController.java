package member.controller;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.tags.HtmlEscapeTag;
import org.springframework.web.util.HtmlUtils;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import funding.dto.FundingDTO;
import funding.service.FundingService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import member.dto.DeliveryDTO;
import member.dto.MemberDTO;
import member.dto.MemberProfileImgDTO;
import member.service.DeliveryService;
import member.service.FollowService;
import member.service.MemberService;
import project.dto.BundleDTO;
import project.dto.FundingBundleCountDTO;
import project.dto.ItemDTO;
import project.dto.ItemOptionDTO;
import project.dto.ProjectDTO;
import project.dto.ProjectMemberDTO;
import project.service.BundleService;
import project.service.FundingBundleCountService;
import project.service.ItemOptionService;
import project.service.ItemService;
import project.service.ProjectDibsService;
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
	@Autowired
	private DeliveryService deliveryservice;

	
	@GetMapping("/profile")
	public String profile() {		
		return "member/profile";
	}
	
	
	//마이 프로필 - 로그인 회원 정보
	@GetMapping("/myprofile")
	public ModelAndView memberInfo (HttpSession session){		 
	    	
		int memberSeq = (int) session.getAttribute("login_user_seq");
		MemberDTO loginMemberSeq = memberservice.loginMemberSeq(memberSeq);
		
//		String desc = escapeHtml(loginMemberSeq.getDescription());
//		System.out.println("치환 - " + desc);
//		System.out.println("그냥 - " +loginMemberSeq.getDescription());

		ModelAndView mv = new ModelAndView("member/myprofile");		
		mv.addObject("loginMember",loginMemberSeq);
//		mv.addObject("desc",desc);

		return mv;
	}
/*	
	public static String escapeHtml(String input) {
	    if (input == null) {
	        return null;
	    }
	    return input.replace("&", "&amp;")
	                .replace("\"", "&quot;")
	                .replace("'", "&#39;")
	                .replace(" ", "&nbsp;") // 공백 처리
	                .replace("?", "&#63;")  // 물음표 처리
	                .replace("!", "&#33;")
	                .replace("@", "&#64;")
	                .replace("#", "&#35;")
	                .replace("$", "&#36;")
	                .replace("%", "&#37;")
	                .replace("^", "&#94;")
	                .replace("&", "&#38;")
	                .replace("(", "&#40;")
	                .replace(")", "&#41;")
	                .replace(",", "&#44;")
	                .replace(".", "&#46;")
	                .replace(";", "&#59;")
	                .replace("{", "&#123;")
	                .replace("}", "&#125;")
	                .replace("[", "&#91;")
	                .replace("]", "&#93;")
	                .replace("<", "&lt;")
	                .replace(">", "&gt;")
	                .replace("/", "&#47;")
	                .replace("★", "&#9733;") // 별표 처리
	                .replace("☆", "&#9734;") // 별 처리
			        .replace("\n", "<br>") // 엔터(개행 문자) 처리
			        .replace("\r", ""); // 캐리지 리턴 처리
	}
*/

	//마이 프로필 - 올린 프로젝트
    @GetMapping("/getMyproject")
    @ResponseBody
    List<ProjectDTO> getMyproject(HttpSession session) {
		int memberSeq = (int)session.getAttribute("login_user_seq");

		List<ProjectDTO> myprojectList = projectservice.getProjectsByMemberSeq(memberSeq);//진행중만			
		return myprojectList;    	
    }
    
    
    
    //마이 프로필 - 후원한 프로젝트
    @GetMapping("/getFunded")
    @ResponseBody
    List<Map<String, Object>> getFunded(HttpSession session) { 
		int memberSeq = (int)session.getAttribute("login_user_seq");

		List<Map<String, Object>> ongoingFunded = fundingservice.getFunded(memberSeq);	//후원 진행중
		return ongoingFunded;    	
    }
	
    

    
    //마이 프로필 - 팔로워
    @GetMapping("/getFollower")
    @ResponseBody
    Map<String, Object> getFollower(HttpSession session) {
        // 실제 로그인 시 수정할 부분
    	int memberSeq = (int)session.getAttribute("login_user_seq");

        List<Integer> getMyFollower = followservice.getMyFollower(memberSeq);		// 현재 회원의 팔로워들의 memberSeq 리스트
        
        if (getMyFollower.size() != 0) {
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
        return null;	        	
    }
    
  
     
    //마이 프로필 - 팔로워 - 팔로우 버튼 클릭
    @PostMapping("/follower_btn")
    @ResponseBody
    public int followerAdd(int memberSeq, HttpSession session) {
    	int followingMemberSeq = (int) session.getAttribute("login_user_seq"); //로그인본인seq
    	int followerMemberSeq = memberSeq;	//팔로워의seq
    	
    	int followerAdd = followservice.followerAdd(followingMemberSeq,followerMemberSeq); // 1-> insert됨,  0-> 이미 팔로우
    	
       	if (followerAdd == 0) {
    		return 3;
    		//이미 팔로우 되어있을때.
    	}

		return followerAdd;
	}
    
    
    //마이 프로필 - 팔로잉
    @GetMapping("/getFollowing")
    @ResponseBody
    Map<String, Object> getFollowing(HttpSession session) { 									

		int memberSeq = (int)session.getAttribute("login_user_seq");
		
		List<Integer> getMyFollowing = followservice.getMyFollowing(memberSeq); 		//현재 회원의 팔로잉들의 memberSeq 리스트
		
		if (getMyFollowing.size() != 0) {
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

			return myFollowings; 
		}
		return null;
    }
 
	
    
    //마이 프로필 - 팔로잉 - 팔로우 취소 클릭
    @PostMapping("/following_btn")
    @ResponseBody
    public int unfollow(int memberSeq, HttpSession session) {
			
		  int followingMemberSeq = (int) session.getAttribute("login_user_seq"); //로그인본인seq
		  int followerMemberSeq = memberSeq; //팔로워의seq
		  
		  int unfollow = followservice.unfollow(followingMemberSeq,followerMemberSeq); // 1-> delete됨 		 
		return unfollow;
	}
    
    
    
    //팔로우 - 후원한 프로젝트의 회원 정보
    @PostMapping("/follow_getFunded")
    @ResponseBody
    Map<String, Object> fundedMembersInfo(HttpSession session) { 
    	
		int memberSeq = (int)session.getAttribute("login_user_seq");
		
		List<FundingDTO> ongoingFunded = fundingservice.ongoingFunded(memberSeq);	//후원 진행중
		if(ongoingFunded.size() != 0 ) {
			List<Integer> fundSeqList = new ArrayList<>(); 								
			for (FundingDTO fundingDTO : ongoingFunded) {
			    int fundSeq = fundingDTO.getFund_seq();
			    fundSeqList.add(fundSeq);												// fund_seq 리스트
			}		
				
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
	        
	        Map<String, Object> fundedMembersInfo = new HashMap<>();
	        fundedMembersInfo.put("fundedMember", fundedMember);
	        fundedMembersInfo.put("followerCounts", followerCounts);
	        fundedMembersInfo.put("followerProject", followerProject);
	        
	        return fundedMembersInfo;
		}
		
	   	return null;
    }
       
    
    
    //후원한 프로젝트용
    private List<ProjectDTO> getFundedProjects(HttpSession session, List<FundingDTO> fundedList) { 
        int memberSeq = (int) session.getAttribute("login_user_seq");

        List<Integer> projectSeqList = new ArrayList<>();
        for (FundingDTO funded : fundedList) {
            projectSeqList.add(funded.getProject_seq());
        }
        return projectservice.ongoingProject(projectSeqList);
    }
        
    
    
    // 후원한 프로젝트 페이지
    @GetMapping("/funded")
    ModelAndView fundedProject(HttpSession session) {

        int memberSeq = (int) session.getAttribute("login_user_seq");

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

		int memberSeq = (int)session.getAttribute("login_user_seq");
		List<ProjectDTO> searchFunded = projectservice.searchFunded(keyword, memberSeq); //프로젝트 긴제목
		return searchFunded;    	
    }

	
	
    //후원한 프로젝트 - 상세페이지
    @GetMapping(value = {"/ongoing_detail/{fund_seq}", "/cancel_detail/{fund_seq}", "/success_detail/{fund_seq}"})
    ModelAndView fundedDetail(@PathVariable int fund_seq, HttpServletRequest request) {
        int fundseq = fund_seq;  //후원번호
        ModelAndView mv = new ModelAndView();
        FundingDTO dto = fundingservice.getPaymentInfo(fundseq);
		mv.addObject("dto", dto);
        
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
					            @RequestParam("creatorInput") String creator,
					            @RequestParam("bundleDataInput") String bundleData,
					            Model model ) throws JsonMappingException, JsonProcessingException {
    	
        ObjectMapper objectMapper = new ObjectMapper();
        List<Map<String, Object>> bundleDataList = objectMapper.readValue(bundleData, List.class);
        
        fundingservice.delStatusChange(fundSeq);

        model.addAttribute("fundSeq", fundSeq);
        model.addAttribute("price", price);
        model.addAttribute("creator", creator);
        model.addAttribute("dueDate", dueDate);
        model.addAttribute("longTitle", longTitle);
        model.addAttribute("bundle", bundleDataList);

        return "member/funded_cancel";
    }

	
	
	//찜한 프로젝트
	@GetMapping("/mydibs")
	public ModelAndView mydibs(HttpSession session)  {
        int memberSeq = (int) session.getAttribute("login_user_seq");
        
        ModelAndView mv = new ModelAndView("member/mydibs");        
        mv.addObject("memberSeq",memberSeq);
        
		List<Integer> dibsList = dibsservice.dibsList(memberSeq); //해당 회원의 관심목록		
		if (dibsList.size() != 0) {
			List<ProjectMemberDTO> myDibsProject = projectservice.myDibsProject(dibsList); //해당 프로젝트 DTO			
			mv.addObject("myDibs",myDibsProject);
			return mv;
		}	

		return mv;
	}
	
	
	//찜한 프로젝트 - 진행중
	@PostMapping("/getDibsOngoing")
	@ResponseBody
	List<ProjectMemberDTO> getDibsOngoing(@RequestBody List<Integer> projectSeqArray) {
		
		if (projectSeqArray != null) {
		    List<ProjectMemberDTO> dibsOngoing = projectservice.dibsOngoing(projectSeqArray);
		    return dibsOngoing;
		}		
		return null;
	}
	
	
	
	//찜한 프로젝트 - 종료된
	@PostMapping("/getDibsEnd")
	@ResponseBody
	List<ProjectMemberDTO> getDibsEnd(@RequestBody List<Integer> projectSeqArray) {
		
		if (projectSeqArray != null) {
		    List<ProjectMemberDTO> dibsEnd = projectservice.dibsEnd(projectSeqArray);
		    return dibsEnd;
		}		
		return null;
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
	    
		int memberSeq = (int) session.getAttribute("login_user_seq");	
		MemberDTO loginMemberSeq = memberservice.loginMemberSeq(memberSeq);
		List<DeliveryDTO> getDelivery = deliveryservice.getDelivery(memberSeq);	
		
		ModelAndView mv = new ModelAndView("member/settings");		
		mv.addObject("loginMember",loginMemberSeq);		
		mv.addObject("delivery",getDelivery);
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
		
		List<String> allMemberNick = memberservice.allMemberNick();
				
		// 중복 체크
		if (allMemberNick.stream().anyMatch(dupNick -> dupNick.equals(nickname))) {		    
		    return 2;	//중복
		} else {			
			int nicknameChange = memberservice.nicknameChange(memberSeq, nickname);
		    return nicknameChange; //update 성공 (1)
		}
	}
	

	//회원정보수정 - url 변경
	@PostMapping("/url_change")
	@ResponseBody
	public int urlChange(int memberSeq, String newUrl) {

		String newUrlPath = "/user_profile/" + newUrl;
		List<String> allMemberurl = memberservice.allMemberurl();
		
		// 중복 체크
		if (allMemberurl.stream().anyMatch(dupUrl -> dupUrl.equals(newUrlPath))) {		    
		    return 2;	//중복
		} else {			
			int urlChange = memberservice.urlChange(memberSeq, newUrlPath);
		    return urlChange; //update 성공 (1)
		}
		
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
	@PostMapping("/address_add")
	@ResponseBody
	public int addressAdd(int memberSeq, String name, String phone, String postcode, String road, String jibun, 
							String extra, String detail, String requeste,  boolean defaultAddress) {
		
		if (defaultAddress == true) {
			int allDefaultFalse = deliveryservice.allDefaultFalse(memberSeq); //다른 기본배송지 false 만들기
		} 			
		int addressAdd = deliveryservice.addressAdd(memberSeq, name, phone, postcode, road, jibun, extra, detail, requeste, defaultAddress );

		List<DeliveryDTO> getDelivery = deliveryservice.getDelivery(memberSeq);
		ModelAndView mv = new ModelAndView();		
		mv.addObject("delivery",getDelivery);		
		mv.setViewName("member/settings");
		
		return addressAdd;
	}
	
	
	//회원정보수정 - 추가한 배송지 삭제
	@PostMapping("/address_add_delete")
	@ResponseBody
	public int addressAddDelete(int memberSeq, String name, String phone, String postcode, String road, String jibun, 
							String extra, String detail) {	
		
		int addressAddDelete = deliveryservice.addressAddDelete(memberSeq, name, phone, postcode, road, jibun, extra, detail);		
		return addressAddDelete;
	}
	
	
	//회원정보수정 - 기존 배송지 삭제
	@PostMapping("/address_delete")
	@ResponseBody
	public int addressDelete(int memberSeq, String name, String phone, String postcode, String road, String detail) {	
		
		int addressDelete = deliveryservice.addressDelete(memberSeq, name, phone, postcode, road, detail);		
		return addressDelete;
	}
	
	
	//회원정보수정 -> 탈퇴
	@GetMapping("/unregister")
	public ModelAndView unregister(HttpSession session) {  
	    
		int memberSeq = (int) session.getAttribute("login_user_seq");	
		MemberDTO loginMemberSeq = memberservice.loginMemberSeq(memberSeq);
		
		ModelAndView mv = new ModelAndView("member/unregister");		
		mv.addObject("loginMember",loginMemberSeq);
		return mv;		
	}
	
	//회원탈퇴
	@PostMapping("/member_unregister")
	@ResponseBody
	public String memberUnregister(int memberSeq) {	
				
		//프로젝트 지우기 - 종료된 프로젝트는 삭제하지 않음, 4번까지삭제
		int unregisterProjectDelete = projectservice.unregisterProjectDelete(memberSeq);
		
		//팔로우에서 삭제하기
		int unregisterFollowDelete = followservice.unregisterFollowDelete(memberSeq);
		
		//멤버 resign 변경
		int unregisterDelStatusChange = memberservice.unregisterDelStatusChange(memberSeq);		
		if(unregisterDelStatusChange == 1) {
			return "resign 업데이트";
		}		
		return "회원 삭제 오류";
	}
	
	
	
	
	//내가 올린 프로젝트 - 전체
    @GetMapping("/myproject")
    public ModelAndView myproject(HttpSession session) {

        int memberSeq = (int) session.getAttribute("login_user_seq");
        List<ProjectDTO> myprojectList = projectservice.getAllProjectsMemberSeq(memberSeq);


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
    	return requestAdmit;    
    }
    

    
    //내가 올린 프로젝트 - 진행중
    @GetMapping("/funding_start")
    @ResponseBody
    public List<ProjectDTO> fundingStart(int memberSeq) {
    	
    	List<ProjectDTO> fundingStart = projectservice.fundingStart(memberSeq);
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
