package board.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import board.dto.BoardDTO;
import board.dto.CommunityDTO;
import board.dto.UpdateReplyDTO;
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
	public String UpdateShow(Model model, @PathVariable("project_seq") int project_seq, 
			HttpSession session) {
		
		Object currentUserObj = session.getAttribute("login_user_seq");

		
		List<updateBoardDTO> project_dto = boardService.getAllUpdatePost(project_seq);

		if (currentUserObj != null) {

	        for (updateBoardDTO update : project_dto) {

	        	String currentUserString = (String) session.getAttribute("login_user_seq");
	        	int currentUser = Integer.parseInt(currentUserString);
	            boolean likedByCurrentUser = boardService.isUpdateLikedByUser(update.getUpdate_seq(), currentUser);
	            boolean userIsFunding = boardService.isUserFunding(currentUser, project_seq);

	            model.addAttribute("userIsFunding", userIsFunding);
	            model.addAttribute("loggedin_user", currentUser);
	            update.setLikedByCurrentUser(likedByCurrentUser);
	        }
	    }
		
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
	dto.setMember_seq(tmpUser);
	dto.setProject_seq(tmpProjectSeq);
	
	
	boardService.saveUpdateBoard(dto);
	

	
	return "redirect:update/view/"+dto.getProject_seq();
	}

	//업데이트 댓글 삭제
	@PostMapping("delete_update_post")
	public ResponseEntity<String> deleteUpdatePost(@RequestParam int update_seq, HttpSession session) {
		int current_user = 0;
		LocalDateTime del_date = LocalDateTime.now();


		
		try {
	        String loggedInUserId = (String) session.getAttribute("login_user_seq");
	        current_user = Integer.parseInt(loggedInUserId);
	        updateBoardDTO updatePost = boardService.getUpdatePostByUpdateSeq(update_seq);

	        if (updatePost != null && current_user == updatePost.getMember_seq()) {
//	        	System.out.println("같은사람 맞음");

	        	boardService.deleteUpdatePost(update_seq, del_date);
	            return new ResponseEntity<>("삭제 성공", HttpStatus.OK);
	        } else {
	            return new ResponseEntity<>("삭제 권한이 없습니다", HttpStatus.FORBIDDEN);
	        }
	    } catch (Exception e) {
	        return new ResponseEntity<>("삭제 실패", HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	}
	@PostMapping("delete_update_reply")
	public ResponseEntity<String> deleteUpdateComment(@RequestParam int update_reply_seq, HttpSession session) {
		int current_user = 0;
		LocalDateTime del_date = LocalDateTime.now();
		
		try {
	        String loggedInUserId = (String) session.getAttribute("login_user_seq");
	        
	        current_user = Integer.parseInt(loggedInUserId);
	        
	        UpdateReplyDTO updateComment = boardService.getUpdateCommentByReplySeq(update_reply_seq);

	        if (updateComment != null && current_user == updateComment.getMember_seq()) {
	        	
	        	boardService.deleteUpdateComment(update_reply_seq, del_date);

	            return new ResponseEntity<>("삭제 성공", HttpStatus.OK);
	        } else {
	            return new ResponseEntity<>("삭제 권한이 없습니다", HttpStatus.FORBIDDEN);
	        }
	    } catch (Exception e) {
//	    	e.printStackTrace();
	        return new ResponseEntity<>("삭제 실패", HttpStatus.INTERNAL_SERVER_ERROR);
	    }
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
	
		//커뮤니티 댓글 달기 POST
		@PostMapping("communtiy_comment")
		public String InsertCommunityComment(@RequestParam String comment, 
		        @RequestParam int board_seq) {
		    
		    int tmpUser = 1;
		    int tmpProject = 3;
		    String tmpCategory = "cheer";
		    CommunityDTO reply = new CommunityDTO();
		    reply.setMember_seq(tmpUser);
		    reply.setParent_seq(board_seq);
		    reply.setProject_seq(tmpProject);
		    reply.setCategory(tmpCategory);
		    reply.setContent(comment);
		    reply.setDate(new Date()); 
		    boardService.insertCommunityReply(reply); 

		    return "redirect:project_detail/"+board_seq;
		}
	
	@GetMapping("/getCommComments")
	@ResponseBody
	public List<CommunityDTO> getComments(@RequestParam("board_seq") int board_seq) {

	    return boardService.getCommCommentsByBoardSeq(board_seq);
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
