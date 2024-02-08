package project.dto;

import java.util.List;

import org.springframework.stereotype.Component;

@Component
public class ItemDTO {
	
	int item_seq;
	int project_seq;
	String item_name;
	List<ItemOptionDTO> optionDTOList;

	public List<ItemOptionDTO> getOptionDTOList() {
		return optionDTOList;
	}
	public void setOptionDTOList(List<ItemOptionDTO> optionDTOList) {
		this.optionDTOList = optionDTOList;
	}
	public int getItem_seq() {
		return item_seq;
	}
	public void setItem_seq(int item_seq) {
		this.item_seq = item_seq;
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
	@Override
	public String toString() {
		return "ItemDTO [item_seq=" + item_seq + ", project_seq=" + project_seq + ", item_name=" + item_name
				+ ", optionDTOList=" + optionDTOList + "]";
	}
	

}
