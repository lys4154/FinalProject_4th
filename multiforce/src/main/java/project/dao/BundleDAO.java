package project.dao;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;
import project.dto.BundleDTO;
import project.dto.ItemListDTO;

@Repository
@Mapper
public interface BundleDAO {

	//후원 상세 - 번들
	List<BundleDTO> getBundle(List<Integer> bundleList);

	void insertBundle(BundleDTO bundle);
	
	//member_seq불러오기
	Integer getProject_seq(int member_seq);
	
	//project_seq로 번들 찾기
	List<Integer> getBundleWithPseq(int project_seq);
	//bundle_seq list로 일치하는 번들 + 아이템 + 옵션 한꺼번에
	List<BundleDTO> getBundleList(List<Integer> bundleSeqList);

	
}
