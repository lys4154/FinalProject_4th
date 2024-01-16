package funding.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import funding.dao.FundingDAO;
import funding.dto.FundingDTO;
import member.dao.MemberDAO;
import member.dto.MemberDTO;
import project.dto.ProjectDTO;

@Service
public class FundingService {
	
	@Autowired
	private FundingDAO fundingDao;

	//마이페이지 - 후원한 프로젝트
	public List<FundingDTO> getFundedProject(int memberSeq) {
		return fundingDao.getFundedProject(memberSeq);
	}

	//후원한 프로젝트 페이지 - 진행중 후원
	public List<FundingDTO> ongoingFunded(int memberSeq) {
		return fundingDao.ongoingFunded(memberSeq);
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





}
