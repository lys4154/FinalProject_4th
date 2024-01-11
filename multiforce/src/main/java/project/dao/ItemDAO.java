package project.dao;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;
import project.dto.ItemDTO;


@Repository
@Mapper
public interface ItemDAO {
	
	//후원 상세 - 아이템
	List<ItemDTO> getItem(List<Integer> bundleList);

	

}
