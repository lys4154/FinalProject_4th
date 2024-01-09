package project.dto;

import org.springframework.stereotype.Component;

@Component
public class BundleDTO {
	
	int bundle_seq;
	int project_seq;
	String bundle_name;
	int bundle_price;
	
	
	public int getBundle_seq() {
		return bundle_seq;
	}
	public void setBundle_seq(int bundle_seq) {
		this.bundle_seq = bundle_seq;
	}
	public int getProject_seq() {
		return project_seq;
	}
	public void setProject_seq(int project_seq) {
		this.project_seq = project_seq;
	}
	public String getBundle_name() {
		return bundle_name;
	}
	public void setBundle_name(String bundle_name) {
		this.bundle_name = bundle_name;
	}
	public int getBundle_price() {
		return bundle_price;
	}
	public void setBundle_price(int bundle_price) {
		this.bundle_price = bundle_price;
	}
	
	
	@Override
	public String toString() {
		return "BundleDTO [bundle_seq=" + bundle_seq + ", project_seq=" + project_seq + ", bundle_name=" + bundle_name
				+ ", bundle_price=" + bundle_price + "]";
	}
	
	
	
}
