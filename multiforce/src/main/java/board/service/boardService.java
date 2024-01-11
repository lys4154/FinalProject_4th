package board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import board.dto.BoardDTO;
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


	
}