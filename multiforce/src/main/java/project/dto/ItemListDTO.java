package project.dto;

import java.util.List;

import org.springframework.stereotype.Component;

@Component

public class ItemListDTO {
	
	int item_list_seq;
	int item_seq;
	int bundle_seq;
	int item_count;
	ItemDTO itemDTO;

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
	public int getBundle_seq() {
		return bundle_seq;
	}
	public void setBundle_seq(int bundle_seq) {
		this.bundle_seq = bundle_seq;
	}
	public int getItem_count() {
		return item_count;
	}
	public void setItem_count(int item_count) {
		this.item_count = item_count;
	}
	public ItemDTO getItemDTO() {
		return itemDTO;
	}
	public void setItemDTO(ItemDTO itemDTO) {
		this.itemDTO = itemDTO;
	}
	
	
}
