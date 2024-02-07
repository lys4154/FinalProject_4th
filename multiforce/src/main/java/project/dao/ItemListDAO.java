package project.dao;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import project.dto.ItemListDTO;

@Repository
@Mapper
public interface ItemListDAO {
	
	//bundle_seq불러오기
	Integer getBundle_seq(int project_seq);
	
	//project_Seq불러오기
	Integer getProject_seq(int member_seq);
	
	//item_seq불러오기
	Integer getItem_seq(int project_seq);
	
	//item_List입력
	void insertItemList(ItemListDTO itemList);
	
}
