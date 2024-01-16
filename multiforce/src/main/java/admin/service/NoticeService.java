package admin.service;

import java.sql.Timestamp;
import java.util.ArrayList;
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

	public HashMap<String, Object> selectPagingNotices(String category, int page) {	
		List<NoticeDTO> list = null;
		Integer totalPage = 0;
		int noticesCount = dao.noticesCount(category);
		int noticesStart = (page - 1) * numberPerPage;
		totalPage = noticesCount % numberPerPage == 0 ? noticesCount / numberPerPage 
				: noticesCount / numberPerPage + 1;
		if(category.equals("event")) {
			list = dao.selectPagingEvent(category, noticesStart, numberPerPage);
			list = sortEvent(list);
		}else {
			list = dao.selectPagingNotices(category, noticesStart, numberPerPage);
		}
		
		HashMap<String, Object> resultMap = new HashMap<>();
		resultMap.put("list", list);
		resultMap.put("totalPage", totalPage);
		return resultMap;
	}
	public HashMap<String, Object> selectPagingNoticesWithQuery(String category, int page, String query) {
		List<NoticeDTO> list = null;
		Integer totalPage = 0;
		int noticesCount = dao.noticesCountWithQuery(category, query);
		int noticesStart = (page - 1) * numberPerPage;
		totalPage = noticesCount % numberPerPage == 0 ? noticesCount / numberPerPage 
				: noticesCount / numberPerPage + 1;
		if(category.equals("event")) {
			list = dao.selectPagingEventWithQuery(category, noticesStart, numberPerPage, query);
			list = sortEvent(list);
		}else {
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
	
	private List<NoticeDTO> sortEvent(List<NoticeDTO> list){
		ArrayList<NoticeDTO> will = new ArrayList<>();
		ArrayList<NoticeDTO> ing = new ArrayList<>();
		ArrayList<NoticeDTO> ed = new ArrayList<>();
		for(NoticeDTO dto : list){
			if(dto.getCategory().equals("event")){
				Timestamp startDate = Timestamp.valueOf(dto.getEvent_start_date());
				Timestamp endDate = Timestamp.valueOf(dto.getEvent_end_date());
				Timestamp today = new Timestamp(System.currentTimeMillis());
				if(startDate.after(today)){
					//예정
					will.add(dto);
				}else if(startDate.before(today) && endDate.after(today)){
					//진행중
					ing.add(dto);
				}else{
					//종료
					ed.add(dto);
				}
			}
		}
		for(NoticeDTO dto : will) {
			ing.add(dto);
		}
		for(NoticeDTO dto : ed) {
			ing.add(dto);
		}
		return ing;
	}
}
