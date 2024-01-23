package project.service;

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
		
		//due_date 오늘날짜 + 실패(5) 목록 들고와서 join member_seq email 들고오기 => 메일 착착착
		List<ProjectMemberDTO> failList = projectDao.selectCollectorFundFail();
		for (ProjectMemberDTO dto : failList) {
			String result = mailService.sendToCollectorFundFailMail(dto);
		}
/*		List<ProjectMemberDTO> failsupporterList = projectDao.selectCollectorFundFail();
		for (ProjectMemberDTO dto : failsupporterList) {
			String result
		}
*/		
		
		
	}
	
	
	
}
