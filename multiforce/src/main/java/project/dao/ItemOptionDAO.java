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

}
