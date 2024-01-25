package board.dto;

import java.util.Date;

import org.springframework.stereotype.Component;
@Component
public class UpdateReplyDTO {
	 	private int updateReplySeq;
	    private int updateSeq;
	    private int memberSeq;
	    private String content;
	    private Date time;
	    private int delStatus;
	    private Date delDate;



	    public int getUpdateReplySeq() {
	        return updateReplySeq;
	    }

	    public void setUpdateReplySeq(int updateReplySeq) {
	        this.updateReplySeq = updateReplySeq;
	    }

	    public int getUpdateSeq() {
	        return updateSeq;
	    }

	    public void setUpdateSeq(int updateSeq) {
	        this.updateSeq = updateSeq;
	    }

	    public int getMemberSeq() {
	        return memberSeq;
	    }

	    public void setMemberSeq(int memberSeq) {
	        this.memberSeq = memberSeq;
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

	    public int getDelStatus() {
	        return delStatus;
	    }

	    public void setDelStatus(int delStatus) {
	        this.delStatus = delStatus;
	    }

	    public Date getDelDate() {
	        return delDate;
	    }

	    public void setDelDate(Date delDate) {
	        this.delDate = delDate;
	    }
}
