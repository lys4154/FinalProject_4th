package project.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import project.dao.BundleDAO;
import project.dao.ItemDAO;
import project.dao.ItemListDAO;
import project.dao.ItemOptionDAO;
import project.dao.ProjectDAO;
import project.dto.BundleDTO;
import project.dto.FundingBundleCountDTO;
import project.dto.ItemDTO;
import project.dto.ItemOptionDTO;

@Service
public class ItemOptionService {
	
	@Autowired
	private ItemOptionDAO optionDao;
	
	@Autowired
	private ItemListDAO itemListDao;
	
	@Autowired
	private ProjectDAO projectDao;
	
	@Autowired
	private BundleDAO bundleDao;
	
	//후원 상세 - 아이템의 옵션
	public List<ItemOptionDTO> getItemOption(List<Integer> itemList) {
		return optionDao.getItemOption(itemList);
	}
	
	public void createItemOption(List<ItemOptionDTO> optionList, HttpSession session) {
		int member_seq = projectDao.getMember_seq((String)session.getAttribute("login_user_id"));
		int project_seq = bundleDao.getProject_seq(member_seq);
//		int bundle_seq = itemListDao.getBundle_seq(project_seq);
		int item_seq = itemListDao.getItem_seq(project_seq);
		item_seq = item_seq+1;
		
		for(ItemOptionDTO optionDTO : optionList) {
		optionDTO.getItem_seq();
		optionDTO.setItem_seq(item_seq);
		System.out.println(optionDTO.getItem_seq());
		optionDao.insertItemOption(optionDTO);
		}
	}
	
	public void defaultItemOption(ItemOptionDTO itemOption, HttpSession session) {
		int member_seq = projectDao.getMember_seq((String)session.getAttribute("login_user_id"));
		int project_seq = bundleDao.getProject_seq(member_seq);
//		int bundle_seq = itemListDao.getBundle_seq(project_seq);
		int item_seq = itemListDao.getItem_seq(project_seq);
		itemOption.getItem_seq();
		itemOption.setItem_seq(item_seq);
		System.out.println(itemOption.getItem_seq());
		optionDao.defaultOption(itemOption);
	}


}
