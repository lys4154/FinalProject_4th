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
import board.service.BoardService;
import jakarta.servlet.http.HttpSession;
import member.dto.MemberDTO;
import member.service.MemberService;
import project.dto.ProjectDTO;
import project.service.ProjectService;

@Controller
public class BoardController {
	@Autowired
	private BoardService boardService;
	@Autowired
	private ProjectService projectService;
	@Autowired
	private MemberService member;
	
	@GetMapping("update/write/{project_seq}")
	public String WriteUpdateBoard(HttpSession session, Model model,
			@PathVariable("project_seq") int project_seq) {
		
		Object currentUserObj = session.getAttribute("login_user_seq");
		if (currentUserObj != null) {
			String currentUserString = (String) session.getAttribute("login_user_seq");
			int currentUser = Integer.parseInt(currentUserString); //현재 회원 번호
			model.addAttribute("loggedin_user", currentUser);
			
			//프로젝트 권한있는지?
			boolean userIsProjectManager = boardService.userIsProjectManager(project_seq, currentUser);
			
			if(userIsProjectManager == true) {
				model.addAttribute("project_seq", project_seq);
				return "board/update_write"; 
			}
			
		
		}
		//메인페이지로 바꾸기
        return "board/update_write"; 
    }
	
	//업데이트 글읽기
	@GetMapping("update/view/{project_seq}")
	public String UpdateShow(Model model, @PathVariable("project_seq") int project_seq, 
			HttpSession session) {
		
		Object currentUserObj = session.getAttribute("login_user_seq");

		
		List<updateBoardDTO> project_dto = boardService.getAllUpdatePost(project_seq);

		//로그인된 회원이라면
		if (currentUserObj != null) {
			
			String currentUserString = (String) session.getAttribute("login_user_seq");
        	
			//로그인된 회원 아이디 정수형으로 변환하기
			int currentUser = Integer.parseInt(currentUserString);
        	model.addAttribute("loggedin_user", currentUser);
        	
        	//후원자인지 true/false 리턴하기 
        	boolean userIsFunding = boardService.isUserFunding(currentUser, project_seq);
	        model.addAttribute("userIsFunding", userIsFunding);
	        
	        for (updateBoardDTO update : project_dto) {

	        	//포스트마다 유저가 좋아요 눌렀는지 true/false 리턴하기
	            boolean likedByCurrentUser = boardService.isUpdateLikedByUser(update.getUpdate_seq(), currentUser);
	            update.setLikedByCurrentUser(likedByCurrentUser);
	        }
	    }
		
		model.addAttribute("project", project_dto);
		return "board/update_view";
	}
	
