package board.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import board.dto.BoardDTO;
import board.dto.CommunityDTO;
import board.dto.UpdateReplyDTO;
import board.dto.updateBoardDTO;
import member.dao.MemberDAO;
import member.dto.MemberDTO;
import member.service.MemberService;
import project.dao.ProjectDAO;
import project.dto.ProjectDTO;
import board.dao.BoardDAO;

import board.dao.UpdateBoardDAO;

@Service
public class BoardService {
    @Autowired
    private BoardDAO boardDAO;

    @Autowired
    private UpdateBoardDAO updateBoardDAO;
    
    @Autowired
    private MemberService memberService;
    
    //MemberService memberService = new MemberService();
    
    public void saveBoard(BoardDTO dto) {
        boardDAO.insertBoard(dto);
    }
    
    public void saveUpdateBoard(updateBoardDTO dto) {
        updateBoardDAO.insertUpdateBoard(dto);
    }
    public List<updateBoardDTO> getAllUpdatePost(int project_seq) {
        return updateBoardDAO.getAllUpdatePost(project_seq);
    }

    
    public List<BoardDTO> getAllCsPosts(){
		return boardDAO.getAllCsPosts();
	}
    public BoardDTO getCsPostById(int help_ask_seq){
    	return boardDAO.getCsPostById(help_ask_seq);
    }

	public void saveCsComment(BoardDTO comment_dto) {
		boardDAO.saveCsComment(comment_dto);
		
	}

	public List<BoardDTO> getCsCommentsById(int help_ask_seq) {
		return boardDAO.getCsCommentsById(help_ask_seq);
	}

	public void saveCommunityPost(CommunityDTO com_post) {
		boardDAO.saveCommunityPost(com_post);
		
	}
	public List<CommunityDTO> getAllCommPost(int project_seq){
		return boardDAO.getAllCommPost(project_seq);	
	}

	public void insertUpdateReply(UpdateReplyDTO reply) {
        boardDAO.insertUpdateReply(reply);
    }
	
	public void insertCommunityReply(CommunityDTO reply) {
        boardDAO.insertCommunityReply(reply);
    }
	
	public List<UpdateReplyDTO> getCommentsByUpdateSeq(int update_seq) {
	
	        List<UpdateReplyDTO> comments = boardDAO.getCommentsByUpdateSeq(update_seq);

	        for (UpdateReplyDTO comment : comments) {
	            MemberDTO member = memberService.getNicknameById(comment.getMember_seq());
	            comment.setMember(member);
	        }

	        return comments;

	}

	public List<CommunityDTO> getCommCommentsByBoardSeq(int board_seq) {
			List<CommunityDTO> comments = boardDAO.getCommCommentsByBoardSeq(board_seq);
	
	        for (CommunityDTO comment : comments) {
	            MemberDTO member = memberService.getNicknameById(comment.getMember_seq());
	            comment.setMember(member);
	        }
	
	        return comments;
	}

	public ResponseEntity<String> toggleUpdateLike(int updateSeq, int loggedInUserId) {
	    try {
	        boolean isLiked = checkIfUpdateLiked(updateSeq, loggedInUserId);

	        if (isLiked) {

	            performUnlikeAction(updateSeq, loggedInUserId);
	            return ResponseEntity.ok("게시물 좋아요 취소 성공");
	        } else {

	            performLikeAction(updateSeq, loggedInUserId);
	            return ResponseEntity.ok("게시물 좋아요 성공");
	        }

	    } catch (Exception e) {
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("게시물 좋아요 실패");
	    }
	}
	
