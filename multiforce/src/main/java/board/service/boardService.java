package board.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import board.dto.BoardDTO;
import board.dao.BoardDAO;

@Service
public class boardService {
	@Autowired
    private BoardDAO boardDAO;
	public void saveBoard(BoardDTO dto) {
		boardDAO.insertBoard(dto);
    }
}
