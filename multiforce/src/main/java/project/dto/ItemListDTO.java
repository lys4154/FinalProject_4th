package project.dto;

import org.springframework.stereotype.Component;

@Component
public class ItemListDTO extends BundleDTO{
	
	int item_list_seq;
	int item_seq;
	int item_count;
	int project_seq;
	String item_name;
	int item_option_seq;
	String item_option_name;
	public int getItem_list_seq() {
		return item_list_seq;
	}
	public void setItem_list_seq(int item_list_seq) {
		this.item_list_seq = item_list_seq;
	}
	public int getItem_seq() {
		return item_seq;
	}
	public void setItem_seq(int item_seq) {
		this.item_seq = item_seq;
	}
	public int getItem_count() {
		return item_count;
	}
	public void setItem_count(int item_count) {
		this.item_count = item_count;
	}
	public int getProject_seq() {
		return project_seq;
	}
	public void setProject_seq(int project_seq) {
		this.project_seq = project_seq;
	}
	public String getItem_name() {
		return item_name;
	}
	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}
	public int getItem_option_seq() {
		return item_option_seq;
	}
	public void setItem_option_seq(int item_option_seq) {
		this.item_option_seq = item_option_seq;
	}
	public String getItem_option_name() {
		return item_option_name;
	}
	public void setItem_option_name(String item_option_name) {
		this.item_option_name = item_option_name;
	}
	
	@Override
	public String toString() {
		return "ItemListDTO [item_list_seq=" + item_list_seq + ", item_seq=" + item_seq + ", item_count=" + item_count
				+ ", project_seq=" + project_seq + ", item_name=" + item_name + ", item_option_seq=" + item_option_seq
				+ ", item_option_name=" + item_option_name + ", bundle_seq=" + bundle_seq + ", bundle_name="
				+ bundle_name + ", bundle_price=" + bundle_price + "]";
	}
	
	
	
}
