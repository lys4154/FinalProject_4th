package project.dto;

import java.time.LocalDateTime;

import org.springframework.stereotype.Component;

import project.code.ProjectProcess;

@Component
public class ProjectMemberDTO {
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
	//==============회원부분===============
	String member_id; 
	String member_name;
	String nickname;
	String profile_img;
	String email;
	String description;
	int level;
	boolean gender;
	boolean resign;
	LocalDateTime resign_date;
	String postcode;
	String road_address;
	String jibun_address;
	String extra_address;
	String detail_address;
	
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
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getMember_name() {
		return member_name;
	}
	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getProfile_img() {
		return profile_img;
	}
	public void setProfile_img(String profile_img) {
		this.profile_img = profile_img;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	public boolean isGender() {
		return gender;
	}
	public void setGender(boolean gender) {
		this.gender = gender;
	}
	public boolean isResign() {
		return resign;
	}
	public void setResign(boolean resign) {
		this.resign = resign;
	}
	public LocalDateTime getResign_date() {
		return resign_date;
	}
	public void setResign_date(LocalDateTime resign_date) {
		this.resign_date = resign_date;
	}
	public String getPostcode() {
		return postcode;
	}
	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}
	public String getRoad_address() {
		return road_address;
	}
	public void setRoad_address(String road_address) {
		this.road_address = road_address;
	}
	public String getJibun_address() {
		return jibun_address;
	}
	public void setJibun_address(String jibun_address) {
		this.jibun_address = jibun_address;
	}
	public String getExtra_address() {
		return extra_address;
	}
	public void setExtra_address(String extra_address) {
		this.extra_address = extra_address;
	}
	public String getDetail_address() {
		return detail_address;
	}
	public void setDetail_address(String detail_address) {
		this.detail_address = detail_address;
	}
	
	
}
