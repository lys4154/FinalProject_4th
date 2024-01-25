package board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import board.dto.BoardDTO;
import board.dto.CommunityDTO;
import board.dto.UpdateReplyDTO;
import board.dto.updateBoardDTO;
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
	
	public List<UpdateReplyDTO> getCommentsByUpdateSeq(int update_seq){
		System.out.println("ID:"+update_seq);
		return boardDAO.getCommentsByUpdateSeq(update_seq);
	}
	
}