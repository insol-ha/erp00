package com.web.spring.erpHR;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.spring.erpHR.vo.Depart;
import com.web.spring.erpHR.vo.Emphistory;

@Controller
public class HrController {
	@Autowired(required=false)
	private HrService service;
	
	@GetMapping("erpDepartList")
	public String erpDepartList() {
		return "WEB-INF/erp/emp/deptList.jsp";
	}
	
	@GetMapping("empHistory")
	public String empHistory() {
		return "WEB-INF/erp/emp/empHistory.jsp";
	}
	
	@RequestMapping("ajaxDepartList")
	public ResponseEntity<?> ajaxDepartList(Depart sch){
		return ResponseEntity.ok(service.getDepartList(sch));
	}
	@RequestMapping(value = "ajaxinsertDepart", method = RequestMethod.POST)
	public ResponseEntity<?> ajaxinsertDepart(@RequestBody Depart ins){
		return ResponseEntity.ok(service.insertDepart(ins));
	}
	@RequestMapping(value = "ajaxupdateDepart", method = RequestMethod.PUT)
	public ResponseEntity<?> ajaxupdateDepart(@RequestBody Depart upt){
		return ResponseEntity.ok(service.updateDepart(upt));
	}
	@RequestMapping("ajaxdeleteDepart")
	public ResponseEntity<?> ajaxdeleteDepart(int deptno){
		return ResponseEntity.ok(service.deleteDepart(deptno));
	}
	// http://localhost:3030/ajaxGetDepart?deptno=10
	@RequestMapping("ajaxGetDepart")
	public ResponseEntity<?> ajaxGetDepart(int deptno){
		return ResponseEntity.ok(service.getDepart(deptno));
	}
	// http://localhost:3030/ajaxHistoryList
	@RequestMapping("ajaxHistoryList")
	public ResponseEntity<?> ajaxHistoryList(Emphistory sch){
		return ResponseEntity.ok(service.getHistoryList(sch));
	}
	
	
	
	// http://localhost:3030/vueEmpHistory?empno=1000&startdateStr=2024-12-31
	@RequestMapping("vueEmpHistory")
	public ResponseEntity<?> vueEmpHistory(@RequestParam("empno") int empno, @RequestParam("startdateStr") String startdateStr){
		return ResponseEntity.ok(service.getEmphistory(empno,startdateStr));
	}
	
	@RequestMapping(value = "insertEmpHistory", method = RequestMethod.POST)
	public ResponseEntity<?> insertEmpHistory(@RequestBody Emphistory ins){
		return ResponseEntity.ok(service.insertEmpHistory(ins));
	}
	@RequestMapping(value = "updateEmpHistory", method = RequestMethod.PUT)
	public ResponseEntity<?> updateEmpHistory(@RequestBody Emphistory upt){
		return ResponseEntity.ok(service.updateEmpHistory(upt));
	}
	// http://localhost:3030/deleteEmpHistory?empno=1000&startdateStr=2024-02-18
	@RequestMapping("deleteEmpHistory")
	public ResponseEntity<?> deleteEmpHistory(@Param("empno") int empno, @Param("startdateStr") String startdateStr){
		return ResponseEntity.ok(service.deleteEmpHistory(empno,startdateStr));
	}
	
	
}
