package project.dto;

import java.time.LocalDateTime;

import org.springframework.stereotype.Component;

import project.code.ProjectProcess;

@Component
public class ProjectDTO {

	int project_seq;
	int member_seq;
	String content;
	int goal_price;
	int collection_amount;
	LocalDateTime start_date;
	LocalDateTime due_date;
	String long_title;
	String short_title;
	String sub_title;
	String url;
	String category;
	boolean gift_status;
	boolean gift_delivery;
	int dibs_count;
	int share_count;
	String account;
	String main_images_url;
	LocalDateTime delivery_date;
	ProjectProcess project_process;
	
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
	public int getGoal_price() {
		return goal_price;
	}
	public void setGoal_price(int goal_price) {
		this.goal_price = goal_price;
	}
	public int getCollection_amount() {
		return collection_amount;
	}
	public void setCollection_amount(int collection_amount) {
		this.collection_amount = collection_amount;
	}
	public LocalDateTime getStart_date() {
		return start_date;
	}
	public void setStart_date(LocalDateTime start_date) {
		this.start_date = start_date;
	}
	public LocalDateTime getDue_date() {
		return due_date;
	}
	public void setDue_date(LocalDateTime due_date) {
		this.due_date = due_date;
	}
	public String getLong_title() {
		return long_title;
	}
	public void setLong_title(String long_title) {
		this.long_title = long_title;
	}
	public String getShort_title() {
		return short_title;
	}
	public void setShort_title(String short_title) {
		this.short_title = short_title;
	}
	public String getSub_title() {
		return sub_title;
	}
	public void setSub_title(String sub_title) {
		this.sub_title = sub_title;
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

	public boolean isGift_status() {
		return gift_status;
	}
	public void setGift_status(boolean gift_status) {
		this.gift_status = gift_status;
	}
	public boolean isGift_delivery() {
		return gift_delivery;
	}
	public void setGift_delivery(boolean gift_delivery) {
		this.gift_delivery = gift_delivery;
	}

	public int getDibs_count() {
		return dibs_count;
	}
	public void setDibs_count(int dibs_count) {
		this.dibs_count = dibs_count;
	}
	public int getShare_count() {
		return share_count;
	}
	public void setShare_count(int share_count) {
		this.share_count = share_count;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public String getMain_images_url() {
		return main_images_url;
	}

	public void setMain_images_url(String main_images_url) {
		this.main_images_url = main_images_url;
	}
	public LocalDateTime getDelivery_date() {
		return delivery_date;
	}
	public void setDelivery_date(LocalDateTime delivery_date) {
		this.delivery_date = delivery_date;
	}
	public int getProject_process() {
		return project_process.getCode();
	}
	public void setProject_process(int idx) {
		this.project_process = ProjectProcess.values()[idx];
	}
	public String getProject_process_name() {
		return project_process.getName();
	}
	@Override
	public String toString() {
		return "ProjectDTO [project_seq=" + project_seq + ", member_seq=" + member_seq + ", content=" + content
				+ ", goal_price=" + goal_price + ", collection_amount=" + collection_amount + ", start_date="
				+ start_date + ", due_date=" + due_date + ", long_title=" + long_title + ", short_title=" + short_title
				+ ", sub_title=" + sub_title + ", url=" + url + ", category=" + category + ", gift_status="
				+ gift_status + ", gift_delivery=" + gift_delivery + ", dibs_count=" + dibs_count + ", share_count="
				+ share_count + ", account=" + account + ", main_images_url=" + main_images_url + ", delivery_date="
				+ delivery_date + ", project_process=" + project_process + "]";
	}
	
	
}