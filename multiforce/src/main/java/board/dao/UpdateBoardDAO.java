package board.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import board.dto.BoardDTO;
import board.dto.updateBoardDTO;

@Repository
public class UpdateBoardDAO {
	
	@Autowired
	private final SqlSession sqlSession;
	
	
    public UpdateBoardDAO(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }
	
	public void insertUpdateBoard(updateBoardDTO dto) {
		sqlSession.insert("insertUpdateBoard", dto);
	}
}
