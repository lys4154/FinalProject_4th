package project.dao;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;
import project.dto.BundleDTO;

@Repository
@Mapper
public interface BundleDAO {

	//후원 상세 - 번들
	List<BundleDTO> getBundle(List<Integer> bundleList);

	void insertBundle(BundleDTO bundle);
	
	//member_seq불러오기
	Integer getProject_seq(int member_seq);
	
}
