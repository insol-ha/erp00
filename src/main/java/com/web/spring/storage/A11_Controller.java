package com.web.spring.storage;



import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.spring.storage.vo.Product;
import com.web.spring.storage.vo.Product_delivery;
import com.web.spring.storage.vo.Product_order;




@Controller
public class A11_Controller {
	@Autowired(required=false)
	private A12_Service service;
	
	
	//구매리스트--------------------------------------------
	// http://localhost:1111/getOrderList
	@RequestMapping("getOrderList")
	public String getOrderList() {
		return "\\WEB-INF\\erp\\storage\\buylist.jsp";
	}

	
	// http://localhost:5050/getOrderListajax
	@RequestMapping("getOrderListajax")
	public ResponseEntity<?> getOrderListajax(){
		return ResponseEntity.ok(service.getProduct_orderList());
	}

	
	// http://localhost:5050/getOrderListbyPnameajax
	@RequestMapping("getOrderListbyPnameajax")
	public ResponseEntity<?> getOrderListbyPnameajax(Product_order sch){
		return ResponseEntity.ok(service.getProduct_orderListByPname(sch));
	}
	
	// http://localhost:5050/getOrderListbyorderno?orderno=1
	@GetMapping("getOrderListbyorderno")
	public ResponseEntity<?> getOrderListbyorderno(@RequestParam("orderno") int orderno){
		return ResponseEntity.ok(service.getProduct_orderListbyorderno(orderno));
	}	
 	// http://localhost:5050/ajaxOrderListins?empno=1999&p_name=당근&price=1800&email=dddd@gmail.com
	@RequestMapping("ajaxOrderListins")
	public ResponseEntity<?> ajaxOrderListins(Product_order ins, Model d){
		return ResponseEntity.ok(service.insProduct_orderList(ins));
	}
	
 	// http://localhost:5050/ajaxOrderListupt?orderno=3&p_name=밀가루&empno=1662&price=6000&email=aaa@naver.com&cnt=120
	@PostMapping("ajaxOrderListupt")
	public ResponseEntity<?> ajaxOrderListupt(@RequestBody Product_order upt){
		  System.out.println("📌 주문 수정 요청 데이터: " + upt); // 디버깅용 로그
		return ResponseEntity.ok(service.uptProduct_orderList(upt));
	}
	
	
	
	//입출고리스트----------------------------------------------------------------------------
	// http://localhost:1111/getSellList
	@RequestMapping("getSellList")
	public String getSellList() {
		return "\\WEB-INF\\erp\\storage\\inputlist.jsp";
	}
	
	// http://localhost:5050/getdelListajax
	@RequestMapping("getdelListajax")
	public ResponseEntity<?> getdelListajax(Product_delivery sch){			
	    return ResponseEntity.ok(service.getProduct_deliveryListbyPname(sch));
	}
	
	// http://localhost:5050/ajaxdelListins?p_name=딸기케이크&cnt=295&inputtype=입고
	@RequestMapping("ajaxdelListins")
	public ResponseEntity<?> ajaxdelListins(Product_delivery ins, Model d){
		return ResponseEntity.ok(service.insProduct_delList(ins));
	}
	
	
//	// http://localhost:5050/getdelListcntajax
//	@RequestMapping("getdelListcntajax")
//	public ResponseEntity<?> getdelListcntajax(Sch sch) {
//	    int count = service.getProduct_deliveryCount(sch);
//	    return ResponseEntity.ok(count);
//	}
	
//재고리스트------------------------------------------------------------------------------
	// http://localhost:1111/inventoryList
	@RequestMapping("inventoryList")
	public String inventoryList() {
		return "\\WEB-INF\\erp\\storage\\inventorylist.jsp";
	}
	// http://localhost:1111/getProductListajax?end=2
	@RequestMapping("getProductListajax")
	public ResponseEntity<?> getProductListajax(){			
	    return ResponseEntity.ok(service.getProductList());
	}
	// http://localhost:1111/ajaxpListins?&p_name=사과파이&price=6000&inventory=1600
	@RequestMapping("ajaxpListins")
	public ResponseEntity<?> ajaxpListins(Product ins, Model d){
		return ResponseEntity.ok(service.insProductList(ins));
	}
//	// http://localhost:1111/ckProductList?&p_name=초코라떼
//	@RequestMapping("ckProductList")
//	public ResponseEntity<?> ckProductList(@RequestParam("p_name") String p_name){
//		return ResponseEntity.ok(service.ckProductList(p_name));
//	}
	// http://localhost:1111/ckProductList?p_name=초코라떼
	@RequestMapping("ckProductList")
	public ResponseEntity<Map<String, Boolean>> ckProductList(@RequestParam("p_name") String p_name){
	    boolean exists = service.isProductExists(p_name); // boolean 반환하도록 변경
	    return ResponseEntity.ok(Map.of("exists", exists));
	}
	
	// http://localhost:1111/ckProductList?p_name=초코라떼
	// http://localhost:1111/getdelListbyp_name?p_name=카페모카
	@RequestMapping("getdelListbyp_name")
	public ResponseEntity<?> getdelListbyp_name(@RequestParam("p_name") String p_name){
		return ResponseEntity.ok(service.getProduct_deliveryListbyp_name1(p_name));
	}	
	
}
