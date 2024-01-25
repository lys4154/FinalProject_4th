package member.dto;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component
public class MemberProfileImgDTO {
	int member_seq;
	MultipartFile profileImg;
	
	
	public int getMember_seq() {
		return member_seq;
	}
	public void setMember_seq(int member_seq) {
		this.member_seq = member_seq;
	}
	public MultipartFile getProfileImg() {
		return profileImg;
	}
	public void setProfileImg(MultipartFile profileImg) {
		this.profileImg = profileImg;
	}
	
	
	@Override
	public String toString() {
		return "MemberProfileImgDTO [member_seq=" + member_seq + ", profileImg=" + profileImg + "]";
	}
	
}
