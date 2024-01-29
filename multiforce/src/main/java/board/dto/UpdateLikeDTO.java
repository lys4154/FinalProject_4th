package board.dto;

public class UpdateLikeDTO {
	 private int up_like_seq;
	 private int update_seq;
	 private int member_seq;
	 
	public int getUp_like_seq() {
		return up_like_seq;
	}
	public void setUp_like_seq(int up_like_seq) {
		this.up_like_seq = up_like_seq;
	}
	public int getUpdate_seq() {
		return update_seq;
	}
	public void setUpdate_seq(int update_seq) {
		this.update_seq = update_seq;
	}
	public int getMember_seq() {
		return member_seq;
	}
	public void setMember_seq(int member_seq) {
		this.member_seq = member_seq;
	}
	 
	 
}
