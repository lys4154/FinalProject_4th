package funding.dto;

import java.time.LocalDateTime;

import org.springframework.stereotype.Component;


@Component
public class FundingDTO {
	int fund_seq;	
	int member_seq;
	int	project_seq;
	int	price;
	LocalDateTime fund_date;
	LocalDateTime fund_duedate;
	String fund_option;
	boolean del_status;
	LocalDateTime del_date;
	String pay_option;
	int pay_number;
	boolean pay_status;
	LocalDateTime pay_date;
	String name;
	String postalcode;
	String address;
	String address_detail;
	String phone;
	String requeste;
	String track_num;
	String track_status;
	
	
	
	public int getFund_seq() {
		return fund_seq;
	}
	public void setFund_seq(int fund_seq) {
		this.fund_seq = fund_seq;
	}
	public int getMember_seq() {
		return member_seq;
	}
	public void setMember_seq(int member_seq) {
		this.member_seq = member_seq;
	}
	public int getProject_seq() {
		return project_seq;
	}
	public void setProject_seq(int project_seq) {
		this.project_seq = project_seq;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public LocalDateTime getFund_date() {
		return fund_date;
	}
	public void setFund_date(LocalDateTime fund_date) {
		this.fund_date = fund_date;
	}
	public LocalDateTime getFund_duedate() {
		return fund_duedate;
	}
	public void setFund_duedate(LocalDateTime fund_duedate) {
		this.fund_duedate = fund_duedate;
	}
	public String getFund_option() {
		return fund_option;
	}
	public void setFund_option(String fund_option) {
		this.fund_option = fund_option;
	}
	public boolean isDel_status() {
		return del_status;
	}
	public void setDel_status(boolean del_status) {
		this.del_status = del_status;
	}
	public LocalDateTime getDel_date() {
		return del_date;
	}
	public void setDel_date(LocalDateTime del_date) {
		this.del_date = del_date;
	}
	public String getPay_option() {
		return pay_option;
	}
	public void setPay_option(String pay_option) {
		this.pay_option = pay_option;
	}
	public int getPay_number() {
		return pay_number;
	}
	public void setPay_number(int pay_number) {
		this.pay_number = pay_number;
	}
	public boolean isPay_status() {
		return pay_status;
	}
	public void setPay_status(boolean pay_status) {
		this.pay_status = pay_status;
	}
	public LocalDateTime getPay_date() {
		return pay_date;
	}
	public void setPay_date(LocalDateTime pay_date) {
		this.pay_date = pay_date;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPostalcode() {
		return postalcode;
	}
	public void setPostalcode(String postalcode) {
		this.postalcode = postalcode;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getAddress_detail() {
		return address_detail;
	}
	public void setAddress_detail(String address_detail) {
		this.address_detail = address_detail;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getRequeste() {
		return requeste;
	}
	public void setRequeste(String requeste) {
		this.requeste = requeste;
	}
	public String getTrack_num() {
		return track_num;
	}
	public void setTrack_num(String track_num) {
		this.track_num = track_num;
	}
	public String getTrack_status() {
		return track_status;
	}
	public void setTrack_status(String track_status) {
		this.track_status = track_status;
	}
	
	
	@Override
	public String toString() {
		return "FundingDTO [fund_seq=" + fund_seq + ", member_seq=" + member_seq + ", project_seq=" + project_seq
				+ ", price=" + price + ", fund_date=" + fund_date + ", fund_duedate=" + fund_duedate + ", fund_option="
				+ fund_option + ", del_status=" + del_status + ", del_date=" + del_date + ", pay_option=" + pay_option
				+ ", pay_number=" + pay_number + ", pay_status=" + pay_status + ", pay_date=" + pay_date + ", name="
				+ name + ", postalcode=" + postalcode + ", address=" + address + ", address_detail=" + address_detail
				+ ", phone=" + phone + ", requeste=" + requeste + ", track_num=" + track_num + ", track_status="
				+ track_status + "]";
	}
	
	

	
}



