package com.web.spring.board;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.web.spring.board.VO.Mail;



@Controller
public class MailController {

	@Autowired(required = false)
	private MailService service;
	
	// http://localhost:1111/sendMail
	@RequestMapping("sendMail")
	public String sendMail() {
		return "mail\\mailForm3.html";
	}
	// \mail\mailForm2.html
	
	// http://locahost:1111/sendMail
	@PostMapping("sendMail")
	public ResponseEntity<String> ajaxSendMail(Mail mail){
		return ResponseEntity.ok(service.sendMail(mail));
	}

	
}
