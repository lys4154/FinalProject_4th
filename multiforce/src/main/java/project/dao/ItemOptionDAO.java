package project.dao;


import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import project.dto.ItemOptionDTO;



@Repository
@Mapper
public interface ItemOptionDAO {

	//후원 상세 - 아이템의 옵션
	List<ItemOptionDTO> getItemOption(List<Integer> itemList);

	//bundle_seq불러오기
	Integer getBundle_seq(int project_seq);
	
	//project_seq불러오기
	Integer getProject_seq(int member_seq);
	
	//item_seq 불러오기
	Integer getItem_seq(int bundle_seq);
	
	void insertItem_option(ItemOptionDTO option);
}
