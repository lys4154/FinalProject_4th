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
		//where due_date = date(now());
		//due_date 오늘날짜 + 진행중인 프로젝트(4) + goalprice <= collection_amout ->성공으로 변경
		//due_date 오늘날짜 + 진행중인 프로젝트(4) + goalprice > collection_amout ->실패로 변경
		int failResult = projectDao.projectFailUpdate();
		int successResult = projectDao.projectSuccessUpdate();
		//start_date 오늘날짜 + 예정 프로젝트(3) 시작으로 변경
		int startResult = projectDao.projectStartUpdate();
		System.out.println("failResult: " + failResult);
		System.out.println("successResult: " + successResult);
		System.out.println("startResult: " + startResult);
		
		//due_date 오늘날짜 + 실패(5) 목록 들고와서 join member_seq email 들고오기 => 메일 착착착
		List<ProjectMemberDTO> sendFailList = new ArrayList<>();
		List<ProjectMemberDTO> failList = projectDao.selectCollectorFundFail();
		
			for (ProjectMemberDTO dto : failList) {
				String result = mailService.sendToCollectorFundFailMail(dto);
				if(result.equals("전송 오류")){
					sendFailList.add(dto);
				}
			}
			
/*		List<ProjectMemberDTO> failsupporterList = projectDao.selectCollectorFundFail();
		for (ProjectMemberDTO dto : failsupporterList) {
			String result
		}
*/		
		//<메일 또는 알람이 필요한 기능>
		//찜한 프로젝트에 변동 사항이 있을 때 ex)프로젝트 시작, 프로젝트 업데이트 게시판 새 게시물,
		//결제한 프로젝트에 변동 사항 있을 때 ex)프로젝트 업데이트 게시판 새 게시물, 실패or성공, 배송준비,
		//프로젝트 올린 경우 반려,허가 및 예정, 시작, 실패or성공, 성공 시 일주일 뒤 실제 모금이 얼마나 됐는지, 
		//1:1 대화 시 새 메세지
		//고객센터 문의 답글
		//팔로우한 사람이 새 프로젝트 올린 경우
		
		
	}
	
	@Scheduled(cron = "0 0 12 * * *")
	public void executePayment() {
		//성공 프로젝트 결제 시도
	}
	
}
