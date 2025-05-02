package com.web.spring.AttMng;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.spring.Final.vo.Att;
import com.web.spring.Final.vo.Cal;




@Controller

public class CalController {

	@Autowired(required = false)
	private CalService service;
	
	// http://localhost:1111/Cal4
	@GetMapping("Cal4")
	public String getCal2() {
		 return "WEB-INF\\final\\cal_side1.jsp";
		 // (x)
	}
	
	// http://localhost:1111/Cal5
	@GetMapping("Cal5")
	public String getCal3() {
		//return "WEB-INF\\erp\\att\\cal_side.jsp";
		return "WEB-INF\\erp\\att\\cal_side2.jsp";
		 // (o)
	}
		
	// http://localhost:1111/calAjax
	@RequestMapping("calAjax")
	public ResponseEntity<?> calAjax(){
		return ResponseEntity.ok(service.getCalList());
	}
	
	// http://localhost:1111/enamecalAjax
	@RequestMapping("enamecalAjax")
	public ResponseEntity<?> enamecalAjax2(@RequestParam("ename") 
	String ename){
		return ResponseEntity.ok(service.enameCalList2(ename));
	}
	
	@RequestMapping("contentcalAjax")
	public ResponseEntity<?> contentList(@RequestParam("ename") 
	String ename){
		return ResponseEntity.ok(service.contentList(ename));
	}
	
	// http://localhost:1111/insertCalAjax
	@RequestMapping("insertCalAjax")
	public ResponseEntity<?> insertCalAjax(Cal ins){
		return ResponseEntity.ok(service.insertCal(ins));
	}	
	
	
	// http://localhost:1111/updateCalAjax?id=2
	@RequestMapping("updateCalAjax")
	public ResponseEntity<?> updateCalrAjax(Cal upt){
		return ResponseEntity.ok(service.updateCal(upt));
	}

	// http://localhost:1111/deleteCalAjax
	@RequestMapping("deleteCalAjax")
	public ResponseEntity<?> deleteCalAjax(Cal del){
		return ResponseEntity.ok(service.deleteCal(del));
	}
	
	
	// http://localhost:1111/uptStartAjax
	@RequestMapping("uptStartAjax")
	public ResponseEntity<?> uptStartAjax(Cal insS){
		return ResponseEntity.ok(service.insStart(insS));
	} // 출근 찍을시 시작 시간 변경
	
	
	// http://localhost:1111/uptEndAjax
	@RequestMapping("uptEndAjax")
	public ResponseEntity<?> uptEndAjax(Cal uptE){
		return ResponseEntity.ok(service.uptEnd(uptE));
	} // 퇴근 찍을시 종료 시간 변경
		
	// http://localhost:1111/uptUsedAjax?ename=ALLEN
	@RequestMapping("uptUsedAjax")
	public ResponseEntity<?> uptUsedAjax(Att upt){
		
		return ResponseEntity.ok(service.uptUsed(upt));
	} // 연차 개수 갱신

	// http://localhost:1111/insHourAjax
	@RequestMapping("insHourAjax")
	public ResponseEntity<?> insHourAjax(Cal insH){
		return ResponseEntity.ok(service.insHour1(insH));
	}
	
	// http://localhost:1111/uptUsedHAjax
	@RequestMapping("uptUsedHAjax")
	public ResponseEntity<?> uptUsedHAjax(Att uptU1){
		return ResponseEntity.ok(service.uptUsedH(uptU1));
	} // 시차 1개 등록시 연차개수 -0.125
	
	// http://localhost:1111/inswfhAjax
	@RequestMapping("inswfhAjax")
	public ResponseEntity<?> inswfhAjax(Cal insW){
		return ResponseEntity.ok(service.inswfh(insW));
	}	
	
	// http://localhost:1111/uptUsedWAjax
	@RequestMapping("uptUsedWAjax")
	public ResponseEntity<?> uptUsedWAjax(Att uptW){
		return ResponseEntity.ok(service.uptUsedW(uptW));
	} // 재택 1개 등록시 재택 개수 - 1
	
	
	
}
