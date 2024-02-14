package funding.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import funding.dto.FundingDTO;
import project.dto.FundingBundleCountDTO;

@Repository
@Mapper
public interface FundingDAO {

	//마이페이지 - 후원한 프로젝트
	List<FundingDTO> getFundedProject(int memberSeq);
	
	//후원한 프로젝트 - 진행중 후원 + 프로젝트정보
	List<FundingDTO> getFunded(int memberSeq);

	//후원한 프로젝트 - 성공한 후원
	List<FundingDTO> successFunded(int memberSeq);

	//후원한 프로젝트 - 취소한 후원
	List<FundingDTO> cancelFunded(int memberSeq);

	//후원한 프로젝트 페이지 -> 후원 내역 상세
	FundingDTO getFundedDetail(int fundseq);

	//후원 취소
	void delStatusChange(int fundSeq);

	FundingDTO getPaymentInfo(int fundseq);

	int insertFunding(FundingDTO dto);

	Integer findFundingSeq(int project_seq, int member_seq);

	int insertFundingBundleCount(FundingBundleCountDTO countDto);

	int findCountSeq(int fundSeq, int bundleSeq);

	void insertChosenOption(int countSeq, int optionSeq);


}
