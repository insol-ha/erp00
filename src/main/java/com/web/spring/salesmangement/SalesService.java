package com.web.spring.salesmangement;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.spring.salesmangement.vo.Sales;

@Service
public class SalesService {
	@Autowired(required=false)
	private SalesDao dao;
	
	public List<Sales> getSalesList(){
		return dao.getSalesList();
	}
	
	public List<Sales> getSales(Sales sch) {
		if(sch.getDname()==null) sch.setDname("");
		if(sch.getStart()==null) sch.setStart("");
		if(sch.getEnd()==null) sch.setEnd("");
		sch.setDname("%"+sch.getDname()+"%");
		sch.setStart(sch.getStart());
		sch.setEnd(sch.getEnd());
		return dao.getSalesList1(sch);
	}
	
	public String insertSales1(Sales ins) {
		return dao.insertSales1(ins)>0?"등록 성공":"등록실패";
	}
	
	public String insertSales2(Sales ins) {
		if(ins.getPname().equals("돌체 라떼")) ins.setPrice(5000);
		if(ins.getPname().equals("생딸기케이크")) ins.setPrice(6000);
		if(ins.getPname().equals("바스크 초코케이크")) ins.setPrice(7000);
		if(ins.getPname().equals("리저브 콜드브루")) ins.setPrice(6500);
		return dao.insertSales2(ins)>0?"등록성공":"등록실패";
	}
	
	public Sales getSales1( int no) {
		return dao.getSales1(no);
	}
	
	public String updateSale(Sales upt) {
		return dao.updateSale(upt)>0?"수정성공":"수정실패";
	}
	
	public String deleteSale(int no) {
		return dao.deleteSale(no)>0?"삭제성공":"삭제실패";
	}
}
