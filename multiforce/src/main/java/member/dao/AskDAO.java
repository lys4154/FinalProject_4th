package member.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import member.dto.AskDTO;

@Repository
@Mapper
public interface AskDAO {
	AskDTO selectChatRoom(int project_seq, int collector_seq, int asker_seq);

	int insertChat(int project_seq, int collector_seq, int asker_seq, String my_chat, String last_chat);

	int updateChat(String who_am_i, String my_chat, int chatroom_seq, int read_at);

	int updateMyRead(String who_am_i, int chatroom_seq, int read_at);

	List<AskDTO> selectColChatRoom(int login_user_seq);

	List<AskDTO> selectAskerChatRoom(int login_user_seq);

	int updateChat(String who_am_i, String my_chat, int chatroom_seq, int read_at, String last_chat);

	AskDTO findChatroom(String who_am_i, int chatroom_seq);
}
