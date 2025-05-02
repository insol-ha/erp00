package com.web.spring.board;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.web.spring.board.VO.Mail;

import jakarta.mail.Message.RecipientType;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

@Service   
public class MailService {
	
	// 컨테이너에 있는 메일 발송객체 로딩
		@Autowired(required=false)
		private JavaMailSender sender;
		// 메일 발송 메서드
		public String sendMail(Mail email) {
		    String msg = "";
		    // 1. 메일 발송 데이터 전송을 위한 객체 생성
		    MimeMessage mmsg = sender.createMimeMessage();
		    try {
		        // 1) 제목
		        mmsg.setSubject(email.getTitle());
		        // 2) 수신자
		        mmsg.setRecipient(RecipientType.TO, new InternetAddress(email.getReceiver()));
		        // 3) 발신자 (고정 발신자 설정)
		        mmsg.setFrom(new InternetAddress("coffeehouse@example.com"));  // Set fixed sender here
		        // 4) 내용
		        mmsg.setText(email.getContent());
		        // 5) 발송처리
		        sender.send(mmsg);
		        msg = "메일 발송 성공";
		    } catch (MessagingException e) {
		        msg = "메일 발송 에러 발생:" + e.getMessage();
		        System.out.println(e.getMessage());
		    } catch (Exception e) {
		        msg = "기타 에러 발생:" + e.getMessage();
		        System.out.println(e.getMessage());
		    }
		    return msg;
		}

		
}
