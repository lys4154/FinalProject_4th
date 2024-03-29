package board.dto;

import java.time.LocalDateTime;
import java.util.Date;

import member.dto.MemberDTO;

public class CommunityDTO {
	private int pro_board_seq;
    private int project_seq;
    private int member_seq;
    private Date date;
    private String category;
    private String content;
    private Integer parent_seq;
    private int del_status;
    private LocalDateTime del_date;
    private MemberDTO member;
    private String nickname;
    private String kor_category;
    
    public String getKor_category() {
		return kor_category;
	}
	public void setKor_category(String kor_category) {
		this.kor_category = kor_category;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	boolean LikedByCurrentUser;
    
	public boolean isLikedByCurrentUser() {
		return LikedByCurrentUser;
	}
	public void setLikedByCurrentUser(boolean likedByCurrentUser) {
		LikedByCurrentUser = likedByCurrentUser;
	}
    
	public MemberDTO getMember() {
		return member;
	}
	public void setMember(MemberDTO member) {
		this.member = member;
	}
	public int getPro_board_seq() {
		return pro_board_seq;
	}
	public void setPro_board_seq(int pro_board_seq) {
		this.pro_board_seq = pro_board_seq;
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
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Integer getParent_seq() {
		return parent_seq;
	}
	public void setParent_seq(Integer parent_seq) {
		this.parent_seq = parent_seq;
	}
	public int getDel_status() {
		return del_status;
	}
	public void setDel_status(int del_status) {
		this.del_status = del_status;
	}
	public LocalDateTime getDel_date() {
		return del_date;
	}
	public void setDel_date(LocalDateTime del_date) {
		this.del_date = del_date;
	}
    
    
    
}
