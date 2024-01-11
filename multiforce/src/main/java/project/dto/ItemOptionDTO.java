package project.dto;

import org.springframework.stereotype.Component;

@Component
public class ItemOptionDTO {
	

	int item_option_seq;
	int item_seq;
	String item_option_name;
	
	
	public int getItem_option_seq() {
		return item_option_seq;
	}
	public void setItem_option_seq(int item_option_seq) {
		this.item_option_seq = item_option_seq;
	}

	public int getItem_seq() {
		return item_seq;
	}
	public void setItem_seq(int item_seq) {
		this.item_seq = item_seq;
	}

	public String getItem_option_name() {
		return item_option_name;
	}
	public void setItem_option_name(String item_option_name) {
		this.item_option_name = item_option_name;
	}
	
	
	@Override
	public String toString() {
		return "ItemOptionDTO [item_option_seq=" + item_option_seq + ", item_seq=" + item_seq + ", item_option_name="
				+ item_option_name + "]";
	}
	
	
	
	
	
}
