package board.dto;

import java.time.LocalDateTime;

public class updateBoardDTO {



	 	private int update_seq;
	    private int project_seq;
	    private int member_seq;
	    private String content;
	    private LocalDateTime update_date;
	    private Integer update_like_cnt; 
	    private int del_status;
	    private LocalDateTime del_date;
	    boolean LikedByCurrentUser;
	    private String nickname;
	    private String formattedDate;
	    
		public String getFormattedDate() {
			return formattedDate;
		}
		public void setFormattedDate(String formattedDate) {
			this.formattedDate = formattedDate;
		}
		public String getNickname() {
			return nickname;
		}
		public void setNickname(String nickname) {
			this.nickname = nickname;
		}
		public boolean isLikedByCurrentUser() {
			return LikedByCurrentUser;
		}
		public void setLikedByCurrentUser(boolean likedByCurrentUser) {
			LikedByCurrentUser = likedByCurrentUser;
		}
		public int getUpdate_seq() {
			return update_seq;
		}
		public void setUpdate_seq(int update_seq) {
			this.update_seq = update_seq;
		}
		public int getProject_seq() {
			return project_seq;
		}
		public void setProject_seq(int project_seq) {
			this.project_seq = project_seq;
		}
		public int getMember_seq() {
			return member_seq;
		}
		public void setMember_seq(int member_seq) {
			this.member_seq = member_seq;
		}
		public String getContent() {
			return content;
		}
		public void setContent(String content) {
			this.content = content;
		}
		public LocalDateTime getUpdate_date() {
			return update_date;
		}
		public void setUpdate_date(LocalDateTime update_date) {
			this.update_date = update_date;
		}
		public Integer getUpdate_like_cnt() {
			return update_like_cnt;
		}
		public void setUpdate_like_cnt(Integer update_like_cnt) {
			this.update_like_cnt = update_like_cnt;
		}
		public int getDel_status() {
			return del_status;
		}
		public void setDel_status(int del_status) {
			this.del_status = del_status;
		}
		public LocalDateTime getDel_date() {
			return del_date;
		}
		public void setDel_date(LocalDateTime del_date) {
			this.del_date = del_date;
		}

	    
	

}
