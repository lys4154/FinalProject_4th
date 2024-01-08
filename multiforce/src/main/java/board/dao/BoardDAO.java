package board.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import board.dto.BoardDTO;

@Repository
public class BoardDAO {
	@Autowired
	private final SqlSession sqlSession;
	
    public BoardDAO(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }
	
	 public void insertBoard(BoardDTO dto) {
        sqlSession.insert("insertBoard", dto);
     }
}
