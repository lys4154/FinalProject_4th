package notification.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import notification.dto.NotificationDTO;
import notification.service.NotificationService;
import project.service.ScheduledService;

@Controller
public class NotificationController {
	@Autowired
	NotificationService notiService;
	@Autowired
	ScheduledService s;
	
	//알림 헤더로 불러오는 ajax
	@PostMapping(value="/notificationlist", produces = {"application/json;charset=utf-8"})
	@ResponseBody
	public List<NotificationDTO> notificationList(String member_seq){
		List<NotificationDTO> list = notiService.getAllNotification(Integer.parseInt(member_seq));
		return list;
	}
	//알림 삭제
	@PostMapping(value="/deletenotification", produces = {"application/json;charset=utf-8"})
	@ResponseBody
	public String deleteNotification(String notification_seq){
		int result = notiService.deleteNotification(Integer.parseInt(notification_seq));
		return"{\"result\":\"" + result +"\"}";
	}
	//알림 읽음 처리
	@PostMapping(value="/readnotification", produces = {"application/json;charset=utf-8"})
	@ResponseBody
	public String readNotification(int last_notification_seq, int member_seq){
		int result = notiService.readNotification(last_notification_seq, member_seq);
		return"{\"result\":\"" + result +"\"}";
	}
	@GetMapping("/s")
	public String s() {
		s.processUpdate();
		return "commom/mainpage";
	}
	
	
	
}
