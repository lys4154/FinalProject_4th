package board.dto;

import java.util.Date;

import org.springframework.stereotype.Component;

import member.dto.MemberDTO;



@Component
public class UpdateReplyDTO {
		private int update_reply_seq;
	    private int update_seq;
	    private int member_seq;
	    private String content;
	    private Date time;
	    private int del_status;
	    private Date del_date;
	    private MemberDTO member;

	    
		public int getUpdate_reply_seq() {
			return update_reply_seq;
		}
		public void setUpdate_reply_seq(int update_reply_seq) {
			this.update_reply_seq = update_reply_seq;
		}
		public int getUpdate_seq() {
			return update_seq;
		}
		public void setUpdate_seq(int update_seq) {
			this.update_seq = update_seq;
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
		public Date getTime() {
			return time;
		}
		public void setTime(Date time) {
			this.time = time;
		}
		public int getDel_status() {
			return del_status;
		}
		public void setDel_status(int del_status) {
			this.del_status = del_status;
		}
		public Date getDel_date() {
			return del_date;
		}
		public void setDel_date(Date del_date) {
			this.del_date = del_date;
		}

	
		public MemberDTO getMember() {
	        return member;
	    }

	    public void setMember(MemberDTO member) {
	        this.member = member;
	    }

	   
}
