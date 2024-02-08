package funding.dto;

import org.springframework.stereotype.Component;

@Component
public class ChosenOptionDTO {
	
	int bundle_count_seq;
	int item_option_seq;
	
	public int getBundle_count_seq() {
		return bundle_count_seq;
	}
	public void setBundle_count_seq(int bundle_count_seq) {
		this.bundle_count_seq = bundle_count_seq;
	}
	public int getItem_option_seq() {
		return item_option_seq;
	}
	public void setItem_option_seq(int item_option_seq) {
		this.item_option_seq = item_option_seq;
	}
	
	
	
}
