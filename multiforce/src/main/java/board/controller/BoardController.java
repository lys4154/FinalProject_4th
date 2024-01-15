package board.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import board.dto.BoardDTO;

import board.dto.updateBoardDTO;
import board.service.boardService;
import jakarta.servlet.http.HttpSession;
import member.dto.MemberDTO;
import member.service.MemberService;
import project.dto.ProjectDTO;
import project.service.ProjectService;

@Controller
public class BoardController {
	@Autowired
	private boardService boardService;
	@Autowired
	private ProjectService projectService;
	@Autowired
	private MemberService member;
	
	@GetMapping("update/write")
	public String WriteUpdateBoard() {

        return "board/update_write"; 
    }
	
	//업데이트 글읽기
	@GetMapping("update/view/{project_seq}")
	public String UpdateShow(Model model, @PathVariable("project_seq") int project_seq) {
		BoardDTO project_dto = (BoardDTO) boardService.getAllUpdatePost(project_seq);
		model.addAttribute("project", project_dto);
		return "board/update_view";
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


	//1:1 고객센터 글쓰기
	@GetMapping("cs/write-form")
    public String CustomerServiceWrite(Model model) {
    	model.addAttribute("boardType", "cs");
        return "board/cs_write"; 
    }
	
	//게시물 리스트 페이징
	@GetMapping("board_list/cs")
	public String showAllCsPosts(Model model, @RequestParam(defaultValue = "0") int page) {
		int pageSize = 10; // 한 페이지에 보여줄 게시물 수
	    List<BoardDTO> allPosts = boardService.getAllCsPosts();
	    int totalPages = (int) Math.ceil((double) allPosts.size() / pageSize); // 전체 페이지 수 계산
	    
	    List<BoardDTO> postsOnPage = allPosts.subList(page * pageSize, Math.min((page + 1) * pageSize, allPosts.size())); // 현재 페이지에 보여줄 게시물 가져오기
	    model.addAttribute("posts", postsOnPage);
	    model.addAttribute("totalPages", totalPages);
	    model.addAttribute("currentPage", page);
	   
	    
	    return "board/cs_board_list"; // cs_board_list로 값 전달
	}
	
	//1:1 게시물 글보기, 댓글정보 보내기
	@GetMapping("cs/read_post/{help_ask_seq}")
	public String showPostDetail(@PathVariable("help_ask_seq") int help_ask_seq, Model model) {
        BoardDTO board = boardService.getCsPostById(help_ask_seq);
        List<BoardDTO> board_comment = boardService.getCsCommentsById(help_ask_seq);
        MemberDTO post_writer = member.getNicknameById(board.getMember_seq());
        
        List<Map<String, String>> comments = new ArrayList<>();
        
        for (BoardDTO comment : board_comment) {
        	Map<String, String> commentMap = new HashMap<>();
        	MemberDTO nick = member.getNicknameById(board.getMember_seq());
            commentMap.put("nickname", nick.getNickname());
            commentMap.put("content", comment.getContent());
            commentMap.put("date", comment.getHelp_ask_date().toString());
            
            comments.add(commentMap);
        }

        model.addAttribute("comments", comments);
        
        model.addAttribute("board_comment",board_comment); //댓글들
        model.addAttribute("board", board);
        model.addAttribute("post_writer",post_writer.getNickname()); //게시물 작성자 닉네임 
        return "board/cs_board_read";
    }

	// 댓글 작성 POST
	@PostMapping("cs_comment")
	public String writeCsComment(@RequestParam String comment
			,@RequestParam int post_id, Model model) {
		int tmpUser = 1;
		BoardDTO comment_dto = new BoardDTO();
		comment_dto.setTitle("title");
		comment_dto.setContent(comment);
		comment_dto.setMember_seq(tmpUser);
		comment_dto.setParent_seq(post_id);
		
		model.addAttribute("help_ask_seq", post_id);
		
		boardService.saveCsComment(comment_dto);
		
		return "redirect:cs/read_post/" + post_id;
		
	}
	
	//1:1 게시물 등록 POST
	@PostMapping("boardwrite")
    public String writeProcess(@RequestParam String title,
                               @RequestParam String contents,
                               Model model) {
        

		int tmpUser = 1;
        BoardDTO dto = new BoardDTO();
        dto.setTitle(title);
        dto.setContent(contents);
        dto.setMember_seq(tmpUser);

        
        boardService.saveBoard(dto);
        
        System.out.println("Inserted Board Data:");
        System.out.println("Title: " + dto.getTitle());
        System.out.println("Content: " + dto.getContent());
        System.out.println("MemberSeq: " + dto.getMember_seq());

        return "redirect:cs/write-form";
    }
	
}
