package admin.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import admin.dao.NoticeDAO;
import admin.dto.NoticeDTO;

@Service
public class NoticeService {

	@Autowired
	NoticeDAO dao;
	
	public NoticeDTO enrollNotice(NoticeDTO dto) {
		if(dto.getCategory().equals("event")){
			dao.insertEvent(dto);
		}else {
			dao.insertNotice(dto);
		}
		
		return dao.selectNoticewithDTO(dto);
	}

	public HashMap<String, Object> selectPagingNotices(String category, int page) {	
		int noticesCount = 0;
		int numberPerPage = 10;
		//페이지 당 10개
		if(category.equals("event")) {
			noticesCount = dao.noticesCount(category);
		}else {
			noticesCount = dao.noticesCount(category);
		}
		int noticesStart = (page - 1) * numberPerPage;
		Integer totalPage = noticesCount % numberPerPage == 0 ? noticesCount / numberPerPage 
				: noticesCount / numberPerPage + 1;
		HashMap<String, Object> resultMap = new HashMap<>();
		List<NoticeDTO> list = dao.selectPagingNotices(category, noticesStart, numberPerPage);
		resultMap.put("list", list);
		resultMap.put("totalPage", totalPage);
		
		return resultMap;
	}

	public NoticeDTO selectNotice(int seq) {
		return dao.selectNotice(seq);
	}
}
