package com.web.spring.AttMng;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.spring.Final.vo.Cal;





@Controller
public class CSController {
	@Autowired(required = false)
	private CSService service;

	// http://localhost:1111/CalList
	@RequestMapping("CalList")
	public String CalList(Model d) {
		d.addAttribute("CalList",service.CalList());
		return "WEB-INF\\erp\\att\\leaveMngt3.jsp";
	}  // 출결 내역 확인 페이지 호출
	
	
	// http://localhost:1111/CalList2
//	@RequestMapping("CalList2")
//	public String CalList2(Cal sch,Model d) {
//		d.addAttribute("CalList2",service.CalList2(sch));
//		return "WEB-INF\\final\\leaveMngt3.jsp"; // (x)
//	}
		
	// http://localhost:1111/CalListAjax
	@RequestMapping("CalListAjax")
	public ResponseEntity<?> CalListAjax(){
		return ResponseEntity.ok(service.CalList());
	} // 전체 출결 내역 출력하는 json
		
	
	// http://localhost:1111/CalListAjax2?id=285
		@RequestMapping("CalListAjax2")
		public ResponseEntity<?> CalListAjax2(Cal sch){
			return ResponseEntity.ok(service.CalList2(sch));
		} 
	
		
	// http://localhost:1111/empnoListAjax?id=113
	@RequestMapping("empnoListAjax")
	public ResponseEntity<?> empnoListAjax(@RequestParam(value="id", 
			defaultValue="0") int id){
		return ResponseEntity.ok(service.empnoByList(id));
	}
	
	// 수정 ajax
	// http://localhost:1111/updatecAjax
	@RequestMapping("updatecAjax")
	public ResponseEntity<?> updatecAjax(Cal calupt){
		return ResponseEntity.ok(service.calUpdate(calupt));
	}
	
	// 삭제 ajax 삭제 성공
	// http://localhost:1111/deletecAjax
	@RequestMapping("deletecAjax")
	public ResponseEntity<?> deletecAjax(Cal del){
		return ResponseEntity.ok(service.calDelete(del));
	}
	
	
	
}
