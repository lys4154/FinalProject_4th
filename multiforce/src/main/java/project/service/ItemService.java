package project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.dao.ItemDAO;
import project.dto.ItemDTO;

@Service
public class ItemService {
	
	@Autowired
	private ItemDAO itemdao;

}
