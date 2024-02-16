package project.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import project.dto.BundleDTO;
import project.dto.ItemDTO;
import project.service.ItemService;

@Controller
public class ProjectDesignController {
	
	@Autowired
	ItemService itemService;
	
	@PostMapping("/saveitems")
	@ResponseBody
	public List<ItemDTO> saveItems(@RequestBody List<ItemDTO> items) {
		System.out.println(items.get(0));
		List<ItemDTO> list = itemService.insertItems(items);
		return list;
	}
	
	@PostMapping("/savebundles")
	@ResponseBody
	public List<BundleDTO> saveBundles(@RequestBody List<BundleDTO> bundles) {
		System.out.println(bundles.get(0));
		List<BundleDTO> list = itemService.insertBundles(bundles);
		return list;
	}
}
