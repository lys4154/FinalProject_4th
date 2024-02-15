package funding.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import funding.dao.FundingDAO;
import funding.dto.FundingDTO;
import project.dao.ProjectDAO;
import project.dto.FundingBundleCountDTO;


@Service
public class FundingService {
	
	@Autowired
	private FundingDAO fundingDao;
	@Autowired
	private FundingBundleCountDTO countDto;
	@Autowired
	private ProjectDAO projectDao;

	//마이페이지 - 후원한 프로젝트
	public List<FundingDTO> getFundedProject(int memberSeq) {
		return fundingDao.getFundedProject(memberSeq);
	}
	
	//후원한 프로젝트 페이지 - 진행중 후원 + 프로젝트정보
	public List<FundingDTO> getFunded(int memberSeq) {
		return fundingDao.getFunded(memberSeq);
	}

	//후원한 프로젝트 페이지 - 성공한 후원
	public List<FundingDTO> successFunded(int memberSeq) {
		return fundingDao.successFunded(memberSeq);
	}

	//후원한 프로젝트 페이지 - 취소한 후원
	public List<FundingDTO> cancelFunded(int memberSeq) {
		return fundingDao.cancelFunded(memberSeq);
	}

	//후원한 프로젝트 페이지 -> 후원 내역 상세
	public FundingDTO getFundedDetail(int fundseq) {
		return fundingDao.getFundedDetail(fundseq);
	}

	//후원 취소
	public void delStatusChange(int fundSeq) {
		fundingDao.delStatusChange(fundSeq);
	}

	//결제 페이지 정보 가져오기
	public FundingDTO getPaymentInfo(int fundseq){
		return fundingDao.getPaymentInfo(fundseq);
	}

	public int insertFunding(HashMap<String, Object> map) {
		//펀딩 먼저 넣기 => fundingseq 값 가져오기 => fundingseq 값 + bundleseq + count fundingbundlecount에 넣기
		//fundingbundlecount seq 값 가져오기 => 옵션seq 넣기
		FundingDTO dto = (FundingDTO)map.get("dto");
		List<Map<String,Object>> list = (List<Map<String,Object>>)map.get("list");
		int result = fundingDao.insertFunding(dto);
		int fundSeq = fundingDao.findFundingSeq(dto.getProject_seq(), dto.getMember_seq());
		for (Map<String, Object> lmap : list) {
			int bundleSeq = (int)lmap.get("seq");
			int perchaseCount = Integer.parseInt((String)lmap.get("count"));
			countDto.setFund_seq(fundSeq);
			countDto.setBundle_seq(bundleSeq);
			countDto.setPerchase_count(perchaseCount);
			int r = fundingDao.insertFundingBundleCount(countDto);
			int countSeq = fundingDao.findCountSeq(fundSeq, bundleSeq);
			for (Map<String, Object> imap : (List<Map<String, Object>>)lmap.get("item")) {
				int optionSeq = Integer.parseInt((String)imap.get("optionSeq"));
				fundingDao.insertChosenOption(countSeq, optionSeq);
			}
		}
		int projectSeq = dto.getProject_seq();
		int price = dto.getPrice();
		int pResult = projectDao.updateCollectionAmount(projectSeq, price);
		return fundSeq;
	}

	public int fundingCheck(int project_seq , int login_user_seq) {
		Integer result = fundingDao.findFundingSeq(project_seq, login_user_seq);
		if(result == null) {
			result = 0;
		}
		return result;
	}

	
	//후원 페이지 - 검색
	public List<FundingDTO> searchFunded(String keyword, int memberSeq) {
		return fundingDao.searchFunded(keyword, memberSeq);	
	}


}
