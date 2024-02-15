package project.controller;


import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import project.code.ProjectCategory;
import board.dto.BoardDTO;
import board.dto.CommunityDTO;
import board.dto.UpdateReplyDTO;
import board.dto.updateBoardDTO;
import board.service.BoardService;
import io.micrometer.common.util.StringUtils;
import jakarta.servlet.http.HttpSession;
import member.dto.MemberDTO;
import member.service.MemberService;
import project.dto.BundleDTO;
import project.dto.ItemDTO;
import project.dto.ItemListDTO;
import project.dto.ItemOptionDTO;
import project.dto.ProjectDTO;
import project.service.BundleService;
import project.service.ItemListService;
import project.service.ItemOptionService;
import project.service.ItemService;
import project.service.ProjectService;



@Controller
public class ProjectController {
	@Autowired
	private ProjectService projectService;
	
	@Autowired
    private MemberService memberService;
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private BundleService bundleService;
	
	@Autowired
	private ItemService itemService;
	
	@Autowired
	private ItemOptionService itemOptionService;
	
	@Autowired
	private ItemListService itemListService;
	
	
	@RequestMapping("/projectdesign")
	public String projectDesign() {
		return "project/projectdesign";
	}
	
	@RequestMapping("/projectinform")
	public String projectInform() {
		return "project/projectinform";
	}
	
	@RequestMapping("/projectmanagement")
	public String projectManagement() {
		return "project/projectmanagement";
	}
	//반려이유 가져오기
	@GetMapping("/rejection-reason/{project_seq}")
    @ResponseBody
    public String getRejectionReason(@PathVariable("project_seq") Integer project_seq) {
		String reason = projectService.getRejectReason(project_seq);
        
        return reason != null ? reason : "반려 이유를 가져오는 데 실패했습니다.";
    }
	//프로젝트 승인 리스트
	@GetMapping("project_approve_list")
	public String showAppoveList(Model model, HttpSession session) {
		
		//세션 레벨 가져오기

		Object user_level_attribute = session.getAttribute("login_user_level");

		int current_user = 0;
		if(user_level_attribute != null) {
			current_user = (int) session.getAttribute("login_user_level");
		}else {
			model.addAttribute("errorMessage", "해당 페이지에 권한이 없습니다.");
			return "board/error/error";
		}



			if(current_user == 2) {
				int approvedCount = projectService.approvedCount(); 
				int unapprovedCount = projectService.unapprovedCount();
				int rejectedCount = projectService.rejectedCount();
				
				
				model.addAttribute("approvedCount", approvedCount);
				model.addAttribute("unapprovedCount", unapprovedCount);
				model.addAttribute("rejectedCount", rejectedCount);
				return "project/project_approve_list";
			}
		
		
		
		  model.addAttribute("errorMessage", "해당 페이지에 권한이 없습니다.");
		  return "board/error/error";
		
	}

	@GetMapping("project_reject/{project_seq}")
	public String showRejectDetail(Model model, 
			@PathVariable("project_seq") int project_seq, HttpSession session) {
		//세션 레벨 가져오기
		int current_user = (int)session.getAttribute("login_user_level");

		
		//관리자라면 페이지 접근허용
		if(current_user == 2) {
			ProjectDTO project_detail = projectService.getProjectDetail(project_seq);
			MemberDTO member_nick = memberService.getNicknameById(project_detail.getMember_seq());

			model.addAttribute("project", project_detail);
			model.addAttribute("member_nickname", member_nick);
			return "project/project_reject";
		}
		  model.addAttribute("errorMessage", "해당 페이지에 권한이 없습니다.");
		  return "board/error/error";
		
	}
	
	//프로젝트 반려 and 승인 상세
	@GetMapping("project_approve_detail/{project_seq}")
	public String showApproveDetail(Model model, @PathVariable("project_seq") int project_seq) {
		
		ProjectDTO project_detail = projectService.getProjectDetail(project_seq);
		model.addAttribute("project", project_detail);
		return null;
	}
	
