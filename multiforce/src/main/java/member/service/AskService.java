package member.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import member.dao.AskDAO;
import member.dto.AskDTO;
import project.dao.ProjectDAO;
import project.dto.ProjectDTO;
import project.dto.ProjectMemberDTO;

@Service
public class AskService {
	@Autowired
	AskDAO askDao;
	@Autowired
	ProjectDAO projectDao;
	@Autowired
	AskDTO askDto;
	
	public AskDTO selectChatRoom(int project_seq, int collector_seq, int asker_seq) {
		AskDTO result = askDao.selectChatRoom(project_seq, collector_seq, asker_seq);
		if(result == null) {
			ProjectMemberDTO dto = projectDao.selectProjectMember(project_seq);
			result = askDto;
			result.setNickname(dto.getNickname());
			result.setLong_title(dto.getLong_title());
			result.setProfile_img(dto.getProfile_img());
			result.setMember_url(dto.getMember_url());
		}
		return result;
	}
	public HashMap<String, Object> insertMyFirstChat(int project_seq, int collector_seq, int asker_seq, String my_chat) {
		int result = askDao.insertChat(project_seq, collector_seq, asker_seq, my_chat);
		HashMap<String, Object> map = new HashMap<>();
		if(result == 0) {
			map.put("result", "오류");
		}else if(result == 1) {
			AskDTO dto = askDao.selectChatRoom(project_seq, collector_seq, asker_seq);
			map.put("result", "성공");
			map.put("chatroom_seq", dto.getChatroom_seq());
		}
		return map;
	}
	public int insertMyChat(String who_am_i, String my_chat, int chatroom_seq, int read_at) {
		int result = askDao.updateChat(who_am_i, my_chat, chatroom_seq, read_at);
		return 0;
	}


}
