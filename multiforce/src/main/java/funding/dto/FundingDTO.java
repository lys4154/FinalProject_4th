package funding.dto;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.stereotype.Component;

import member.dto.MemberDTO;
import project.dto.FundingBundleCountDTO;
import project.dto.ProjectDTO;


@Component
public class FundingDTO{
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
	String phone;
	String requeste;
	String track_num;
	String track_status;	
	// 주소 수정	
	String road_address;
	String jibun_address;
	String extra_address;
	String detail_address;
	String postcode;
	List<FundingBundleCountDTO> bCountDTOList;
	ProjectDTO pDTO;
	MemberDTO collectorDTO;
	
	
	
	public ProjectDTO getpDTO() {
		return pDTO;
	}
	public void setpDTO(ProjectDTO pDTO) {
		this.pDTO = pDTO;
	}
	public MemberDTO getCollectorDTO() {
		return collectorDTO;
	}
	public void setCollectorDTO(MemberDTO collectorDTO) {
		this.collectorDTO = collectorDTO;
	}
	public List<FundingBundleCountDTO> getbCountDTOList() {
		return bCountDTOList;
	}
	public void setbCountDTOList(List<FundingBundleCountDTO> bCountDTOList) {
		this.bCountDTOList = bCountDTOList;
	}
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
	
	
	@Override
	public String toString() {
		return "FundingDTO [fund_seq=" + fund_seq + ", member_seq=" + member_seq + ", project_seq=" + project_seq
				+ ", price=" + price + ", fund_date=" + fund_date + ", fund_duedate=" + fund_duedate + ", fund_option="
				+ fund_option + ", del_status=" + del_status + ", del_date=" + del_date + ", pay_option=" + pay_option
				+ ", pay_number=" + pay_number + ", pay_status=" + pay_status + ", pay_date=" + pay_date + ", name="
				+ name + ", phone=" + phone + ", requeste=" + requeste + ", track_num=" + track_num + ", track_status="
				+ track_status + ", postcode=" + postcode + ", road_address=" + road_address + ", jibun_address="
				+ jibun_address + ", extra_address=" + extra_address + ", detail_address=" + detail_address + "]";
	}
	
}



