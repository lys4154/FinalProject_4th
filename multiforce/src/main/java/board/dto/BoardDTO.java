package board.dto;

import java.time.LocalDateTime;

public class BoardDTO {
	 private int helpAskSeq;
	    private int memberSeq;
	    private String title;
	    private String content;
	    private LocalDateTime helpAskDate;
	    private Integer parentSeq;
	    private int replyStatus;

	    public int getHelpAskSeq() {
	        return helpAskSeq;
	    }

	    public void setHelpAskSeq(int helpAskSeq) {
	        this.helpAskSeq = helpAskSeq;
	    }

	    public int getMemberSeq() {
	        return memberSeq;
	    }

	    public void setMemberSeq(int memberSeq) {
	        this.memberSeq = memberSeq;
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

	    public LocalDateTime getHelpAskDate() {
	        return helpAskDate;
	    }

	    public void setHelpAskDate(LocalDateTime helpAskDate) {
	        this.helpAskDate = helpAskDate;
	    }

	    public Integer getParentSeq() {
	        return parentSeq;
	    }

	    public void setParentSeq(Integer parentSeq) {
	        this.parentSeq = parentSeq;
	    }

	    public int getReplyStatus() {
	        return replyStatus;
	    }

	    public void setReplyStatus(int replyStatus) {
	        this.replyStatus = replyStatus;
	    }
    
    
}
