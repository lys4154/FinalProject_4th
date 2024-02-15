package notification.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import notification.dao.NotificationDAO;
import project.dto.ProjectDTO;
import project.dto.ProjectMemberDTO;

@Service
public class SupporterNotificationService {
	@Autowired
	NotificationDAO notificationDao;
	//찜한 프로젝트에 변동 사항이 있을 때 ex)프로젝트 시작, 마감임박 , 프로젝트 업데이트 게시판 새 게시물
	//내가 가능한것) 시작, 마감임박
	//팀원들과 협력) 업데이트
	
	//결제한 프로젝트에 변동 사항 있을 때 ex)실패or성공, 배송준비, 프로젝트 업데이트 게시판 새 게시물
	//내가 가능한것) 실패or성공
	//팀원들과 협력) 업데이트, 배송준비, 업데이트 게시판 새 게시물
	
	//프로젝트 올린 경우 반려,허가 및 예정, 시작, 실패or성공, 성공 시 일주일 뒤 실제 모금이 얼마나 됐는지,
	//내가 가능한것) 시작, 실패or성공, 성공 시 일주일 뒤 실제 모금이 얼마나 됐는지
	//팀원들과 협력) 업데이트, 반려, 허가 및 예정, 
	
	//팔로우한 사람이 새 프로젝트 올린 경우
	//내가 가능한것) 새 프로젝트 올린 경우
	//팀원들과 협력)
	public void update(String shortTitle, int memberSeq, int projectSeq) {
		String message = "후원하신 프로젝트 " + shortTitle + "에 새소식이 있습니다.";
		notificationDao.insertNotification(projectSeq, memberSeq, message);
	}
	
	public void fail(String shortTitle, int memberSeq, int projectSeq) {
		String message = "후원하신 프로젝트 " + shortTitle + "(이)가 목표 달성에 실패하였습니다.";
		notificationDao.insertNotification(projectSeq, memberSeq, message);
	}

	public void success(String shortTitle, int memberSeq, int projectSeq) {
		String message1 = "후원하신 프로젝트 " + shortTitle + "(이)가 목표 달성했습니다.";
		notificationDao.insertNotification(projectSeq, memberSeq, message1);
		String message2 = "후원하신 프로젝트 " + shortTitle + "(의) 결제가 이루어질 예정입니다. 결제수단을 확인해주세요.";
		notificationDao.insertNotification(projectSeq, memberSeq, message2);
	}

	public void payment(String short_title, int member_seq, int project_seq) {
		String message1 = "프로젝트 " + short_title + "의 후원을 위한 결제가 완료되었습니다";
		notificationDao.insertNotification(project_seq, member_seq, message1);
		
	}

	public void paymentFailed(String short_title, int member_seq, int project_seq) {
		String message1 = "프로젝트 " + short_title + "의 후원을 위해 결제수단을 확인해주세요";
		notificationDao.insertNotification(project_seq, member_seq, message1);
	}
	
}
