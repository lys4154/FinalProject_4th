package admin.dto;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

import org.springframework.stereotype.Component;

@Component
public class NoticeDTO {
	
	int notice_seq;
	String title;
	String content;
	String category;
	LocalDateTime event_start_date;
	LocalDateTime event_end_date;
	String write_date;
	boolean del_status;
	String del_date;
	String event_status;
	
	public String getEvent_status() {
		return event_status;
	}
	public void setEvent_status() {
		if(ChronoUnit.MINUTES.between(LocalDateTime.now(), event_start_date) <= 0){
			if(ChronoUnit.MINUTES.between(LocalDateTime.now(), event_end_date) >= 0) {
				this.event_status = "진행중";
			}else {
				this.event_status = "종료";
			}
			
		}else {
			this.event_status = "예정";
		}
	}
	public int getNotice_seq() {
		return notice_seq;
	}
	public void setNotice_seq(int notice_seq) {
		this.notice_seq = notice_seq;
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
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	
	public LocalDateTime getEvent_start_date() {
		return event_start_date;
	}
	public void setEvent_start_date(LocalDateTime event_start_date) {
		this.event_start_date = event_start_date;
	}
	public LocalDateTime getEvent_end_date() {
		return event_end_date;
	}
	public void setEvent_end_date(LocalDateTime event_end_date) {
		this.event_end_date = event_end_date;
		setEvent_status();
	}
	public String getWrite_date() {
		return write_date;
	}
	public void setWrite_date(String write_date) {
		this.write_date = write_date;
	}
	public boolean isDel_status() {
		return del_status;
	}
	public void setDel_status(boolean del_status) {
		this.del_status = del_status;
	}
	public String getDel_date() {
		return del_date;
	}
	public void setDel_date(String del_date) {
		this.del_date = del_date;
	}
}
