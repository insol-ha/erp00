package com.web.spring.erpHR;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.web.spring.erpHR.vo.Erpemp;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class LoginController {
	@Autowired(required=false)
	private LoginService service;
	// http://localhost:1111/prjLogin
	// http://192.168.0.106:1111/prjLogin
	@GetMapping("prjLogin")
	public String login() {
		//return "WEB-INF/erp/emp/login.jsp";
		return "WEB-INF\\erp\\att\\login2.jsp";
	}
	@GetMapping("main")
	public String main() {
		return "WEB-INF\\views\\main.jsp";
		
	}
	
	@RequestMapping("prjLogin")
	public String login(Erpemp login, Model d, HttpServletRequest request) {
		//String page= "WEB-INF/erp/emp/login.jsp";
		String page= "WEB-INF\\erp\\att\\login2.jsp";
		if(login.getEmpno()!=0) {
			Erpemp emp = service.login(login);
			if(emp==null) {
				d.addAttribute("msg","로그인실패");
			}else {
				HttpSession session = request.getSession();
				session.setAttribute("sesEmp", emp);
				d.addAttribute("msg","로그인성공");
				page = "WEB-INF/erp/emp/alertPage.jsp";
			}
		}
		return page;
	}
	
	@GetMapping("logout")
	public String logout(HttpServletRequest request,  HttpServletResponse response) {
		HttpSession session= request.getSession();
		session.removeAttribute("sesEmp");
		return "redirect:/prjLogin";
	}
	// http://localhost:3030/erpProfile
	@GetMapping("erpProfile")
	public String erpProfile(@RequestParam("empno") int empno, Model d) {
		d.addAttribute("emp", service.getErpEmp(empno));
		d.addAttribute("job",service.getJobList());
		d.addAttribute("depart",service.getDepartList());
		d.addAttribute("emphistory",service.getEmphistory(empno));
		d.addAttribute("detail", service.getEmpdetail(empno));
		return "WEB-INF/erp/emp/profile.jsp";
	}
	// http://localhost:3030/erpEmpList
	@GetMapping("erpEmpList")
	public String erpEmpList() {
		return "WEB-INF/erp/emp/empList.jsp";
	}
	
	// http://localhost:3030/erpProfileList
	@GetMapping("erpProfileList")
	public String erpProfileList(Model d) {
		return "WEB-INF/erp/emp/profileList.jsp";
	}
	
	// http://localhost:3030/ajaxErpEmpList
	@RequestMapping("ajaxErpEmpList")
	public ResponseEntity<?> ajaxErpEmpList(Erpemp sch){
		return ResponseEntity.ok(service.getEmpList(sch));
	}
	
	@RequestMapping("ajaxErpEmp")
	public ResponseEntity<?> ajaxErpEmp(@RequestParam("empno") int empno){
		return ResponseEntity.ok(service.getErpEmp(empno));
	}
	
	@RequestMapping("ajaxDepart")
	public ResponseEntity<?> ajaxDepart(){
		return ResponseEntity.ok(service.getDepartList());
	}
	
	@RequestMapping("ajaxJob")
	public ResponseEntity<?> ajaxJob(){
		return ResponseEntity.ok(service.getJobList());
	}
	
	@RequestMapping(value = "ajaxErpEmpInsert", method = RequestMethod.POST)
	public ResponseEntity<?> ajaxErpEmpInsert(@RequestBody Erpemp ins) {
	    System.out.println(">>> [DEBUG] empno 값: " + ins.getEmpno());
	    System.out.println(">>> [DEBUG] hired 값: " + ins.getHired());

	    return ResponseEntity.ok(service.insertErpEmp(ins));
	}

	
	@RequestMapping(value = "ajaxErpEmpUpdate", method = RequestMethod.PUT)
	public ResponseEntity<?> ajaxErpEmpUpdate(@RequestBody Erpemp upt){
		System.out.println(">>> [DEBUG] empno 값: " + upt.getEmpno());

		return ResponseEntity.ok(service.updateErpEmp(upt));
	}
	@RequestMapping("ajaxErpEmpDelete")
	public ResponseEntity<?> ajaxErpEmpDelete(@RequestParam("empno") int empno, Model d){
		return ResponseEntity.ok(service.deleteErpEmp(empno));
	}
	
	@GetMapping("jobList")
	public String jobList(Model d) {
		d.addAttribute("jList",service.getJobListReverse());
		return "WEB-INF/erp/emp/jobList.jsp";
	}
	
	@PostMapping("pngUpload")
	public String pngUploadPost(@RequestParam("file") MultipartFile mf,
			@RequestParam("customFileName") String customFileName, Model d) {
		d.addAttribute("msg", service.pngUpload(mf,customFileName));
		return "WEB-INF\\a02_mvc\\a01_fileUpload.jsp";
	}
	
	@RequestMapping("ajaxEmpno")
	public ResponseEntity<?> ajaxEmpno(){
		return ResponseEntity.ok(service.getEmpnoList());
	}
	
}
