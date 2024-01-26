package board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
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
public class boardService {
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
	
	public List<UpdateReplyDTO> getCommentsByUpdateSeq(int update_seq) {
	
	        List<UpdateReplyDTO> comments = boardDAO.getCommentsByUpdateSeq(update_seq);

	        for (UpdateReplyDTO comment : comments) {
	            MemberDTO member = memberService.getNicknameById(comment.getMember_seq());
	            comment.setMember(member);
	        }

	        return comments;

	}


	
}