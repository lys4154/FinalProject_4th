package project.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import member.dto.MemberDTO;
import member.service.MailService;
import notification.service.CollectorNotificationService;
import notification.service.DibsNotificationService;
import notification.service.FollowerNotificationService;
import notification.service.SupporterNotificationService;
import project.dao.ProjectDAO;
import project.dto.ProjectMemberDTO;

@Service
public class ScheduledService {
	@Autowired
	ProjectDAO projectDao;
	@Autowired
	MailService mailService;
	@Autowired
	DibsNotificationService dibsService;
	@Autowired
	CollectorNotificationService collectorService;
	@Autowired
	SupporterNotificationService supporterService;
	@Autowired
	FollowerNotificationService followerService;
	
	@Scheduled(cron = "0 0 0 * * *")
	public void processUpdate() {
		//1. 프로젝트 실패 업데이트
		//due_date 오늘날짜 + 진행중인 프로젝트(4) + goalprice > collection_amout ->실패로 변경
		int failResult = projectDao.projectFailUpdate();
		
		//2. 프로젝트 성공 업데이트
		//due_date 오늘날짜 + 진행중인 프로젝트(4) + goalprice <= collection_amout ->성공으로 변경
		int successResult = projectDao.projectSuccessUpdate();
		
		//3. 프로젝트 시작 업데이트
		//start_date 오늘날짜 + 예정 프로젝트(3) 시작으로 변경
		int startResult = projectDao.projectStartUpdate();
		
		System.out.println("failResult: " + failResult);
		System.out.println("successResult: " + successResult);
		System.out.println("startResult: " + startResult);
		//4. 마감 임박 알림(찜한 사람)
		List<ProjectMemberDTO> endDibsList = projectDao.selectDidsFundEnd();

		for (ProjectMemberDTO dto : endDibsList) {
			dibsService.end(dto.getShort_title(), dto.getMember_seq(), dto.getProject_seq());
		}

		//1-1. 실패 알림 + 메일(후원자, 모금자)
		List<ProjectMemberDTO> failCollectorList = projectDao.selectCollectorFundFail();

		for (ProjectMemberDTO dto : failCollectorList) {
//				1)실패 알림
//				(모금자)
			collectorService.fail(dto.getShort_title(), dto.getMember_seq(), dto.getProject_seq());
			List<ProjectMemberDTO> failSupporterList = projectDao.selectSupporterFundFail(dto.getProject_seq());
			for (ProjectMemberDTO supDto: failSupporterList) {
//					(후원자)				
				supporterService.fail(dto.getShort_title(), supDto.getMember_seq(), dto.getProject_seq());
			}
		}

		//	2)실패 메일
		//	(모금자)
//			List<ProjectMemberDTO> sendFailList = new ArrayList<>();
//			for (ProjectMemberDTO dto : failCollectorList) {
//				String result = mailService.sendToCollectorFundFailMail(dto);
//				if(result.equals("전송 오류")){
//					sendFailList.add(dto);
//				}
//			}
		//	(후원자)
			
		//2-1. 성공 알림 + 메일(후원자, 모금자)
		List<ProjectMemberDTO> successCollectorList = projectDao.selectCollectorFundSuccess();
		for (ProjectMemberDTO dto : successCollectorList) {
//			1)성공 알림
//			(모금자)
			collectorService.success(dto.getShort_title(), dto.getMember_seq(), dto.getProject_seq());
			List<ProjectMemberDTO> successSupporterList = projectDao.selectSupporterFundFail(dto.getProject_seq());
			for (ProjectMemberDTO supDto: successSupporterList) {
//				(후원자)				
				supporterService.success(dto.getShort_title(), supDto.getMember_seq(), dto.getProject_seq());
			}
		}
		//모금자: 프로젝트명 + 목표액 + 예상 모금액 + 실제 모금액이 언제쯤 입금될것인가
		//후원자: 프로젝트명 + 후원 금액 얼마가 결제될 예정 + 결제수단 + 결제요청 기간
		
		//3-1. 시작 알림(찜한 사람, 모금자, 모금자 팔로워)
		List<ProjectMemberDTO> startCollectorList = projectDao.selectCollectorFundstart();
		for (ProjectMemberDTO dto : startCollectorList) {
//			1)시작 알림
//			(모금자)
			collectorService.start(dto.getShort_title(), dto.getMember_seq(), dto.getProject_seq());
			List<Integer> startDibsList = projectDao.selectDibsFundStart(dto.getProject_seq());
			for (int i = 0; i < startDibsList.size(); i++) {
//				(찜한 사람)				
				dibsService.start(dto.getShort_title(), startDibsList.get(i), dto.getProject_seq());
			}
			List<Integer> startFollowerList = projectDao.selectFollowerFundStart(dto.getMember_seq());
			for (int i = 0; i < startFollowerList.size(); i++) {
//				(팔로우한 사람)
				followerService.start(dto.getShort_title(), startFollowerList.get(i), dto.getProject_seq(), dto.getNickname());
			}
		}
		
		
		
		
		
		
		
	
			
/*		List<ProjectMemberDTO> failsupporterList = projectDao.selectCollectorFundFail();
		for (ProjectMemberDTO dto : failsupporterList) {
			String result
		}
*/		
	
	}
	
	@Scheduled(cron = "0 7 0 * * *")
	public void executePayment() {
		System.out.println("check");
		List<ProjectMemberDTO> startCollectorList = projectDao.selectCollectorFundstart();
		for (ProjectMemberDTO dto : startCollectorList) {

			List<Integer> startFollowerList = projectDao.selectFollowerFundStart(dto.getMember_seq());
			for (int i = 0; i < startFollowerList.size(); i++) {
//				(팔로우한 사람)
				followerService.start(dto.getShort_title(), startFollowerList.get(i), dto.getProject_seq(), dto.getNickname());
			}
		}
	}
	
}
