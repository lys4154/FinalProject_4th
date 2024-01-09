package board.dto;

import java.time.LocalDateTime;

public class BoardDTO {



	 private int helpAskSeq;
	    private int memberSeq;
	    private String title;
	    private String content;
	    private LocalDateTime helpAskDate;
	    private Integer parentSeq; // Use Integer for nullable columns
	    private boolean replyStatus; // Assuming reply_status is mapped to a boolean

	    // Constructors, Getters, and Setters
	    // Constructor with all fields
	    public BoardDTO(int helpAskSeq, int memberSeq, String title, String content,
	                      LocalDateTime helpAskDate, Integer parentSeq, boolean replyStatus) {
	        this.helpAskSeq = helpAskSeq;
	        this.memberSeq = memberSeq;
	        this.title = title;
	        this.content = content;
	        this.helpAskDate = helpAskDate;
	        this.parentSeq = parentSeq;
	        this.replyStatus = replyStatus;
	    }

	    // Default constructor
	    public BoardDTO() {
	    }

	    // Getters and Setters for all fields
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

	    public boolean isReplyStatus() {
	        return replyStatus;
	    }

	    public void setReplyStatus(boolean replyStatus) {
	        this.replyStatus = replyStatus;
	    }
	

}
