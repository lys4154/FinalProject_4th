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
	public int noticesCount(String category);
	public List<NoticeDTO> selectPagingNotices(String category, int noticesStart, int numberPerPage);
	public NoticeDTO selectNotice(int seq);
	public NoticeDTO selectNoticewithDTO(NoticeDTO dto);
}
