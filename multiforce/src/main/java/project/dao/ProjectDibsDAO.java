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

	//	//관심 프로젝트 - 취소
	int dibsCancel(int projectSeq, int memberSeq);
	//찜 추가
	int insertProjectDibs(int member_seq, int project_seq);

	int selectdibs(int member_seq, int project_seq);

	
}
