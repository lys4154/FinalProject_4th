package member.dto;

import org.springframework.stereotype.Component;

@Component
public class FollowDTO {
	int follow_seq;
	int follower_seq;
	int following_seq;
	
	
	public int getFollow_seq() {
		return follow_seq;
	}
	public void setFollow_seq(int follow_seq) {
		this.follow_seq = follow_seq;
	}
	public int getFollower_seq() {
		return follower_seq;
	}
	public void setFollower_seq(int follower_seq) {
		this.follower_seq = follower_seq;
	}
	public int getFollowing_seq() {
		return following_seq;
	}
	public void setFollowing_seq(int following_seq) {
		this.following_seq = following_seq;
	}
	
	
	@Override
	public String toString() {
		return "FollowDTO [follow_seq=" + follow_seq + ", follower_seq=" + follower_seq + ", following_seq="
				+ following_seq + "]";
	}
		
	
}
