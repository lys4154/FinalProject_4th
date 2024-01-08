package funding.dao;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import funding.dto.FundingDTO;
import jakarta.annotation.ManagedBean;
import member.dto.MemberDTO;
import project.dto.ProjectDTO;

@Repository
@Mapper
public interface FundingDAO {

	//마이페이지 - 후원한 프로젝트
	List<FundingDTO> getFundedProject(int memberSeq);

	//후원한 프로젝트 - 진행중 후원
	List<FundingDTO> ongoingFunded(int memberSeq);

	//후원한 프로젝트 - 성공한 후원
	List<FundingDTO> successFunded(int memberSeq);

	//후원한 프로젝트 - 취소한 후원
	List<FundingDTO> cancelFunded(int memberSeq);

}
