package member.dto;

import org.springframework.stereotype.Component;

@Component
public class AskDTO {
	int chatroom_seq;
	int project_seq;
	int collector_seq;
	int asker_seq;
	String chat;
	String last_chat;
	int collector_read;
	int asker_read;
	String long_title;
	String nickname;
	String profile_img;
	String member_url;
	
	
	public String getProfile_img() {
		return profile_img;
	}
	public void setProfile_img(String profile_img) {
		this.profile_img = profile_img;
	}
	public String getMember_url() {
		return member_url;
	}
	public void setMember_url(String member_url) {
		this.member_url = member_url;
	}
	public String getLong_title() {
		return long_title;
	}
	public void setLong_title(String long_title) {
		this.long_title = long_title;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public int getChatroom_seq() {
		return chatroom_seq;
	}
	public void setChatroom_seq(int chatroom_seq) {
		this.chatroom_seq = chatroom_seq;
	}
	public int getProject_seq() {
		return project_seq;
	}
	public void setProject_seq(int project_seq) {
		this.project_seq = project_seq;
	}
	public int getCollector_seq() {
		return collector_seq;
	}
	public void setCollector_seq(int collector_seq) {
		this.collector_seq = collector_seq;
	}
	public int getAsker_seq() {
		return asker_seq;
	}
	public void setAsker_seq(int asker_seq) {
		this.asker_seq = asker_seq;
	}
	public String getChat() {
		return chat;
	}
	public void setChat(String chat) {
		this.chat = chat;
	}
	public String getLast_chat() {
		return last_chat;
	}
	public void setLast_chat(String last_chat) {
		this.last_chat = last_chat;
	}
	public int getCollector_read() {
		return collector_read;
	}
	public void setCollector_read(int collector_read) {
		this.collector_read = collector_read;
	}
	public int getAsker_read() {
		return asker_read;
	}
	public void setAsker_read(int asker_read) {
		this.asker_read = asker_read;
	}
	@Override
	public String toString() {
		return "AskDTO [chatroom_seq=" + chatroom_seq + ", project_seq=" + project_seq + ", collector_seq="
				+ collector_seq + ", asker_seq=" + asker_seq + ", chat=" + chat + ", last_chat=" + last_chat
				+ ", collector_read=" + collector_read + ", asker_read=" + asker_read + ", long_title=" + long_title
				+ ", nickname=" + nickname + ", profile_img=" + profile_img + ", member_url=" + member_url + "]";
	}
	
	
}
