package member.service;

import jakarta.mail.internet.MimeMessage;

public interface MailService {
	String sendEmail(String mail);
}
