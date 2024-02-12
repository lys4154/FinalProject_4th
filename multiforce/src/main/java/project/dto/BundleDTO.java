package project.dto;

import java.text.DecimalFormat;
import java.util.List;

import org.springframework.stereotype.Component;

@Component
public class BundleDTO {
	
	int bundle_seq;
	int project_seq;
	String bundle_name;
	int bundle_price;
	List<ItemListDTO> itemListDTOList;
	String bundle_price_format;
	
	public List<ItemListDTO> getItemListDTOList() {
		return itemListDTOList;
	}
	public void setItemListDTOList(List<ItemListDTO> itemListDTOList) {
		this.itemListDTOList = itemListDTOList;
	}
	public String getBundle_price_format() {
		return bundle_price_format;
	}
	public void setBundle_price_format() {
		DecimalFormat format = new DecimalFormat("###,###");
		this.bundle_price_format = format.format(bundle_price);
	}
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
		setBundle_price_format();
	}
	@Override
	public String toString() {
		return "BundleDTO [bundle_seq=" + bundle_seq + ", project_seq=" + project_seq + ", bundle_name=" + bundle_name
				+ ", bundle_price=" + bundle_price + ", itemListDTOList=" + itemListDTOList + ", bundle_price_format="
				+ bundle_price_format + "]";
	}
	
	
	
	
	
	
}
