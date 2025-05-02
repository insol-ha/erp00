package com.web.spring.AttMng;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
@CrossOrigin(origins = "*")
public class TaxController2 {
	
	@Autowired(required = false)
    private final TaxService2 taxService2;
    
    public TaxController2(TaxService2 taxService2) {
        this.taxService2 = taxService2;
    }

    // 근로소득세 계산 요청 (JSON 응답)
    @GetMapping("/calculateTax")
    public ResponseEntity<?> calculateTax(@RequestParam int salary, @RequestParam int dependents) {
        int tax = taxService2.calculateIncomeTax2(salary, dependents);
        return ResponseEntity.ok(tax >= 0 ? tax : "해당 급여 및 부양가족 수에 대한 세금 정보 없음");
    }
    // http://localhost:1111/calcul2
    @GetMapping("/calcul2")
    public String showTaxCalculatorPage(@RequestParam(value = "salary", 
    	required = false, defaultValue = "0") int salary, Model model) {
        model.addAttribute("salary", salary);
        
        return "WEB-INF\\erp\\att\\SalTax.jsp";  
    }
    
    
    // http://localhost:1111/SalAjax?ename=정기창
 	@RequestMapping("SalAjax")
 	public ResponseEntity<?> SalAjax(String ename){
 		return ResponseEntity.ok(taxService2.salList(ename));
 	}
    
    
    

    
}
