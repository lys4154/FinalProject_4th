package funding.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import funding.dao.FundingDAO;
import funding.dto.FundingDTO;


@Service
public class FundingService {
	
	@Autowired
	private FundingDAO fundingDao;

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
		return 0;
	}


}
