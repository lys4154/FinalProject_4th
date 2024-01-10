package project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import project.dao.BundleDAO;
import project.dto.BundleDTO;

@Service
public class BundleService {
	
	@Autowired
	private BundleDAO bundleDao;

	public BundleDTO getBundle(int projectSeq) {
		return bundleDao.getBundle(projectSeq);
	}


	//후원 상세 - 꾸러미 

	

}
