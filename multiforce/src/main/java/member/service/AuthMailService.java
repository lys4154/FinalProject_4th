package member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Service;

import jakarta.mail.internet.MimeMessage;

@Service
public class AuthMailService implements MailService{
	
	@Autowired
	private JavaMailSender mailSender;
	private String authCode = "";
	
	public String sendEmail(String mail) {
		
		MimeMessage message = createMail(mail);
		mailSender.send(message);
		return authCode;
	}
	
	private MimeMessage createMail(String mail) {
		
		MimeMessage message = mailSender.createMimeMessage();
        try {
        	String mailSubject = "[MultiForce Funding] 회원가입을 위한 이메일 인증";
            String body = createMailAuthContents();; //변수에 내용 저장
            message.setRecipients(MimeMessage.RecipientType.TO, mail); //보낼 이메일 설정
            message.setSubject(mailSubject);// 제목 설정
            message.setText(body,"UTF-8", "html");// 내용 설정
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
		body += "</div><br>";
		body += "<h3>" + "감사합니다." + "</h3>";
		
		return body;
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
