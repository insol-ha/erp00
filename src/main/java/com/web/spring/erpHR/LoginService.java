package com.web.spring.erpHR;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.web.spring.erpHR.vo.Depart;
import com.web.spring.erpHR.vo.Empdetail;
import com.web.spring.erpHR.vo.Emphistory;
import com.web.spring.erpHR.vo.Erpemp;
import com.web.spring.erpHR.vo.Job;

import jakarta.mail.Message.RecipientType;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import net.nurigo.sdk.message.service.DefaultMessageService;


@Service
public class LoginService {
	@Autowired(required=false)
	private LoginDao dao;
	
	@Autowired(required=false)
	private JavaMailSender sender;
	

	private static final Logger logger = LoggerFactory.getLogger(LoginService.class);
    final DefaultMessageService messageService;
    public LoginService(){
        this.messageService = NurigoApp.INSTANCE.initialize("NCSPUCPDXEMS4ULR",
        		"TA2D24EER42VVM4P3Z4BPDIDKYPEAXL7", "https://api.coolsms.co.kr");
        // 문자 보내는 api 고유키와 그 비밀번호
    }
    
	public Erpemp login(Erpemp login) {
		return dao.login(login);
	}
	
	public Erpemp getErpEmp(int empno) {
		return dao.getErpEmp(empno);
	}
	public List<Erpemp> getEmpList(Erpemp sch){
		if(sch.getEname()==null) sch.setEname("");
		sch.setEname("%"+sch.getEname()+"%");
		if(sch.getDname()==null) sch.setDname("");
		sch.setDname("%"+sch.getDname()+"%");
		return dao.getEmpList(sch);
	}
	
	public List<Depart> getDepartList(){
		return dao.getDepartList();
	}
	public List<Job> getJobList(){
		return dao.getJobList();
	}
	
	public ArrayList<Job> getJobListReverse(){
		ArrayList<Job> list = dao.getJobList();
		Collections.reverse(list);
		return list;
	}
	
	public String insertErpEmp(Erpemp ins) {
		Random rand = new Random();
		StringBuilder sb = new StringBuilder(8);
		String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789~!@#$%^&*_-+=`|\\(){}[]:;\"'<>,.?/";
		for (int i = 0; i < 8; i++) {
			sb.append(chars.charAt(rand.nextInt(chars.length()))); // 랜덤 숫자로 a부터 z까지를 한글자씩 삽입
		}
		String str = sb.toString(); // 랜덤 8글자 단어 제작 과정
		ins.setPwd(str); // 랜덤 글자 단어를 삽입
		int erp = dao.insertErpEmp(ins); // 사원등록
		int history = dao.insertEmpHistory(new Erpemp(ins.getEmpno(),
				ins.getJobid(),ins.getHired(),ins.getDeptno())); // 인사이력 등록
		String msg = ""; // 데이터 입력 성공여부 알림 문자열
		MimeMessage mmsg = sender.createMimeMessage(); // 메일 발송 데이터 전송을 위한 객체 생성
		String mailMsg = ""; // 메일 발송 성공여부 알림 문자열
		if(erp>0 && history>0) {
			msg="\n사원 입력 성공\n사원 이력 입력 성공";
			try { // 사원+이력 입력 성공시 이메일 발송
				mmsg.setSubject(ins.getEname()+"님 입사를 축하드립니다."); // 제목으로 입사환영
				mmsg.setRecipient(RecipientType.TO,new InternetAddress(ins.getEmail())); //등록한 이메일로 수신
				mmsg.setText(ins.getEname()+"님의 임시 비밀번호를 전송해드립니다.\n사원번호:"+
						ins.getEmpno()+"\n임시비밀번호:"+ins.getPwd()); // 내용에 사원번호와 사원 임시번호 발송
				sender.send(mmsg);
				mailMsg = "메일 발송 성공"; // 메일 발송 성공시 알림
			} catch (MessagingException e) { // 메일 발송 실패시
				mailMsg = "메일 발송 에러 발생:"+e.getMessage();
			} catch( Exception e) {
				mailMsg = "기타 에러 발생:"+e.getMessage();
			}
			if(mailMsg=="메일 발송 성공") { // 메일 전송 성공시
				Message message = new Message();
		        message.setFrom("01041808094"); // 문자 보내는 번호 (임의 개발자 번호)
		        message.setTo(ins.getPnum()); // 문자 받는 번호
		        message.setText(ins.getEname()+"님 입사를 축하드립니다. "
		        		+ "자세한 내용은 이메일을 확인 부탁드립니다."); // 문자 내용
		        SingleMessageSentResponse response = this.messageService.sendOne(new SingleMessageSendingRequest(message));
				System.out.println(response);
			}
		}else if(erp>0&&history<1) {
			msg="\n사원 입력 성공\n사원 이력 입력 실패";
		}else if(erp<1&&history>0) {
			msg="\n사원 입력 실패\n사원 이력 입력 성공";
		}else {
			msg = "\n사원,이력 입력 실패";
		}
	    return mailMsg+msg;
	}
	
	public String updateErpEmp(Erpemp upt) {
		return dao.updateErpEmp(upt)>0?"수정성공":"수정실패";
	}
	
	public String deleteErpEmp(int empno) {
		int history = dao.deleteEmpHistory(empno);
		int erp = dao.deleteErpEmp(empno);
		String msg = "";
		if(history>0 && erp>0) {
			msg="사원 삭제 성공\n사원 이력 삭제 성공";
		}else if(history>0&&erp<1) {
			msg="사원 삭제 실패\n사원 이력 삭제 성공";
		}else if(history<1&&erp>0) {
			msg="사원 삭제 성공\n사원 이력 삭제 실패";
		}else {
			msg = "사원,이력 삭제 실패";
		}
		return msg;
	}
	
	public List<Emphistory> getEmphistory(int empno){
		return dao.getEmphistory(empno);
	}
	
	public Empdetail getEmpdetail(int empno) {
		return dao.getEmpdetail(empno);
	}
	
	private String path;
	
	public String pngUpload(MultipartFile mfs, String customFileName) {
		String msg = "업로드 성공";
		path = "C:/javaexp01/sts/workspace/erp00_svn/src/main/resources/static/upload";
		File upFile = new File(path,customFileName);
		try {
			mfs.transferTo(upFile); // 물리적 파일이 생성..(필수예외 처리)
		} catch (IllegalStateException e) {
			msg = e.getMessage();
		} catch (IOException e) {
			msg = "[파일업로드예외]"+e.getMessage();
		} catch( Exception e) {
			msg = "[기타예외]"+e.getMessage();
		}
		return msg;
	}
	
	private static final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
	
	@Scheduled(cron = "0 6 10 * * *")
	public void executeTask() {
        System.out.println("Scheduled Task 실행 시간: " + LocalDateTime.now().format(formatter));
        System.out.println("Scheduled Task 실행 시간: " + LocalDateTime.now().format(formatter));
        System.out.println("Scheduled Task 실행 시간: " + LocalDateTime.now().format(formatter));
        System.out.println("Scheduled Task 실행 시간: " + LocalDateTime.now().format(formatter));
        System.out.println("Scheduled Task 실행 시간: " + LocalDateTime.now().format(formatter));
        System.out.println("Scheduled Task 실행 시간: " + LocalDateTime.now().format(formatter));
    }
	
	public List<Integer> getEmpnoList(){
		return dao.getEmpnoList();
	}
	
	
	
	
	
	
	
	
	
	
	
	
}
