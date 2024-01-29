package board.dao;

import java.time.LocalDateTime;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import board.dto.BoardDTO;
import board.dto.CommunityDTO;
import board.dto.UpdateReplyDTO;

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

	List<CommunityDTO> getAllCommPost(int project_seq);

	void insertUpdateReply(UpdateReplyDTO reply);

	List<UpdateReplyDTO> getCommentsByUpdateSeq(int update_seq);

	void insertCommunityReply(CommunityDTO reply);

	List<CommunityDTO> getCommCommentsByBoardSeq(int board_seq);

	boolean checkIfUpdateLikedByUser(int updateSeq, int loggedInUserId);

	void insertUpdateLike(int updateSeq, int loggedInUserId);

	int getUpdatedLikeCount(int updateSeq);

	int getUpdateSeqByProjectSeq(int project_seq);

	boolean isUpdateLikedByUser(int update_seq, int currentUser);

	void deleteUpdateLike(int updateSeq, int loggedInUserId);

	UpdateReplyDTO getUpdatePostByUpdateSeq(int update_seq);

	void deleteUpdatePost(int update_seq, LocalDateTime del_date);


	

}
