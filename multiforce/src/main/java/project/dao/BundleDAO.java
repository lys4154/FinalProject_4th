package project.dao;


import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;
import project.dto.BundleDTO;

@Repository
@Mapper
public interface BundleDAO {

	//후원 상세 - 꾸러미
	BundleDTO getBundle(int projectSeq);


	
}
