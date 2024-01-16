package project.dao;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;
import project.dto.BundleDTO;

@Repository
@Mapper
public interface ProjectDibsDAO {

	//관심 목록
	List<Integer> dibsList(int memberSeq);



	
}
