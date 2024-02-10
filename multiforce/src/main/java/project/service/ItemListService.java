package project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import project.dao.BundleDAO;
import project.dao.ItemListDAO;
import project.dao.ProjectDAO;
import project.dto.ItemDTO;
import project.dto.ItemListDTO;

@Service
public class ItemListService {
	@Autowired
	private ItemListDAO itemListDao;
	
	@Autowired
	private ProjectDAO projectDao;
	
	@Autowired
	private BundleDAO bundleDao;
	
	public void createItemList(ItemListDTO itemList, HttpSession session) {
		int member_seq = projectDao.getMember_seq((String)session.getAttribute("login_user_id"));
		int project_seq = bundleDao.getProject_seq(member_seq);
		int bundle_seq = itemListDao.getBundle_seq(project_seq);
		int item_seq = itemListDao.getItem_seq(project_seq);
		itemList.setBundle_seq(member_seq); 
		itemList.getBundle_seq();
		itemList.getItem_seq();
		itemList.setItem_seq(item_seq);
		System.out.println(itemList.getBundle_seq());
		System.out.println(itemList.getItem_seq());
		itemListDao.insertItemList(itemList);
    }
}
