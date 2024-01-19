package project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import funding.dto.FundingDTO;
import project.dao.BundleDAO;
import project.dao.FundingBundleCountDAO;
import project.dto.BundleDTO;
import project.dto.FundingBundleCountDTO;

@Service
public class FundingBundleCountService {
	
	@Autowired
	private FundingBundleCountDAO countDao;

	//후원 상세 - 꾸러미 개수 
	public List<FundingBundleCountDTO> getCount(int fundseq) {
		return countDao.getCount(fundseq);
	}



}
