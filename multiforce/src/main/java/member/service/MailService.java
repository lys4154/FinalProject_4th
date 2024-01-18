package member.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Service;

import jakarta.mail.internet.MimeMessage;
import member.dao.MemberDAO;
import member.dto.MemberDTO;

@Service
public class MailService{
	
	@Autowired
	private JavaMailSender mailSender;
	@Autowired
	private MemberDAO memberDao;
	private String authCode = "";
	
	public String sendAuthEmail(String email) {
		String subject = "[MultiForce Funding] 회원가입을 위한 이메일 인증";
		String contents = createMailAuthContents();
		MimeMessage message = createMail(email, subject, contents);
		mailSender.send(message);
		return authCode;
	}
	
	public String sendIdEmail(String email) {
		MemberDTO result = memberDao.loginMember(email);
		if(result != null) {
			String subject = "[MultiForce Funding] 아이디 찾기 안내";
			String contents = createFindIdMailContents(email, result.getMember_id());
			MimeMessage message = createMail(email, subject, contents);
			try {
				mailSender.send(message);
			}catch (MailException e) {
				return "메일 전송 오류";
			}
			return "전송 완료";
		}else {
			return "결과 없음";
		}
		
	}
	
	public String sendTempPwEmail(String email, String id) {
		MemberDTO result = memberDao.selectMemberByIdEmail(email, id);
		if(result != null) {
			String tempPw = createTempPw();
			String subject = "[MultiForce Funding] 비밀번호 재설정 안내";
			String contents = createResetPwMailContents(email, id, tempPw);
			MimeMessage message = createMail(email, subject, contents);
			int resetResult = memberDao.updateMemberPw(email, id, tempPw);
			if(resetResult == 1) {
				try {
					mailSender.send(message);
				}catch (MailException e) {
					//이 경우 rollback 시키는 것 필요
					return "메일 전송 오류";
				}
				return "전송 완료";
			}else {
				return "임시 비밀번호 설정 오류";
			}
		}else {
			return "결과 없음";
		}
	}
	
	private MimeMessage createMail(String mail, String subject, String contents) {
		
		MimeMessage message = mailSender.createMimeMessage();
        try {
            message.setRecipients(MimeMessage.RecipientType.TO, mail); //보낼 이메일 설정
            message.setSubject(subject);// 제목 설정
            message.setText(contents,"UTF-8", "html");// 내용 설정
        } catch (Exception e) {
            e.printStackTrace();
        }
        return message;
	}
	
	private String createMailAuthContents() {
		
		this.authCode = createAuthNumber();
		String body = "";
		body += "<h1>" + "안녕하세요." + "</h1>";
		body += "<h1>" + "MultiForce Funding 입니다." + "</h1>";
		body += "<h3>" + "회원가입을 위한 요청하신 인증 번호입니다." + "</h3><br>";
		body += "<h2>" + "아래 코드를 회원가입 창으로 돌아가 입력해주세요." + "</h2>";
		body += "<div align='center' style='border:1px solid black; font-family:verdana;'>";
		body += "<h2>" + "회원가입 인증 코드입니다." + "</h2>";
		body += "<h1 style='color:blue'>" + authCode + "</h1>";
		body += "</div>";
		body += "<h3>" + "감사합니다." + "</h3>";
		
		return body;
	}
	
	private String createFindIdMailContents(String email, String member_id) {
		String body = "";
		body += "<h1>" + "안녕하세요." + "</h1>";
		body += "<h1>" + "MultiForce Funding 입니다." + "</h1>";
		body += "<div align='center' style='border:1px solid black; font-family:verdana;'>";
		body += "<h2>" + "회원님의 아이디는" + "</h2>";
		body += "<h1 style='color:blue'>" + member_id + "</h1>";
		body += "<h2>" + "입니다" + "</h2>" + "</div>";
		body += "<h3>" + "감사합니다." + "</h3>";
		
		return body;
	}
	
	private String createResetPwMailContents(String email, String id, String tempPw) {
		String body = "";
		body += "<h1>" + "안녕하세요." + "</h1>";
		body += "<h1>" + "MultiForce Funding 입니다." + "</h1>";
		body += "<div align='center' style='border:1px solid black; font-family:verdana;'>";
		body += "<h2>" + id +" 회원님의 임시 비밀번호는" + "</h2>";
		body += "<h1 style='color:blue'>" + tempPw + "</h1>";
		body += "<h2>" + "입니다" + "</h2>";
		body += "<h2>" + "임시 비밀번호로 로그인 후 비밀번호를 다시 설정해주세요" + "</h2>" + "</div>";
		body += "<h3>" + "감사합니다." + "</h3>";
		
		return body;
	}
	
	private String createTempPw() {
		StringBuilder builder = new StringBuilder();
		ArrayList<Integer> charCodeArr = new ArrayList<>();
		int pwLength = (int)((Math.random() + 3) * 4);
		int zeroCode = 48;
		int zCode = 122;
		//숫자 : 0~9 아스키코드값 : 48~57
		//영문 a~z 대문자 아스키코드값 :  65~90
		//		  소문자 아스키코드값 :  97~122
		for (int i = zeroCode; i <= zCode; i++) {
			if(i > 57 && i < 65 || i > 90 && i < 97) {
				continue;
			}
			charCodeArr.add(i);
		}
		for(int i = 0; i < pwLength; i++) {
			int randomIdx = (int)((Math.random()) * (charCodeArr.size() - 1));
			builder.append((char)charCodeArr.get(randomIdx).intValue());
		}
		return builder.toString();
	}

	private String createAuthNumber() {
		StringBuilder builder = new StringBuilder();
		int codeLength = 6;
		for (int i = 0; i < codeLength; i++) {
			int randomNum = (int)(Math.random() * 10);
			builder.append(randomNum);
		}
		return builder.toString();
	}

	
	
	
}
