package project.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.dao.ItemDAO;
import project.dao.ItemOptionDAO;
import project.dto.BundleDTO;
import project.dto.FundingBundleCountDTO;
import project.dto.ItemDTO;
import project.dto.ItemOptionDTO;

@Service
public class ItemOptionService {
	
	@Autowired
	private ItemOptionDAO optionDao;
	
	//후원 상세 - 아이템의 옵션
	public List<ItemOptionDTO> getItemOption(List<Integer> itemList) {
		return optionDao.getItemOption(itemList);
	}
	
	


}
