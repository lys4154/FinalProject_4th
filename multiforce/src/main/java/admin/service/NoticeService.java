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
	private int numberPerPage = 10;
	
	public NoticeDTO enrollNotice(NoticeDTO dto) {
		if(dto.getCategory().equals("event")){
			dao.insertEvent(dto);
		}else {
			dao.insertNotice(dto);
		}
		
		return dao.selectNoticewithDTO(dto);
	}

	public HashMap<String, Object> selectPagingNotices(String category, int page, String query) {	
		List<NoticeDTO> list = null;
		Integer totalPage = 0;
		if(query == null ||query.equals("")) {
			int noticesCount = dao.noticesCount(category);
			int noticesStart = (page - 1) * numberPerPage;
			totalPage = noticesCount % numberPerPage == 0 ? noticesCount / numberPerPage 
					: noticesCount / numberPerPage + 1;
			
			list = dao.selectPagingNotices(category, noticesStart, numberPerPage);
		}else {
			int noticesCount = dao.noticesCountWithQuery(category, query);
			int noticesStart = (page - 1) * numberPerPage;
			totalPage = noticesCount % numberPerPage == 0 ? noticesCount / numberPerPage 
					: noticesCount / numberPerPage + 1;
			list = dao.selectPagingNoticesWithQuery(category, noticesStart, numberPerPage, query);
		}
		HashMap<String, Object> resultMap = new HashMap<>();
		resultMap.put("list", list);
		resultMap.put("totalPage", totalPage);
		return resultMap;
	}

	public NoticeDTO selectNotice(int seq) {
		return dao.selectNotice(seq);
	}

	public NoticeDTO modifyNotice(NoticeDTO dto) {
		int result = 0;
		if(dto.getCategory().equals("event")) {
			result = dao.updateEvent(dto);
		}else {
			result = dao.updateNotice(dto);
		}
		return dao.selectNotice(dto.getNotice_seq());
		
	}

	public int deleteNotice(int notice_seq) {
		return dao.updateDelStatus(notice_seq);
	}

}
