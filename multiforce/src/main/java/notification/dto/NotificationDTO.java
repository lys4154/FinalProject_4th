package notification.dto;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

import org.springframework.stereotype.Component;

@Component
public class NotificationDTO {
	int notification_seq;
	int project_seq;
	int member_seq;
	String message;
	LocalDateTime notification_date;
	boolean is_read;
	long term;
	
	public long getTerm() {
		return term;
	}
	public void setTerm() {
		this.term = ChronoUnit.DAYS.between(LocalDate.now(), notification_date);
	}
	public int getNotification_seq() {
		return notification_seq;
	}
	public void setNotification_seq(int notification_seq) {
		this.notification_seq = notification_seq;
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
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public LocalDateTime getNotification_date() {
		return notification_date;
	}
	public void setNotification_date(LocalDateTime notification_date) {
		this.notification_date = notification_date;
		setTerm();
	}
	public boolean isIs_read() {
		return is_read;
	}
	public void setIs_read(boolean is_read) {
		this.is_read = is_read;
	}
	
	
}
