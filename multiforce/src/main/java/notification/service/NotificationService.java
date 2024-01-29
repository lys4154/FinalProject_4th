package notification.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import notification.dao.NotificationDAO;
import notification.dto.NotificationDTO;

@Service
public class NotificationService {
	@Autowired
	NotificationDAO notiDao;
	
	public List<NotificationDTO> getAllNotification(int member_seq) {
		List<NotificationDTO> list = notiDao.selectAllNotification(member_seq);
		return list;
	}

	public int deleteNotification(int notification_seq) {
		int result = notiDao.deleteNotification(notification_seq);
		return result;
	}

	public int readNotification(int last_notification_seq, int member_seq) {
		int result = notiDao.updateIsRead(last_notification_seq, member_seq);
		return result;
	}

}
