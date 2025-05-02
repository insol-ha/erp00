package com.web.spring.performance;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.web.spring.performance.vo.Eachperfor;
import com.web.spring.performance.vo.Perform;

@Controller
public class Pcontroller {
	@Autowired(required = false)
	private Pservice service;

	// http://localhost:2222/ajaxPerformList
	@RequestMapping("ajaxPerformList")
	public ResponseEntity<?> ajaxPerformList() {
		return ResponseEntity.ok(service.getPerform());
	}

	// http://localhost:1111/PerformList
	@RequestMapping("PerformList")
	public String PerformList() {
		return "WEB-INF\\erp\\performance\\store.jsp";
	}

	// http://localhost:2222/ajaxEachPerfor
	@RequestMapping("ajaxEachPerfor")
	public ResponseEntity<?> ajaxEachPerfor(Eachperfor sch,Model d) {
		return ResponseEntity.ok(service.geteachperfor(sch));
	}
	

	// http://localhost:2222/EachPerfor
	@RequestMapping("EachPerfor")
	public String EachPerfor() {
		return "WEB-INF\\erp\\performance\\eachperson.jsp";
	}
}
