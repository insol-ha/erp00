package com.web.spring.AttMng;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class LeaveMngtController {

	@Autowired(required = false)
	private LeaveMngtService service;
	
	// http://localhost:1111/LeaveMngt
	@GetMapping("LeaveMngt")
	public String getAttList() {
		return "WEB-INF\\erp\\att\\leaveMngt2.jsp";
	} // 연차 개수 초기화 페이지 화면 호출
	
		
	// http://localhost:3030/leaveAjax
	@RequestMapping("leaveAjax")
	public ResponseEntity<?> leaveAjax(){
		return ResponseEntity.ok(service.getAttList());
	}
		
	// http://localhost:3030/uptUsedptoAjax
	@RequestMapping("uptUsedptoAjax")
	public ResponseEntity<?> uptUsedptoAjax(){
		return ResponseEntity.ok(service.uptUsedpto());
	}
		
		
	
		
		
		
		
}
