package notification.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import notification.dto.NotificationDTO;

@Repository
@Mapper
public interface NotificationDAO {

	int insertNotification(int project_seq, int member_seq, String message);

	List<NotificationDTO> selectAllNotification(int member_seq);

	int deleteNotification(int notification_seq);

	int updateIsRead(int last_notification_seq, int member_seq);

}
