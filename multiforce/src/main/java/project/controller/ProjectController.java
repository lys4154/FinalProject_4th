package project.controller;


import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import board.dto.BoardDTO;
import board.dto.CommunityDTO;
import board.dto.UpdateReplyDTO;
import board.service.boardService;
import jakarta.servlet.http.HttpSession;
import project.dto.ProjectDTO;
import project.service.ProjectService;

@Controller
public class ProjectController {
	@Autowired
	private ProjectService projectService;
	
	@Autowired
	private boardService boardService;
	
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

	//프로젝트 승인 리스트
	@GetMapping("project_approve_list")
	public String showAppoveList(Model model) {
		int approvedCount = projectService.approvedCount(); 
		int unapprovedCount = projectService.unapprovedCount();
		
		
		model.addAttribute("approvedCount", approvedCount);
		model.addAttribute("unapprovedCount", unapprovedCount);
		return "project/project_approve_list";
		
	}
	@GetMapping("project_reject/{project_seq}")
	public String showRejectDetail(Model model, @PathVariable("project_seq") int project_seq) {
		ProjectDTO project_detail = projectService.getProjectDetail(project_seq);
		model.addAttribute("project", project_detail);
		return "project/project_reject";
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
	public String showApprovedOnly(Model model) {
		List<ProjectDTO> projects = projectService.getAllApprovedProjects(); 
		
		
        model.addAttribute("projects", projects);
		return "project/approve_list_table";
		
	}
	
	//승인 대기 리스트
	@GetMapping("approve_list/unapproved")
	public String showUnapprovedOnly(Model model) {
		List<ProjectDTO> projects = projectService.getAllUnapprovedProjects(); 
		
		
        model.addAttribute("projects", projects);
		return "project/approve_list_table";
		
	}
	
	//프로젝트 상세
	@GetMapping("project_detail/{project_seq}")
	public String ShowProjectDetail(Model model,@PathVariable("project_seq") int project_seq) {
		ProjectDTO projects = projectService.getProjectDetail(project_seq);
		
		
		model.addAttribute("project", projects);

		return "project/project_detail";
	}
	//업데이트 댓글 가져오기
	@GetMapping("/getComments")
	@ResponseBody
	public List<UpdateReplyDTO> getComments(@RequestParam("updateSeq") int updateSeq) {
	    return boardService.getCommentsByUpdateSeq(updateSeq);
	}
	
	//업데이트 댓글 달기 POST
	@PostMapping("update_comment")
	public String InsertUpdateComment(@RequestParam String comment, 
	        @RequestParam int updateSeq) {
	    
	    int tmpUser = 1;
	    UpdateReplyDTO reply = new UpdateReplyDTO();
	    reply.setMember_seq(tmpUser);
	    reply.setUpdate_seq(updateSeq);
	    reply.setContent(comment);
	    reply.setTime(new Date()); 
	    
	    boardService.insertUpdateReply(reply); 

	    return "redirect:project_detail/"+updateSeq;
	}

	
	
	//프로젝트 상세 내 커뮤니티
	@GetMapping("project_detail/community/{project_seq}")
	public String ShowProjectCommunity(@PathVariable("project_seq") int project_seq,
			Model model) {
		
		ProjectDTO project_info = projectService.getProjectDetail(project_seq);
		List<CommunityDTO> com_post = boardService.getAllCommPost(project_seq);
		System.out.println(project_info);
		model.addAttribute("community_posts", com_post);
		model.addAttribute("projects", project_info);
		
		return "project/project_community";
	}
	
	
	
	@PostMapping("community_post")
	public String saveCommunityPost(@RequestParam String post_category, @RequestParam int post_id, 
			@RequestParam String content) {
		
		int tmpUser = 1;
		CommunityDTO com_post = new CommunityDTO();
		com_post.setProject_seq(post_id);
		com_post.setContent(content);
		com_post.setCategory(post_category);
		com_post.setMember_seq(tmpUser);
		
		boardService.saveCommunityPost(com_post);
		
		return "redirect:project_detail/community/"+post_id;
	}

	@RequestMapping("/tab_info")
	public String tabInfo() {
		return "project/tab_info";
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
	
	@RequestMapping("/tab_fundingPlan")
	public String tabFundingPlan() {
		return "project/tab_fundingPlan";
	}
	
	//펀딩계획저장
	@RequestMapping("/submitFundingPlan")
    public String insertFundingPlan(@RequestBody ProjectDTO fundingPlanDTO, Model model) {
        try {
            // FundingService를 통해 펀딩 계획 데이터를 DB에 저장
            projectService.insertFundingPlan(fundingPlanDTO);
            model.addAttribute("message", "펀딩 계획이 성공적으로 제출되었습니다.");
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "펀딩 계획 제출 중 오류가 발생했습니다.");
        }

        return "forward:/funding/tab_fundingPlan.jsp";
    }
	
	@RequestMapping("/tab_gift")
	public String tabGift() {
		return "project/tab_gift";
	}
	
	@RequestMapping("/tab_projectPlan")
	public String tabProjectPlan() {
		return "project/tab_projectPlan";
	}
	
	@RequestMapping("/projectmain")
	public String projectMain() {
		return "project/projectmain";
	}
	
}