	//승인 리스트
	@GetMapping("approve_list/approved")
	 public String showApprovedOnly(Model model, @RequestParam(defaultValue = "0") int page) {
        int pageSize = 10; // 페이지당 아이템 수

        int totalProjects = projectService.approvedCount(); // 총 프로젝트 수

        int totalPages = (int) Math.ceil((double) totalProjects / pageSize); // 전체 페이지 수
        


        List<ProjectDTO> projects = projectService.getApprovedProjectsPage(page, pageSize);
        
        for (ProjectDTO project : projects) {
            int memberSeq = project.getMember_seq();
            MemberDTO project_user = memberService.getNicknameById(memberSeq);
            String member = project_user.getNickname();
            
            project.setNickname(member);
        }

        model.addAttribute("style", "approved");
        model.addAttribute("projects", projects);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);

        return "project/approve_list_table";
    }
	//반려 리스트
	@GetMapping("approve_list/rejected")
	public String showRejectedOnly(Model model, @RequestParam(defaultValue = "0") int page) {
		int pageSize = 10; // 페이지당 아이템 수

        int totalProjects = projectService.rejectedCount(); // 총 프로젝트 수

        int totalPages = (int) Math.ceil((double) totalProjects / pageSize); // 전체 페이지 수
        
		List<ProjectDTO> projects = projectService.getRejectedProjectsPage(page, pageSize);
		
		for (ProjectDTO project : projects) {
            int memberSeq = project.getMember_seq();
            MemberDTO project_user = memberService.getNicknameById(memberSeq);
            String member = project_user.getNickname();
            
            project.setNickname(member);
        }
		
		model.addAttribute("style","rejected");
		  model.addAttribute("projects", projects);
	        model.addAttribute("currentPage", page);
	        model.addAttribute("totalPages", totalPages);
		return "project/approve_list_table";
		
	}
	//승인 대기 리스트
	@GetMapping("approve_list/unapproved")
	public String showUnapprovedOnly(Model model, @RequestParam(defaultValue = "0") int page) {
		int pageSize = 10; // 페이지당 아이템 수

	    int totalProjects = projectService.unapprovedCount(); // 총 프로젝트 수

	    int totalPages = (int) Math.ceil((double) totalProjects / pageSize); // 전체 페이지 수
		
		List<ProjectDTO> projects = projectService.getUnapprovedProjects(page, pageSize); 
		
		for (ProjectDTO project : projects) {
            int memberSeq = project.getMember_seq();
            MemberDTO project_user = memberService.getNicknameById(memberSeq);
            String member = project_user.getNickname();
            
            project.setNickname(member);
        }
		
		 model.addAttribute("style", "unapproved");
	        model.addAttribute("projects", projects);
	        model.addAttribute("currentPage", page);
	        model.addAttribute("totalPages", totalPages);
	        
		return "project/approve_list_table";
		
	}
	
	@GetMapping("test_account")
	public String setTestAccount(HttpSession session) {
		String id = "user123";
		session.setAttribute("login_user_id", id);
		session.setAttribute("login_user_level", 1);
		session.setAttribute("login_user_name", "일반회원");
		session.setAttribute("login_user_seq", 1);
		return "board/test";
	}
	@GetMapping("test_account2")
	public String setTestAccountTwo(HttpSession session) {
		String id = "test";
		session.setAttribute("login_user_id", id);
		session.setAttribute("login_user_level", 2);
		session.setAttribute("login_user_name", "일반회원");
		session.setAttribute("login_user_seq", 2);
		return "board/test";
	}
	
	@GetMapping("current_user")
	public String currentUser() {
		return "board/test";
	}
	@GetMapping("test_logout")
	@ResponseStatus(HttpStatus.OK)
	public void simulateLogout(HttpSession session) {
	    session.invalidate();
	}

	//프로젝트 상세

	@GetMapping("project_detail/{url}")
	public String ShowProjectDetail(Model model,@PathVariable("url") String url) {
		String fullurl = "/project_detail/" + url;
		ProjectDTO projects = projectService.getProjectMember(fullurl);
		List<BundleDTO> bundleList = bundleService.getBundleList(projects.getProject_seq());
		System.out.println(projects.getBudget());
		System.out.println(projects.getItem_introduce());
		System.out.println(projects.getTeam_introduce());
		System.out.println(projects.getPlanning());
		System.out.println(projects.getProject_seq());
		
		model.addAttribute("project", projects);
		model.addAttribute("bundleList", bundleList);
		return "project/project_detail";
	}
	

	//업데이트 댓글 가져오기
	@GetMapping("/getComments")
	@ResponseBody
	public List<UpdateReplyDTO> getComments(@RequestParam("updateSeq") int updateSeq) {
	    return boardService.getCommentsByUpdateSeq(updateSeq);
	}
	//업데이트 좋아요 수 
	@GetMapping("/getLikeCount")
	@ResponseBody
	public ResponseEntity<Integer> getLikeCount(@RequestParam("updateSeq") int updateSeq) {
	    
		int count = boardService.getUpdatedLikeCount(updateSeq);
	
	    return ResponseEntity.ok(count);
	}
	//커뮤니티 좋아요 수 
	@GetMapping("/getCommLikeCount")
	@ResponseBody
	public ResponseEntity<Integer> getCommLikeCount(@RequestParam("pro_board_seq") int pro_board_seq) {
	    
		int count = boardService.getCommLikeCount(pro_board_seq);
	
	    return ResponseEntity.ok(count);
	}
	// 커뮤니티 좋아요 / 좋아요 취소
		@PostMapping("/toggleCommunityLike")
		public ResponseEntity<Map<String, Object>> toggleCommunityLikePost(@RequestParam("pro_board_seq") int pro_board_seq,
				HttpSession session) {
		   
			//로그인된 유저 아이디 가져옴 
			int user_id = (int) session.getAttribute("login_user_seq");
			
			
		    ResponseEntity<String> responseEntity = boardService.toggleCommunityLike(pro_board_seq, user_id);

		    Map<String, Object> responseMap = new HashMap<>();
		    
		    if (responseEntity.getStatusCode() == HttpStatus.OK) {
		        responseMap.put("status", "success");
		        responseMap.put("likedByCurrentUser", boardService.isCommunityLikedByUser(pro_board_seq, user_id));
		        return ResponseEntity.ok(responseMap);
		    } else {
		        responseMap.put("status", "error");
		        responseMap.put("message", "게시물 좋아요 실패");
		        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(responseMap);
		    }
		}
	// 업데이트 좋아요 / 좋아요 취소
	@PostMapping("/toggleUpdateLike")
	public ResponseEntity<Map<String, Object>> toggleLikePost(@RequestParam("updateSeq") int updateSeq,
			HttpSession session) {
	   
		//로그인된 유저 아이디 가져옴 
		int user_id = (int) session.getAttribute("login_user_seq");

		
	    ResponseEntity<String> responseEntity = boardService.toggleUpdateLike(updateSeq, user_id);

	    Map<String, Object> responseMap = new HashMap<>();
	    
	    if (responseEntity.getStatusCode() == HttpStatus.OK) {
	        responseMap.put("status", "success");
	        responseMap.put("likedByCurrentUser", boardService.isUpdateLikedByUser(updateSeq, user_id));
	        return ResponseEntity.ok(responseMap);
	    } else {
	        responseMap.put("status", "error");
	        responseMap.put("message", "게시물 좋아요 실패");
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(responseMap);
	    }
	}


	//업데이트 댓글 달기 POST
	@PostMapping("update_comment")
	public String InsertUpdateComment(@RequestParam String comment, 
	        @RequestParam int update_seq, HttpSession session, Model model) {
	    
		//현재 유저 세션 가져오기
		int current_user = 0;
		current_user = (int) session.getAttribute("login_user_seq");

			
		if (current_user != 0) {

		    UpdateReplyDTO reply = new UpdateReplyDTO();
		    reply.setMember_seq(current_user);
		    reply.setUpdate_seq(update_seq);
		    reply.setContent(comment);
		    reply.setTime(new Date()); 
		    
		
		    
		    boardService.insertUpdateReply(reply); 
	
		    return "redirect:project_detail/"+update_seq;
		}
		model.addAttribute("errorMessage", "권한이 없습니다.");
		return "board/error/error";
	   
	}

	
	
	//프로젝트 상세 내 커뮤니티
	@GetMapping("project_detail/community/{project_seq}")
	public String ShowProjectCommunity(@PathVariable("project_seq") int project_seq,
			Model model,HttpSession session) {

		//현재 유저 세션 가져오기
		Object currentUserObj = session.getAttribute("login_user_seq");
		
		ProjectDTO project_info = projectService.getProjectDetail(project_seq);
		List<CommunityDTO> com_post = boardService.getAllCommPost(project_seq);
		
		
		//로그인된 회원이라면
		if (currentUserObj != null) {
			
			int currentUser = (int) session.getAttribute("login_user_seq");
        	
			//로그인된 회원 아이디 정수형으로 변환하기
        	model.addAttribute("loggedin_user", currentUser);
        	
        	//후원자인지 true/false 리턴하기 
        	boolean userIsFunding = boardService.isUserFunding(currentUser, project_seq);
	        model.addAttribute("userIsFunding", userIsFunding);
	        
	        
	    }
		
		for (CommunityDTO community : com_post) {

        	
            if(currentUserObj != null) {
            	//포스트마다 유저가 좋아요 눌렀는지 true/false 리턴하기
	            boolean likedByCurrentUser = boardService.isCommunityLikedByUser(community.getPro_board_seq(), (int)currentUserObj);
	            community.setLikedByCurrentUser(likedByCurrentUser);
	            
            }
            int memberSeq = community.getMember_seq();
            
            MemberDTO post_user = memberService.getNicknameById(memberSeq);
            String member_nick = post_user.getNickname();
            
            community.setNickname(member_nick);
   
            
        }

		
		model.addAttribute("community_posts", com_post);
		model.addAttribute("projects", project_info);
		
		return "project/project_community";
	}
	
	
	
	@PostMapping("community_post")
	public String saveCommunityPost(@RequestParam String post_category, @RequestParam int post_id, 
			@RequestParam String content, HttpSession session) {
		// post_id = project_seq
		int current_user = 0;
		current_user = (int) session.getAttribute("login_user_seq");

		
		boolean userIsFunding = boardService.isUserFunding(current_user, post_id);
        
		CommunityDTO com_post = new CommunityDTO();
		//후원하는 프로젝트면 글작성 진행
		if(userIsFunding == true ) {
			
			com_post.setProject_seq(post_id);
			com_post.setContent(content);
			com_post.setCategory(post_category);
			com_post.setMember_seq(current_user);
			boardService.saveCommunityPost(com_post);
		}
		
		
		
		
		return "redirect:project_detail/"+post_id;
	}

	@RequestMapping("/tab_info")
	public String tabInfo() {
		return "project/tab_info";
	}
	
	@RequestMapping("tab_item")
	public String tabItem() {
		return "project/tab_item";
	}
	
	@PostMapping("/saveProject")
    @ResponseBody
    public String saveProject(@RequestBody ProjectDTO projectDTO, HttpSession session) {
        try {
            // 프로젝트 생성 서비스 호출
            projectService.createProject(projectDTO, session);
            return "Success";
        } catch (Exception e) {
            e.printStackTrace();
            return "Error";
        }
    }
	

	
	@GetMapping("/getProject")
    public String getProject(@RequestParam int memberSeq, Model model) {
        // memberSeq에 해당하는 프로젝트 정보 가져오기
        List<ProjectDTO> getProject = projectService.getProject(memberSeq);
        model.addAttribute("getProject", getProject); 
        return "getProject";
    }
	
