package project.dto;

import java.util.List;

import org.springframework.stereotype.Component;

@Component
public class FundingBundleCountDTO {
	
	int bundle_count_seq;
	int fund_seq;
	int bundle_seq;
	int perchase_count;
	List<BundleDTO> bundleDTOList;
	
	public int getBundle_count_seq() {
		return bundle_count_seq;
	}
	public void setBundle_count_seq(int bundle_count_seq) {
		this.bundle_count_seq = bundle_count_seq;
	}
	public List<BundleDTO> getBundleDTOList() {
		return bundleDTOList;
	}
	public void setBundleDTOList(List<BundleDTO> bundleDTOList) {
		this.bundleDTOList = bundleDTOList;
	}
	public int getFund_seq() {
		return fund_seq;
	}
	public void setFund_seq(int fund_seq) {
		this.fund_seq = fund_seq;
	}
	public int getBundle_seq() {
		return bundle_seq;
	}
	public void setBundle_seq(int bundle_seq) {
		this.bundle_seq = bundle_seq;
	}
	public int getPerchase_count() {
		return perchase_count;
	}
	public void setPerchase_count(int perchase_count) {
		this.perchase_count = perchase_count;
	}
	
	@Override
	public String toString() {
		return "FundingBundleCountDTO [fund_seq=" + fund_seq + ", bundle_seq=" + bundle_seq + ", perchase_count="
				+ perchase_count + "]";
	}
	
	
	
}
