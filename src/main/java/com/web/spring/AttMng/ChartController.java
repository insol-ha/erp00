package com.web.spring.AttMng;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;



@Controller
public class ChartController {

	@Autowired(required = false)
	private ChartService service;
	
	
	// http://localhost:3030/charttt
	@RequestMapping("charttt")
	public String getChart() {
		return "WEB-INF\\final\\leaveMngt.jsp";
	}
	
	
	
	
	// http://localhost:3030/ChartListAjax
	@RequestMapping("ChartListAjax")
	public ResponseEntity<?> ChartListAjax(){
		return ResponseEntity.ok(service.getChartList());
	}
	
}
