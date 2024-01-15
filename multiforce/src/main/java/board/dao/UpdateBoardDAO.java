package board.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import board.dto.BoardDTO;
import board.dto.updateBoardDTO;

@Repository
@Mapper
public interface UpdateBoardDAO {
	
	
	void insertUpdateBoard(updateBoardDTO dto);
	
	List<updateBoardDTO> getAllUpdatePost(int project_seq);

}
