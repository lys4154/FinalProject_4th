package project.dao;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;
import project.dto.BundleDTO;
import project.dto.FundingBundleCountDTO;

@Repository
@Mapper
public interface FundingBundleCountDAO {

	//후원 상세 - 꾸러미 개수 
	List<FundingBundleCountDTO> getCount(int fundseq);


}


