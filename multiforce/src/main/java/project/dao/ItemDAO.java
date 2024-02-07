package project.dao;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import project.dto.BundleDTO;
import project.dto.ItemDTO;


@Repository
@Mapper
public interface ItemDAO {
	
	//후원 상세 - 아이템
	List<ItemDTO> getItem(List<Integer> bundleList);

	// 아이템 작성
	void insertItem(ItemDTO item);
	
	//project_seq불러오기
	Integer getProject_seq(int member_seq);

}
