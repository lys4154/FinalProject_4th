package board.dto;

import java.time.LocalDateTime;

public class updateBoardDTO {



	    private int updateSeq;
	    private int projectSeq;
	    private int memberSeq;
	    private String content;
	    private LocalDateTime updateDate;
	    private Integer updateLikeCount;
	    private boolean delStatus;
	    private LocalDateTime delDate;

	    public int getUpdateSeq() {
	        return updateSeq;
	    }

	    public void setUpdateSeq(int updateSeq) {
	        this.updateSeq = updateSeq;
	    }

	    public int getProjectSeq() {
	        return projectSeq;
	    }

	    public void setProjectSeq(int projectSeq) {
	        this.projectSeq = projectSeq;
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

	    public LocalDateTime getUpdateDate() {
	        return updateDate;
	    }

	    public void setUpdateDate(LocalDateTime updateDate) {
	        this.updateDate = updateDate;
	    }

	    public Integer getUpdateLikeCount() {
	        return updateLikeCount;
	    }

	    public void setUpdateLikeCount(Integer updateLikeCount) {
	        this.updateLikeCount = updateLikeCount;
	    }

	    public boolean isDelStatus() {
	        return delStatus;
	    }

	    public void setDelStatus(boolean delStatus) {
	        this.delStatus = delStatus;
	    }

	    public LocalDateTime getDelDate() {
	        return delDate;
	    }

	    public void setDelDate(LocalDateTime delDate) {
	        this.delDate = delDate;
	    }
	

}
