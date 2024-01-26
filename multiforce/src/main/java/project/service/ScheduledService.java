package project.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import member.dto.MemberDTO;
import member.service.MailService;
import project.dao.ProjectDAO;
import project.dto.ProjectMemberDTO;

@Service
public class ScheduledService {
	@Autowired
	ProjectDAO projectDao;
	@Autowired
	MailService mailService;
	
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
		
		//4. 마감 임박 알림
		
		
		System.out.println("failResult: " + failResult);
		System.out.println("successResult: " + successResult);
		System.out.println("startResult: " + startResult);
		
		//1-1. 실패 알림 + 메일(후원자, 모금자)
		//	1)실패 메일
		//	due_date 오늘날짜 + 실패(5) 목록 들고와서 join member_seq email 들고오기 => 메일 착착착
		//	(모금자)
		List<ProjectMemberDTO> sendFailList = new ArrayList<>();
		List<ProjectMemberDTO> failList = projectDao.selectCollectorFundFail();
		for (ProjectMemberDTO dto : failList) {
			String result = mailService.sendToCollectorFundFailMail(dto);
			if(result.equals("전송 오류")){
				sendFailList.add(dto);
			}
		}
		//	(후원자)
		//	2)실패 알림
		//	(모금자)
		//	(후원자)
		
		//2-1. 성공 알림 + 메일(후원자, 모금자)
		//모금자: 프로젝트명 + 목표액 + 예상 모금액 + 실제 모금액이 언제쯤 입금될것인가
		//후원자: 프로젝트명 + 후원 금액 얼마가 결제될 예정 + 결제수단 + 결제요청 기간
		
		//3-1. 시작 알림(찜한 사람, 모금자, 모금자 팔로워)
		//
		
		
		
		
		
		
		
	
			
/*		List<ProjectMemberDTO> failsupporterList = projectDao.selectCollectorFundFail();
		for (ProjectMemberDTO dto : failsupporterList) {
			String result
		}
*/		
	
	}
	
	@Scheduled(cron = "0 0 12 * * *")
	public void executePayment() {
		//성공 프로젝트 결제 시도
	}
	
}
