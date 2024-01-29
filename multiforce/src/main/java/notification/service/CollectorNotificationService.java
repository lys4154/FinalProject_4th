package notification.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import notification.dao.NotificationDAO;
import project.dto.ProjectDTO;
import project.dto.ProjectMemberDTO;

@Service
public class CollectorNotificationService {
	//찜한 프로젝트에 변동 사항이 있을 때 ex)프로젝트 시작, 프로젝트 업데이트 게시판 새 게시물, 마감임박
	//결제한 프로젝트에 변동 사항 있을 때 ex)프로젝트 업데이트 게시판 새 게시물, 실패or성공, 배송준비,
	//프로젝트 올린 경우 반려,허가 및 예정, 시작, 실패or성공, 성공 시 일주일 뒤 실제 모금이 얼마나 됐는지,
	//팔로우한 사람이 새 프로젝트 올린 경우
	@Autowired
	NotificationDAO notificationDao;
	public void reject(String shortTitle, int memberSeq, int projectSeq) {
		
	}
	
	public void approve(String shortTitle, int memberSeq, int projectSeq) {
		
	}
	
	public void start(String shortTitle, int memberSeq, int projectSeq) {
		
	}
	
	public void fail(String shortTitle, int memberSeq, int projectSeq) {
		String message = "회원님의 프로젝트" + shortTitle + "(이)가 펀딩 실패하였습니다.";
		notificationDao.insertNotification(projectSeq, memberSeq, message);

	}
	
	public void success(String shortTitle, int memberSeq, int projectSeq) {
		
	}
	
	
}
