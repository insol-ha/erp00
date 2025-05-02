package com.web.spring.salesmangement;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


import com.web.spring.salesmangement.vo.Sales;

@Controller
public class SalesController {
	@Autowired(required=false)
	private SalesService service;
	
	//초기화면 로딩
 	// http://localhost:2222/getSalesList
	@GetMapping("getSalesList")
	public String getSalesList(){
		return "WEB-INF\\erp\\performance\\sales.jsp";
	}
	//리스트
	// http://localhost:2222/ajaxgetSalesList
	@GetMapping("ajaxgetSalesList")
	public ResponseEntity<?> ajaxgetSalesList(){
		return ResponseEntity.ok(service.getSalesList());
	}	
	//검색
	// http://localhost:2222/getSales
	@RequestMapping("getSales")
	public ResponseEntity<?> getSales(Sales sch){
	//	System.out.println("검색조건:"+sch.getPname());
		return ResponseEntity.ok(service.getSales(sch));
	}
	// http://localhost:2222/insertSales
	@PostMapping("insertSales")
	public ResponseEntity<?> insertSales (@RequestBody Sales ins,Model d){
		return ResponseEntity.ok(service.insertSales2(ins));
	}
	
	// http://localhost:2222/salesVue?no=2
	@GetMapping("salesVue")
	public ResponseEntity<?> salesVue(@RequestParam("no") int no, 
						 Model d) {
		return ResponseEntity.ok(service.getSales1(no));
	}	

	
	// http://localhost:2222/updateSales
	@PutMapping("updateSales")
	public ResponseEntity<?> updateSales(@RequestBody Sales upt, Model d){
		return ResponseEntity.ok(service.updateSale(upt));
	} 
	
	// http://localhost:2222/deleteSale
	@DeleteMapping("deleteSale")
	public ResponseEntity<?> deleteSale(@RequestParam("no") int no, Model d){
		return ResponseEntity.ok(service.deleteSale(no));
	}
}
