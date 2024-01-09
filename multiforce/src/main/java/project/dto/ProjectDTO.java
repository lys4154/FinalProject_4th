package project.dto;

import java.time.LocalDateTime;

import org.springframework.stereotype.Component;

@Component
public class ProjectDTO {
	    private int projectSeq;
	    private int memberSeq;
	    private String content;
	    private int goalPrice;
	    private int collectionAmount;
	    private LocalDateTime startDate;
	    private LocalDateTime dueDate;
	    private String longTitle;
	    private String shortTitle;
	    private String subTitle;
	    private String url;
	    private String category;
	    private boolean approvalStatus;
	    private boolean giftStatus;
	    private Boolean giftDelivery;
	    private boolean goalAchieve;
	    private int dibsCount;
	    private int shareCount;
	    private String account;
	    private String mainImagesUrl;


	    public ProjectDTO(int projectSeq, int memberSeq, String content, int goalPrice, int collectionAmount,
                LocalDateTime startDate, LocalDateTime dueDate, String longTitle, String shortTitle,
                String subTitle, String url, String category, boolean approvalStatus, boolean giftStatus,
                Boolean giftDelivery, boolean goalAchieve, int dibsCount, int shareCount, String account,
                String mainImagesUrl) {
	    	
		  this.projectSeq = projectSeq;
		  this.memberSeq = memberSeq;
		  this.content = content;
		  this.goalPrice = goalPrice;
		  this.collectionAmount = collectionAmount;
		  this.startDate = startDate;
		  this.dueDate = dueDate;
		  this.longTitle = longTitle;
		  this.shortTitle = shortTitle;
		  this.subTitle = subTitle;
		  this.url = url;
		  this.category = category;
		  this.approvalStatus = approvalStatus;
		  this.giftStatus = giftStatus;
		  this.giftDelivery = giftDelivery;
		  this.goalAchieve = goalAchieve;
		  this.dibsCount = dibsCount;
		  this.shareCount = shareCount;
		  this.account = account;
		  this.mainImagesUrl = mainImagesUrl;
		}
	    
	    public int getProjectSeq() {
	    	
	    	return projectSeq;
	       
	    }

		public void setProjectSeq(int projectSeq) {
	        this.projectSeq = projectSeq;
	        
	    }

	    public int getMemberSeq() {
	    	 System.out.println("MS: "+projectSeq);
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

	    public int getGoalPrice() {
	        return goalPrice;
	    }

	    public void setGoalPrice(int goalPrice) {
	        this.goalPrice = goalPrice;
	    }

	    public int getCollectionAmount() {
	        return collectionAmount;
	    }

	    public void setCollectionAmount(int collectionAmount) {
	        this.collectionAmount = collectionAmount;
	    }

	    public LocalDateTime getStartDate() {
	        return startDate;
	    }

	    public void setStartDate(LocalDateTime startDate) {
	        this.startDate = startDate;
	    }

	    public LocalDateTime getDueDate() {
	        return dueDate;
	    }

	    public void setDueDate(LocalDateTime dueDate) {
	        this.dueDate = dueDate;
	    }

	    public String getLongTitle() {
	        return longTitle;
	    }

	    public void setLongTitle(String longTitle) {
	        this.longTitle = longTitle;
	    }

	    public String getShortTitle() {
	        return shortTitle;
	    }

	    public void setShortTitle(String shortTitle) {
	        this.shortTitle = shortTitle;
	    }

	    public String getSubTitle() {
	        return subTitle;
	    }

	    public void setSubTitle(String subTitle) {
	        this.subTitle = subTitle;
	    }

	    public String getUrl() {
	        return url;
	    }

	    public void setUrl(String url) {
	        this.url = url;
	    }

	    public String getCategory() {
	        return category;
	    }

	    public void setCategory(String category) {
	        this.category = category;
	    }

	    public boolean isApprovalStatus() {
	        return approvalStatus;
	    }

	    public void setApprovalStatus(boolean approvalStatus) {
	        this.approvalStatus = approvalStatus;
	    }

	    public boolean isGiftStatus() {
	        return giftStatus;
	    }

	    public void setGiftStatus(boolean giftStatus) {
	        this.giftStatus = giftStatus;
	    }

	    public Boolean getGiftDelivery() {
	        return giftDelivery;
	    }

	    public void setGiftDelivery(Boolean giftDelivery) {
	        this.giftDelivery = giftDelivery;
	    }

	    public boolean isGoalAchieve() {
	        return goalAchieve;
	    }

	    public void setGoalAchieve(boolean goalAchieve) {
	        this.goalAchieve = goalAchieve;
	    }

	    public int getDibsCount() {
	        return dibsCount;
	    }

	    public void setDibsCount(int dibsCount) {
	        this.dibsCount = dibsCount;
	    }

	    public int getShareCount() {
	        return shareCount;
	    }

	    public void setShareCount(int shareCount) {
	        this.shareCount = shareCount;
	    }

	    public String getAccount() {
	        return account;
	    }

	    public void setAccount(String account) {
	        this.account = account;
	    }

	    public String getMainImagesUrl() {
	        return mainImagesUrl;
	    }

	    public void setMainImagesUrl(String mainImagesUrl) {
	        this.mainImagesUrl = mainImagesUrl;
	    }


	

}
