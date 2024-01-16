package admin.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import admin.dto.NoticeDTO;

@Repository
@Mapper
public interface NoticeDAO {
	
	public int insertNotice(NoticeDTO dto);
	public int insertEvent(NoticeDTO dto);
	public NoticeDTO selectNotice(int notice_seq);
	public NoticeDTO selectNoticewithDTO(NoticeDTO dto);
	public int updateNotice(NoticeDTO dto);
	public int updateEvent(NoticeDTO dto);
	public int updateDelStatus(int notice_seq);
	public int noticesCount(String category);
	public int noticesCountWithQuery(String category, String query);
	public List<NoticeDTO> selectPagingNotices(String category, int noticesStart, int numberPerPage);
	public List<NoticeDTO> selectPagingNoticesWithQuery(String category, int noticesStart, int numberPerPage,
			String query);
	public List<NoticeDTO> selectPagingEvent(String category, int noticesStart, int numberPerPage);
	public List<NoticeDTO> selectPagingEventWithQuery(String category, int noticesStart, int numberPerPage,
			String query);
	
	
}