//    @GetMapping("/getProject")
//    @ResponseBody
//    public List<ProjectDTO> getProjectsForMember() {
//        int memberSeq = getCurrentMemberSeq();
//        return projectService.getProjectsByMemberSeq(memberSeq);
//    }
//
//    private int getCurrentMemberSeq() {
//        return 1; // 
//    }
	
	@PostMapping("/projectInfo")
	public String projectInfo(ProjectDTO dto, Model model) {
		model.addAttribute("dto", dto);
		return "project/projectmain";
	}
	
//	@RequestMapping("/tab_fundingPlan")
//	public String tabFundingPlan() {
//		return "project/tab_fundingPlan";
//	}
//	
//	//펀딩계획저장
//	@RequestMapping("/submitFundingPlan")
//    public String insertFundingPlan(@RequestBody ProjectDTO fundingPlanDTO, Model model) {
//        try {
//            // FundingService를 통해 펀딩 계획 데이터를 DB에 저장
//            projectService.insertFundingPlan(fundingPlanDTO);
//            model.addAttribute("message", "펀딩 계획이 성공적으로 제출되었습니다.");
//        } catch (Exception e) {
//            e.printStackTrace();
//            model.addAttribute("error", "펀딩 계획 제출 중 오류가 발생했습니다.");
//        }
//
//        return "forward:/funding/tab_fundingPlan.jsp";
//    }
	
	@RequestMapping("/tab_gift")
	public String tabGift() {
		return "project/tab_gift";
	}
	
	@PostMapping("saveBundle")
	@ResponseBody
	public String savePackages(@RequestBody BundleDTO bundleDTO, HttpSession session) {
		try {
			bundleService.createBundle(bundleDTO, session);
//			itemService.createItem(itemdto, session);	
			return "Success";
		} catch (Exception e) {
			e.printStackTrace();
			return "Error";
		}
	}
	
	@PostMapping("/saveItem")
	@ResponseBody
	public String saveItem(@RequestBody ItemDTO itemDTO, HttpSession session) {
		try {
			itemService.createItem(itemDTO, session);
			return "Success";
		} catch (Exception e) {
			e.printStackTrace();
			return "Error";
		}
	}
	
	@PostMapping("/saveItemOption")
	@ResponseBody
	public String saveItemOption(@RequestBody ItemOptionDTO itemOptionDTO, HttpSession session) {
		try {
			if(StringUtils.isNotBlank(itemOptionDTO.getItem_option_name())) {
				itemOptionService.createItemOption(itemOptionDTO, session);
			}else {
				itemOptionService.defaultItemOption(itemOptionDTO, session);	
			}			
			return "Success";
		} catch (Exception e) {
			e.printStackTrace();
			return "Error";
		}
	}
	
	@PostMapping("/saveItemCount")
	@ResponseBody
	public String saveItemCount(@RequestBody ItemListDTO itemListDTO, HttpSession session) {
		try {
			itemListService.createItemList(itemListDTO, session);
			return "Success";
		} catch (Exception e) {
			e.printStackTrace();
			return "Error";
		}
	}
	
	
	@RequestMapping("/tab_projectPlan")
	public String tabProjectPlan() {
		return "project/tab_projectPlan";
	}
	
	@PostMapping("saveProjectPlan")
	@ResponseBody
	public String saveProjectPlan(@RequestBody ProjectDTO projectDTO, HttpSession session) {
		try {
			projectService.createProjectPlan(projectDTO, session);
			return "Success";
		} catch (Exception e) {
			e.printStackTrace();
			return "Error";
		}
	}
	
	@RequestMapping("/projectmain")
	public String projectMain() {
		return "project/projectmain";
	}
	
	//프로젝트 조회수 업데이트
	@PostMapping("/viewcountupdate")
	@ResponseBody
	public String viewCountUpdate(int project_seq) {
		int result = projectService.viewCountUpdate(project_seq);
		return "{\"result\": \"" + result + "\"}";
	}
	
	
}
