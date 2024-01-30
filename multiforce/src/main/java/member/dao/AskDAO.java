package member.dao;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import member.dto.AskDTO;

@Repository
@Mapper
public interface AskDAO {
	AskDTO selectChatRoom(int project_seq, int collector_seq, int asker_seq);

	int insertChat(int project_seq, int collector_seq, int asker_seq, String my_chat);

	int updateChat(String who_am_i, String my_chat, int chatroom_seq, int read_at);
}
