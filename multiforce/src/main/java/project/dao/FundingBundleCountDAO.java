package project.dao;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import funding.dto.FundingDTO;
import project.dto.BundleDTO;
import project.dto.FundingBundleCountDTO;
import project.dto.ProjectDTO;

@Repository
@Mapper
public interface FundingBundleCountDAO {

	//후원 상세 - 꾸러미 개수 
	List<FundingBundleCountDTO> getCount(int fundseq);

	// 번들 작성
	void insertBundle(BundleDTO bundle);
		
	//member_seq불러오기
	int getProject_seq(String long_title);
	


}


