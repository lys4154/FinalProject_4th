package project.dto;

import org.springframework.stereotype.Component;

@Component
public class ProjectDibsDTO {
	
	int pro_dibs_seq;
	int project_seq;
	int member_seq;
	
	
	public int getPro_dibs_seq() {
		return pro_dibs_seq;
	}
	public void setPro_dibs_seq(int pro_dibs_seq) {
		this.pro_dibs_seq = pro_dibs_seq;
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
	
	
	@Override
	public String toString() {
		return "ProjectDibsDTO [pro_dibs_seq=" + pro_dibs_seq + ", project_seq=" + project_seq + ", member_seq="
				+ member_seq + "]";
	}
	
}
