package notification.service;

import org.springframework.stereotype.Service;

import project.dto.ProjectDTO;

@Service
public class DibsNotificationService {
	//찜한 프로젝트에 변동 사항이 있을 때 ex)프로젝트 시작, 프로젝트 업데이트 게시판 새 게시물, 마감임박
	//결제한 프로젝트에 변동 사항 있을 때 ex)프로젝트 업데이트 게시판 새 게시물, 실패or성공, 배송준비,
	//프로젝트 올린 경우 반려,허가 및 예정, 시작, 실패or성공, 성공 시 일주일 뒤 실제 모금이 얼마나 됐는지,
	//팔로우한 사람이 새 프로젝트 올린 경우
	
	
	//찜한 프로젝트 시작
	//찜한 사람 + 시작시 알림 메서드(int project_seq)
	//찜목록에 where 프로젝트_seq 해서 member_seq목록 뽑아냄
	//미리 정해놓은 메세지에 project_seq 통해 정보 끌어오고 프로젝트 이름 끌어와서 메세지와 함께 테이블 저장
	public void notificateStart(ProjectDTO dto) {
		//dao select member_seq from project_dibs where project_seq = #{project_seq}
		//dao select * from project where project_seq = 으로 프로젝트 정보 들고온 후 메세지에 넣어주기
		String message = "찜한 프로젝트 ????가 마침내 펀딩 오픈했습니다. 놓치지 말고 확인해보세요!";
		//member_seq list 결과값 반복문 
	}
	
	public void notificateUpdate(ProjectDTO dto) {
		//dao select member_seq from project_dibs where project_seq = #{project_seq}
		//dao select * from project where project_seq = 으로 프로젝트 정보 들고온 후 메세지에 넣어주기
		String message = "찜한 프로젝트 ????가 새로운 업데이트 정보를 올렸습니다. 놓치지 말고 확인해보세요!";
		//member_seq list 결과값 반복문
	}
	
	
}
