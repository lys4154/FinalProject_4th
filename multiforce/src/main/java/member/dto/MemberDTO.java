package member.dto;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.stereotype.Component;

@Component
public class MemberDTO {
	int member_seq;
	String member_id; 
	String password;
	String member_name;
	String nickname;
	String profile_img;
	String email;
	String address;
	String description;
	int level;
	boolean gender;
	boolean resign;
	LocalDateTime resign_date;
	
	
	public MemberDTO() {
		
	} 
	
	
	public MemberDTO(int member_seq, String member_id, String password, String member_name, String nickname,
			String profile_img, String email, String address, String description, int level, boolean gender,
			boolean resign, LocalDateTime resign_date) {
		super();
		this.member_seq = member_seq;
		this.member_id = member_id;
		this.password = password;
		this.member_name = member_name;
		this.nickname = nickname;
		this.profile_img = profile_img;
		this.email = email;
		this.address = address;
		this.description = description;
		this.level = level;
		this.gender = gender;
		this.resign = resign;
		this.resign_date = resign_date;
	}


	public int getMember_seq() {
		return member_seq;
	}
	public void setMember_seq(int member_seq) {
		this.member_seq = member_seq;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
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
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
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


	@Override
	public String toString() {
		return "MemberDTO [member_seq=" + member_seq + ", member_id=" + member_id + ", password=" + password
				+ ", member_name=" + member_name + ", nickname=" + nickname + ", profile_img=" + profile_img
				+ ", email=" + email + ", address=" + address + ", description=" + description + ", level=" + level
				+ ", gender=" + gender + ", resign=" + resign + ", resign_date=" + resign_date + "]";
	}


	
	
			
}