	//커뮤니티 좋아요 기능 
	public ResponseEntity<String> toggleCommunityLike(int pro_board_seq, int loggedInUserId) {
	    try {
	        boolean isLiked = checkIfCommunityLiked(pro_board_seq, loggedInUserId);

	        if (isLiked) {

	        	performCommUnlikeAction(pro_board_seq, loggedInUserId);
	          
	            return ResponseEntity.ok("게시물 좋아요 취소 성공");
	        } else {

	            performCommLikeAction(pro_board_seq, loggedInUserId);
	            return ResponseEntity.ok("게시물 좋아요 성공");
	        }

	    } catch (Exception e) {
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("게시물 좋아요 실패");
	    }
	}
	private void performCommUnlikeAction(int pro_board_seq, int loggedInUserId) {
			boardDAO.deleteCommunityLike(pro_board_seq, loggedInUserId);
		
	}
	public void performCommLikeAction(int pro_board_seq, int loggedInUserId) {
		  
		   
        boardDAO.insertCommunityLike(pro_board_seq, loggedInUserId);
    
}
	private void performUnlikeAction(int updateSeq, int loggedInUserId) {
			boardDAO.deleteUpdateLike(updateSeq, loggedInUserId);
		
	}

	public void performLikeAction(int updateSeq, int loggedInUserId) {
	  
	   
	        boardDAO.insertUpdateLike(updateSeq, loggedInUserId);
	    
	}

	public boolean checkIfUpdateLiked(int updateSeq, int loggedInUserId) {
	    
	    boolean isLiked = boardDAO.checkIfUpdateLikedByUser(updateSeq, loggedInUserId);

	    return isLiked;
	}
	//커뮤니티 좋아요 눌렀는지
	public boolean checkIfCommunityLiked(int pro_board_seq, int loggedInUserId) {
	    
	    boolean isLiked = boardDAO.checkIfCommunityLikedByUser(pro_board_seq, loggedInUserId);

	    return isLiked;
	}

	public int getUpdatedLikeCount(int updateSeq) {
		return boardDAO.getUpdatedLikeCount(updateSeq);
	}

	public int getUpdateSeqByProjectSeq(int project_seq) {
		return boardDAO.getUpdateSeqByProjectSeq(project_seq);
	}

	public boolean isUpdateLikedByUser(int update_seq, int currentUser) {
		return boardDAO.isUpdateLikedByUser(update_seq, currentUser);
	}


	public updateBoardDTO getUpdatePostByUpdateSeq(int update_seq) {
		return boardDAO.getUpdatePostByUpdateSeq(update_seq);
	}

	public void deleteUpdatePost(int update_seq, LocalDateTime del_date) {
		boardDAO.deleteUpdatePost(update_seq, del_date);
		
	}

	public boolean isUserFunding(int member_seq, int project_seq) {
		return boardDAO.isUserFunding(member_seq, project_seq);
	}

	public UpdateReplyDTO getUpdateCommentByReplySeq(int update_reply_seq) {
		return boardDAO.getUpdateCommentByReplySeq(update_reply_seq);
	}

	public void deleteUpdateComment(int update_reply_seq, LocalDateTime del_date) {
		boardDAO.deleteUpdateComment(update_reply_seq, del_date);
		
	}

	public boolean isCommunityLikedByUser(int pro_board_seq, int currentUser) {

		return boardDAO.isCommunityLikedByUser(pro_board_seq, currentUser);
	}

	public int getCommLikeCount(int pro_board_seq) {
		return boardDAO.getCommLikeCount(pro_board_seq);
	}

	public CommunityDTO getCommunityPostByBoardSeq(int pro_board_seq) {
		return boardDAO.getCommunityPostByBoardSeq(pro_board_seq);
	}

	public void deleteCommunityPost(int pro_board_seq, LocalDateTime del_date) {
		boardDAO.deleteCommunityPost(pro_board_seq, del_date);
		
	}

	public CommunityDTO getCommunityCommentByReplySeq(int pro_board_seq) {
		System.out.println("COMMENT ID:"+pro_board_seq);
		return boardDAO.getCommunityCommentByReplySeq(pro_board_seq);
	}

	public void deleteCommunityComment(int pro_board_seq, LocalDateTime del_date) {
		boardDAO.deleteCommunityComment(pro_board_seq, del_date);
	}

	public boolean userIsProjectManager(int project_seq, int currentUser) {
		return boardDAO.userIsProjectManager(project_seq, currentUser);
	}

	
}