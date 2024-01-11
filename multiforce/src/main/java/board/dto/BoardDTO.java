package board.dto;

import java.time.LocalDateTime;
import java.util.List;

public class BoardDTO {
	private int help_ask_seq;
    private int member_seq;
    private String title;
    private String content;
    private LocalDateTime help_ask_date;
    private Integer parent_seq;
    private int reply_status;
    
    
	public int getHelp_ask_seq() {
		return help_ask_seq;
	}
	public void setHelp_ask_seq(int help_ask_seq) {
		this.help_ask_seq = help_ask_seq;
	}
	public int getMember_seq() {
		return member_seq;
	}
	public void setMember_seq(int member_seq) {
		this.member_seq = member_seq;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public LocalDateTime getHelp_ask_date() {
		return help_ask_date;
	}
	public void setHelp_ask_date(LocalDateTime help_ask_date) {
		this.help_ask_date = help_ask_date;
	}
	public Integer getParent_seq() {
		return parent_seq;
	}
	public void setParent_seq(Integer parent_seq) {
		this.parent_seq = parent_seq;
	}
	public int getReply_status() {
		return reply_status;
	}
	public void setReply_status(int reply_status) {
		this.reply_status = reply_status;
	}
	
    


	

}
