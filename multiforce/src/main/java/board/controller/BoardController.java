package board.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import board.dto.BoardDTO;

import board.dto.updateBoardDTO;
import board.service.boardService;
import jakarta.servlet.http.HttpSession;
import project.dto.ProjectDTO;

@Controller
public class BoardController {
	@Autowired
	private boardService boardService;
	
	@GetMapping("update/write")
	public String WriteUpdateBoard() {

        return "board/update_write"; 
    }
	
	@PostMapping("update_write")
	 public String updateWriteProcess(
             @RequestParam String contents,
             Model model) {
	


	int tmpUser = 1;
	int tmpProjectSeq = 3;
	updateBoardDTO dto = new updateBoardDTO();

	dto.setContent(contents);
	dto.setMemberSeq(tmpUser);
	dto.setProjectSeq(tmpProjectSeq);
	
	
	boardService.saveUpdateBoard(dto);
	

	
	return "redirect:board/update_write";
	}


	//1:1 고객센터
	@GetMapping("cs/write-form")
    public String CustomerServiceWrite(Model model) {
    	model.addAttribute("boardType", "cs");
        return "board/cs_write"; 
    }
	
	
//	//프로젝트 승인 리스트
//	@GetMapping("project_approve_list")
//	public String showAppoveList(Model model) {
//		List<ProjectDTO> projects = boardService.getAllProjects(); 
//        model.addAttribute("projects", projects);
//		return "board/project_approve_list";
//	}
//	
//	//프로젝트 상세
//	@GetMapping("project_detail")
//	public String ShowProjectDetail() {
//		return "board/project_detail";
//	}
//	
//	//프로젝트 상세 내 커뮤니티
//	@GetMapping("project_detail/community")
//	public String ShowProjectCommunity() {
//		return "board/project_community";
//	}
	

	@PostMapping("boardwrite")
    public String writeProcess(@RequestParam String title,
                               @RequestParam String contents,
                               Model model) {
        
		System.out.println("POST LIVE");
		int tmpUser = 1;
        BoardDTO dto = new BoardDTO();
        dto.setTitle(title);
        dto.setContent(contents);
        dto.setMemberSeq(tmpUser);

        
        boardService.saveBoard(dto);
        
        System.out.println("Inserted Board Data:");
        System.out.println("Title: " + dto.getTitle());
        System.out.println("Content: " + dto.getContent());
        System.out.println("MemberSeq: " + dto.getMemberSeq());

        return "redirect:cs/write-form";
    }
	
}
