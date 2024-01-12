package board.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import board.dto.BoardDTO;
import board.dto.CommunityDTO;

@Repository
@Mapper
public interface BoardDAO {

	
	//1:1 게시판 데이터 insert
	void insertBoard(BoardDTO board);
    
	List<BoardDTO> getAllCsPosts();

	BoardDTO getCsPostById(int help_ask_seq);

	// CS 댓글 insert
	void saveCsComment(BoardDTO comment_dto);

	List<BoardDTO> getCsCommentsById(int help_ask_seq);

	void saveCommunityPost(CommunityDTO com_post);
	

}
