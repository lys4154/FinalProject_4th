package notification.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import notification.dao.NotificationDAO;

@Service
public class FollowerNotificationService {
	
	@Autowired
	NotificationDAO notificationDao;
	
	public void start(String shortTitle, Integer memberSeq, int projectSeq, String nickname) {
		String message = "팔로잉한 " + nickname + "님이 새 프로젝트 " + shortTitle +"의 펀딩을 시작했습니다. 지금 확인해보세요";
		notificationDao.insertNotification(projectSeq, memberSeq, message);
	}

}