	@PostMapping("update_write")
	 public String updateWriteProcess(
             @RequestParam String contents,
             Model model, HttpSession session, @RequestParam int project_seq) {
	

		Object currentUserObj = session.getAttribute("login_user_seq");
		updateBoardDTO dto = new updateBoardDTO();
		
		if (currentUserObj != null) {
			String currentUserString = (String) session.getAttribute("login_user_seq");
        	
			//로그인된 회원 아이디 정수형으로 변환하기
			int currentUser = Integer.parseInt(currentUserString);

			
			boolean userIsProjectManager = boardService.userIsProjectManager(project_seq, currentUser);

			if(userIsProjectManager == true) {
				dto.setContent(contents);
				dto.setMember_seq(currentUser);
				dto.setProject_seq(project_seq);
				
				
				boardService.saveUpdateBoard(dto);
				return "redirect:update/view/"+dto.getProject_seq();
			}
			
		}
		
		
	
		//메인 페이지 로 바꾸기
		return "redirect:update/view/"+dto.getProject_seq();
	}
	//커뮤니티 글 삭제
	@PostMapping("delete_community_post")
	public ResponseEntity<String> deleteCommunityPost(@RequestParam int pro_board_seq, HttpSession session) {
		int current_user = 0;
		LocalDateTime del_date = LocalDateTime.now();


		
		try {
	        String loggedInUserId = (String) session.getAttribute("login_user_seq");
	        current_user = Integer.parseInt(loggedInUserId);
	        //여기 작업중

	        CommunityDTO communityPost = boardService.getCommunityPostByBoardSeq(pro_board_seq);

	        if (communityPost != null && current_user == communityPost.getMember_seq()) {
//		        	System.out.println("같은사람 맞음");
	        	boardService.deleteCommunityPost(pro_board_seq, del_date);
	            return new ResponseEntity<>("삭제 성공", HttpStatus.OK);
	        } else {
	            return new ResponseEntity<>("삭제 권한이 없습니다", HttpStatus.FORBIDDEN);
	        }
	    } catch (Exception e) {
	        return new ResponseEntity<>("삭제 실패", HttpStatus.INTERNAL_SERVER_ERROR);
	    }
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
	@PostMapping("delete_community_reply")
	public ResponseEntity<String> deleteCommunityComment(@RequestParam int pro_board_seq, HttpSession session) {
		int current_user = 0;
		LocalDateTime del_date = LocalDateTime.now();
		
		try {
	        String loggedInUserId = (String) session.getAttribute("login_user_seq");
	        
	        current_user = Integer.parseInt(loggedInUserId);
	        
	        //작업중 여기
	        CommunityDTO CommunityComment = boardService.getCommunityCommentByReplySeq(pro_board_seq);
	   
	        System.out.println(current_user+" / "+CommunityComment.getMember_seq());
	        if (CommunityComment != null && current_user == CommunityComment.getMember_seq()) {
	        	
	        	boardService.deleteCommunityComment(pro_board_seq, del_date);
	            return new ResponseEntity<>("삭제 성공", HttpStatus.OK);
	        } else {
	            return new ResponseEntity<>("삭제 권한이 없습니다", HttpStatus.FORBIDDEN);
	        }
	    } catch (Exception e) {
	    	//e.printStackTrace();
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
	public String showPostDetail(@PathVariable("help_ask_seq") int help_ask_seq, Model model,
			HttpSession session) {
		BoardDTO board = boardService.getCsPostById(help_ask_seq);
		//로그인된 유저 아이디 가져옴 
		String user_id_str = (String) session.getAttribute("login_user_seq");
		int user_id = Integer.parseInt(user_id_str);
		
		//글쓴이가 본인인지 확인하기 아니면 관리자인가
		if((board.getMember_seq() == user_id) || 
				(Integer.parseInt(session.getAttribute("login_user_level").toString()) == 2)) {
				List<BoardDTO> board_comment = boardService.getCsCommentsById(help_ask_seq);
		        MemberDTO post_writer = member.getNicknameById(board.getMember_seq());
		        
		        List<Map<String, String>> comments = new ArrayList<>();
		        
		        for (BoardDTO comment : board_comment) {
		        	Map<String, String> commentMap = new HashMap<>();
		        	MemberDTO nick = member.getNicknameById(board.getMember_seq());
		            commentMap.put("nickname", nick.getNickname());
		            commentMap.put("content", comment.getContent());
		            commentMap.put("member_seq", String.valueOf(comment.getMember_seq()));
		            commentMap.put("help_ask_seq", String.valueOf(comment.getHelp_ask_seq()));
		            commentMap.put("date", comment.getHelp_ask_date().toString());
		            
		            comments.add(commentMap);
		        }
		
		        model.addAttribute("comments", comments);
		        model.addAttribute("loggedin_user",user_id);
		        model.addAttribute("board_comment",board_comment); //댓글들
		        model.addAttribute("board", board);
		        model.addAttribute("post_writer",post_writer.getNickname()); //게시물 작성자 닉네임 
		        return "board/cs_board_read";
			
		}else {
		    System.out.println("권한없음");
		    model.addAttribute("errorMessage", "권한이 없습니다.");
		    return "board/error/error"; 
		}
		
        
        
    }
	@GetMapping("edit_cs_post/{help_ask_seq}")
	public String editCsPost(@PathVariable("help_ask_seq") int help_ask_seq,
			Model model,HttpSession session) {
		
		
		
		Object currentUserObj = session.getAttribute("login_user_seq");
		
		if (currentUserObj != null) {
			String currentUserString = (String) session.getAttribute("login_user_seq");
			
			//로그인된 회원 아이디 정수형으로 변환하기
			int currentUser = Integer.parseInt(currentUserString);
        	model.addAttribute("loggedin_user", currentUser);
        	
        	
        	BoardDTO board = boardService.getCsPostById(help_ask_seq);
        	model.addAttribute("board", board);
        	return "board/edit_cs_post";
        	
		}
		
		return null;
	}
	@PostMapping("delete_cs_comment")
	public ResponseEntity<String> delete_cs_comment(@RequestParam int help_ask_seq, HttpSession session) {
		int current_user = 0;
		LocalDateTime del_date = LocalDateTime.now();
		
		try {
	        String loggedInUserId = (String) session.getAttribute("login_user_seq");
	        
	        current_user = Integer.parseInt(loggedInUserId);
	        
	        BoardDTO csComment = boardService.getCsCommentByPostId(help_ask_seq);

	        if (csComment != null && current_user == csComment.getMember_seq()) {
	        	
	        	boardService.deleteCsComment(help_ask_seq, del_date);

	            return new ResponseEntity<>("삭제 성공", HttpStatus.OK);
	        } else {
	            return new ResponseEntity<>("삭제 권한이 없습니다", HttpStatus.FORBIDDEN);
	        }
	    } catch (Exception e) {
//	    	e.printStackTrace();
	        return new ResponseEntity<>("삭제 실패", HttpStatus.INTERNAL_SERVER_ERROR);
	    }
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
		        @RequestParam int board_seq, @RequestParam int project_seq, HttpSession session) {
		    
			
			// post_id = project_seq
			int current_user = 0;
			String loggedInUserId = (String) session.getAttribute("login_user_seq");
			current_user = Integer.parseInt(loggedInUserId);
			
			boolean userIsFunding = boardService.isUserFunding(current_user, project_seq);
			

	
		    //NOT NULL이라 임시로 카테고리 저장
		    String tmpCategory = "cheer";
		    
		    //후원하는게 맞으면 댓글 진행 
		    CommunityDTO reply = new CommunityDTO();
		    if(userIsFunding == true ) {
				
		    	reply.setMember_seq(current_user);
			    reply.setParent_seq(board_seq);
			    reply.setProject_seq(project_seq);
			    reply.setCategory(tmpCategory);
			    reply.setContent(comment);
			    reply.setDate(new Date()); 
			    boardService.insertCommunityReply(reply); 
			}
		    
		    

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
