package project.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import project.dao.BundleDAO;
import project.dao.ProjectDAO;
import project.dto.BundleDTO;
import project.dto.ItemDTO;
import project.dto.ItemListDTO;
import project.dto.ItemOptionDTO;
import project.dto.ProjectDTO;

@Service
public class BundleService {
	
	@Autowired
	private BundleDAO bundleDao;
	
	@Autowired
	private ProjectDAO projectDao;
	
	@Autowired
	private ItemDTO itemDto;

	//후원 상세 - 번들
	public List<BundleDTO> getBundle(List<Integer> bundleList) {
		return bundleDao.getBundle(bundleList);
	}
	
	//프로젝트 상세페이지 번들
	public List<BundleDTO> getBundleList(int project_seq) {
		List<Integer> bundleSeqList = bundleDao.getBundleWithPseq(project_seq);
		List<BundleDTO> bundleList = bundleDao.getBundleList(bundleSeqList);
		return bundleList;
	}

	 //번들 생성
	public void createBundle(BundleDTO bundle, HttpSession session) {
		int member_seq = projectDao.getMember_seq((String)session.getAttribute("login_user_id"));
		int project_seq = bundleDao.getProject_seq(member_seq);
		bundle.setProject_seq(project_seq);
		bundle.getProject_seq();
		System.out.println(bundle.getProject_seq());
        bundleDao.insertBundle(bundle);
    }


}