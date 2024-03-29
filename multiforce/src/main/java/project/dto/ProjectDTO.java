package project.dto;

import java.text.DecimalFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

import org.springframework.stereotype.Component;

import member.dto.MemberDTO;
import project.code.ProjectCategory;
import project.code.ProjectProcess;

@Component
public class ProjectDTO {

	int project_seq;
	int member_seq;
	String content;
	int goal_price;
	int collection_amount;
	LocalDate start_date;
	LocalDate due_date;
	String long_title;
	String short_title;
	String sub_title;
	String url;
	ProjectCategory category;
	boolean gift_status;
	boolean gift_delivery;
	int dibs_count;
	int share_count;
	String account;
	String main_images_url;
	LocalDate delivery_date;
	ProjectProcess project_process;
	long term;
	String goal_price_format;
	String collection_amount_format;
	MemberDTO memberDTO;
	String purpose;
	String planning;
	String budget;
	String team_introduce;
	String item_introduce;
	String nickname;
	int view_count;
	
	
	
	
	
	public int getView_count() {
		return view_count;
	}
	public void setView_count(int view_count) {
		this.view_count = view_count;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public MemberDTO getMemberDTO() {
		return memberDTO;
	}
	public void setMemberDTO(MemberDTO memberDTO) {
		this.memberDTO = memberDTO;
	}
	public String getGoal_price_format() {
		return goal_price_format;
	}
	public void setGoal_price_format() {
		DecimalFormat format = new DecimalFormat("###,###");
		this.goal_price_format = format.format(goal_price);
	}
	public String getCollection_amount_format() {
		return collection_amount_format;
	}
	public void setCollection_amount_format() {
		DecimalFormat format = new DecimalFormat("###,###");
		this.collection_amount_format = format.format(collection_amount);
	}
	public long getTerm() {
		return term;
	}
	public void setTerm() {
		this.term = ChronoUnit.DAYS.between(LocalDate.now(), due_date);
	}
	public String getCategory() {
		return category.getEngName();
	}
	public void setCategory(String category) {
		this.category = ProjectCategory.valueOf(category.toUpperCase());
	}
	public String getCategory_kor() {
		return category.getKorName();
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
		setGoal_price_format();
	}
	public int getCollection_amount() {
		return collection_amount;
	}
	public void setCollection_amount(int collection_amount) {
		this.collection_amount = collection_amount;
		setCollection_amount_format();
	}
	public LocalDate getStart_date() {
		return start_date;
	}
	public void setStart_date(LocalDate start_date) {
		this.start_date = start_date;
	}
	public LocalDate getDue_date() {
		return due_date;
	}
	public void setDue_date(LocalDate due_date) {
		this.due_date = due_date;
		setTerm();
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
	public LocalDate getDelivery_date() {
		return delivery_date;
	}
	public void setDelivery_date(LocalDate delivery_date) {
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
	public String getPurpose() {
		return purpose;
	}
	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}
	public String getPlanning() {
		return planning;
	}
	public void setPlanning(String planning) {
		this.planning = planning;
	}
	public String getBudget() {
		return budget;
	}
	public void setBudget(String budget) {
		this.budget = budget;
	}
	public String getTeam_introduce() {
		return team_introduce;
	}
	public void setTeam_introduce(String team_introduce) {
		this.team_introduce = team_introduce;
	}
	public String getItem_introduce() {
		return item_introduce;
	}
	public void setItem_introduce(String item_introduce) {
		this.item_introduce = item_introduce;
	}
	
	@Override
	public String toString() {
		return "ProjectDTO [project_seq=" + project_seq + ", member_seq=" + member_seq + ", content=" + content
				+ ", goal_price=" + goal_price + ", collection_amount=" + collection_amount + ", start_date="
				+ start_date + ", due_date=" + due_date + ", long_title=" + long_title + ", short_title=" + short_title
				+ ", sub_title=" + sub_title + ", url=" + url + ", category=" + category + ", gift_status="
				+ gift_status + ", gift_delivery=" + gift_delivery + ", dibs_count=" + dibs_count + ", share_count="
				+ share_count + ", account=" + account + ", main_images_url=" + main_images_url + ", delivery_date="
				+ delivery_date + ", project_process=" + project_process + ", term=" + term + ", goal_price_format="
				+ goal_price_format + ", collection_amount_format=" + collection_amount_format + ", memberDTO="
				+ memberDTO + ", purpose=" + purpose + ", planing=" + planning + ", budget=" + budget
				+ ", team_introduce=" + team_introduce + ", item_introduce=" + item_introduce + "]";
	}
	
	
	
}