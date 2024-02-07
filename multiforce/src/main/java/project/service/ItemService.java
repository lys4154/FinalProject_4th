package project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import project.dao.BundleDAO;
import project.dao.ItemDAO;
import project.dao.ProjectDAO;
import project.dto.BundleDTO;
import project.dto.ItemDTO;

@Service
public class ItemService {
	
	@Autowired
	private ItemDAO itemDao;
	
	@Autowired
	private BundleDAO bundleDao;
	
	@Autowired
	private ProjectDAO projectDao;
	
	//후원 상세 - 아이템
	public List<ItemDTO> getItem(List<Integer> bundleList) {
		return itemDao.getItem(bundleList);
	}

	public void createItem(ItemDTO item, HttpSession session) {
		int member_seq = projectDao.getMember_seq((String)session.getAttribute("login_user_id"));
		int project_seq = bundleDao.getProject_seq(member_seq);

		item.setProject_seq(member_seq); 
		item.getProject_seq();
		System.out.println(item.getProject_seq());

		itemDao.insertItem(item);
    }

}
