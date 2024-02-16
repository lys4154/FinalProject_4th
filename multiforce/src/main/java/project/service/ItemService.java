package project.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import project.dao.BundleDAO;
import project.dao.ItemDAO;
import project.dao.ItemListDAO;
import project.dao.ItemOptionDAO;
import project.dao.ProjectDAO;
import project.dto.BundleDTO;
import project.dto.ItemDTO;
import project.dto.ItemListDTO;
import project.dto.ItemOptionDTO;

@Service
public class ItemService {
	
	@Autowired
	private ItemDAO itemDao;
	
	@Autowired
	private BundleDAO bundleDao;
	
	@Autowired
	private ProjectDAO projectDao;
	
	@Autowired
	private ItemOptionDAO optionDao;
	
	@Autowired
	private ItemListDAO listDao;
	
	//후원 상세 - 아이템
	public List<ItemDTO> getItem(List<Integer> bundleList) {
		return itemDao.getItem(bundleList);
	}

	public void createItem(ItemDTO item, HttpSession session) {
		int member_seq = projectDao.getMember_seq((String)session.getAttribute("login_user_id"));
		int project_seq = bundleDao.getProject_seq(member_seq);
		System.out.println("member_seq=" + member_seq + ", project_seq=" + project_seq );
		
		item.setProject_seq(project_seq); 
		item.getProject_seq();
		System.out.println("===>"+item.getProject_seq());
		
		itemDao.insertItem(item);
    }

	public List<ItemDTO> insertItems(List<ItemDTO> items) {
		for (ItemDTO dto : items) {
			int res = itemDao.insertItemReturnSeq(dto);
			for (ItemOptionDTO option : dto.getOptionDTOList()) {
				option.setItem_seq(dto.getItem_seq());
				optionDao.insertOptionReturnSeq(option);
			}
		}
		System.out.println(items);
		return items;
	}
	
	public List<ItemDTO> getItemName(HttpSession session) {
		int member_seq = projectDao.getMember_seq((String)session.getAttribute("login_user_id"));
		int project_seq = itemDao.getProject_seq(member_seq);
		List<ItemDTO> item_seq = itemDao.getItem_seq(project_seq);
		System.out.println("projectSeq = " + project_seq);
		System.out.println("ItemSeq = " + item_seq);
		return itemDao.getItem_name(project_seq);
	}

	public List<BundleDTO> insertBundles(List<BundleDTO> bundles) {
		for (BundleDTO dto : bundles) {
			bundleDao.insertBundleReturnSeq(dto);
			for (ItemListDTO ldto : dto.getItemListDTOList()) {
				ldto.setBundle_seq(dto.getBundle_seq());
				listDao.insertItemListReturnSeq(ldto);
			}
		}
		System.out.println(bundles);
		return bundles;
	}

}
