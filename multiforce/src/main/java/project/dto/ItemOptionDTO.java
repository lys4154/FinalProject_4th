package project.dto;

import org.springframework.stereotype.Component;

@Component
public class ItemOptionDTO {
	
	int item_seq;
	int bundle_seq;
	String item_name;
	
	
	public int getItem_seq() {
		return item_seq;
	}
	public void setItem_seq(int item_seq) {
		this.item_seq = item_seq;
	}
	public int getBundle_seq() {
		return bundle_seq;
	}
	public void setBundle_seq(int bundle_seq) {
		this.bundle_seq = bundle_seq;
	}
	public String getItem_name() {
		return item_name;
	}
	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}
	
	
	@Override
	public String toString() {
		return "ItemDTO [item_seq=" + item_seq + ", bundle_seq=" + bundle_seq + ", item_name=" + item_name + "]";
	}
	
	
	
	
	
}
