package member.dto;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component
public class DeliveryDTO {
	
	int delivery_seq;
	int member_seq;
	String name;
	String phone;
	String postcode;
	String road_address;
	String jibun_address;
	String extra_address;
	String detail_address;	
	String requeste;
	boolean default_address;
	
	
	public int getDelivery_seq() {
		return delivery_seq;
	}
	public void setDelivery_seq(int delivery_seq) {
		this.delivery_seq = delivery_seq;
	}
	public int getMember_seq() {
		return member_seq;
	}
	public void setMember_seq(int member_seq) {
		this.member_seq = member_seq;
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
	public String getRequeste() {
		return requeste;
	}
	public void setRequeste(String requeste) {
		this.requeste = requeste;
	}
	public boolean isDefault_address() {
		return default_address;
	}
	public void setDefault_address(boolean default_address) {
		this.default_address = default_address;
	}
	
	@Override
	public String toString() {
		return "DeliveryDTO [delivery_seq=" + delivery_seq + ", member_seq=" + member_seq + ", name=" + name
				+ ", phone=" + phone + ", postcode=" + postcode + ", road_address=" + road_address + ", jibun_address="
				+ jibun_address + ", extra_address=" + extra_address + ", detail_address=" + detail_address
				+ ", requeste=" + requeste + ", default_address=" + default_address + "]";
	}
	
	
	
}
