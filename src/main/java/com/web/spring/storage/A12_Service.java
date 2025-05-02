package com.web.spring.storage;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.spring.storage.vo.CudVo;
import com.web.spring.storage.vo.Product;
import com.web.spring.storage.vo.Product_delivery;
import com.web.spring.storage.vo.Product_order;
import com.web.spring.storage.vo.Sch;



@Service
public class A12_Service {
	@Autowired(required = false)

	private A13_Dao dao;

	
	public List<Product_order> getProduct_orderList(){
		return dao.getProduct_orderList();
	}

	
	public List<Product_delivery> getProduct_deliveryList(){
		return dao.getProduct_deliveryList();
	}
	public Product_order getProduct_orderListbyorderno(int orderno) {
		return dao.getProduct_orderListbyorderno(orderno);
	}
	public List<Product_order> getProduct_orderListByPname(Product_order sch){
		if(sch.getP_name()==null)sch.setP_name("");
		if(sch.getStartDate()==null)sch.setStartDate("");
		if(sch.getEndDate()==null)sch.setEndDate("");
		sch.setP_name("%"+sch.getP_name()+"%");
		sch.setStartDate(sch.getStartDate());
		sch.setEndDate(sch.getEndDate());
		return dao.getProduct_orderListbyPname(sch);
	}
	public CudVo insProduct_orderList(Product_order ins) {
		return new CudVo(dao.insProduct_orderList(ins)>0?"등록성공":"등록실패",dao.getProduct_orderList());
	}
	public CudVo uptProduct_orderList(Product_order upt) {
		return new CudVo(dao.uptProduct_orderList(upt)>0?"수정성공":"수정실패",dao.getProduct_orderList());
	}
	//---------------------------------------------------------------------------------------------
	
	public List<Product_delivery> getProduct_deliveryListbyPname(Product_delivery sch){
		if(sch.getP_name()==null)sch.setP_name("");
		if(sch.getStartDate()==null)sch.setStartDate("");
		if(sch.getEndDate()==null)sch.setEndDate("");
		sch.setP_name("%"+sch.getP_name()+"%");
		sch.setStartDate(sch.getStartDate());
		sch.setEndDate(sch.getEndDate());
		return dao.getProduct_deliveryListbyPname(sch);
	}
	
	public CudVo insProduct_delList(Product_delivery ins) {
		return new CudVo(dao.insProduct_delList(ins)>0?"등록성공":"등록실패",dao.getProduct_deliveryList());
	}
	
	
	
	
	//페이징처리된 목록 가져오기
//	public List<Product_delivery> getProduct_deliveryListA(Sch sch) {
//		if(sch.getP_name()==null)sch.setP_name("");
//		if(sch.getStartDate()==null)sch.setStartDate("");
//		if(sch.getEndDate()==null)sch.setEndDate("");
//		sch.setP_name("%"+sch.getP_name()+"%");
//		sch.setStartDate(sch.getStartDate());
//		sch.setEndDate(sch.getEndDate());
//		sch.setEnd(sch.getEnd());
//		sch.setStart(sch.getStart());
//		if(sch.getEnd()==0) sch.setEnd(500);
//		//sch.setCount(dao.getProduct_deliveryListbyPnameCount(sch));
//		if(sch.getPageSize()==0) {
//			sch.setPageSize(5);
//		}
//		sch.setPageCount((int)Math.ceil(  sch.getCount()/(double)sch.getPageSize() ));
//		if(sch.getCurPage()==0)
//			sch.setCurPage(1);
//		if(sch.getCurPage()>sch.getPageCount())
//			sch.setCurPage(sch.getPageCount());
//		sch.setStart((sch.getCurPage()-1)*sch.getPageSize()+1);
//		
//		
//		
//		int endNo = sch.getCurPage()*sch.getPageSize();
//		
//		sch.setBlockSize(5);
//		int blockNum = (int)Math.ceil(sch.getCurPage()/(double)sch.getBlockSize());
//		sch.setStartBlock((blockNum-1)*sch.getBlockSize()+1);
//		int endBlock = blockNum * sch.getBlockSize();
//		sch.setEndBlock(endBlock>sch.getPageCount()?sch.getPageCount():endBlock);
//		
//		
//		return dao.getProduct_deliveryListbyPname(sch);
//	}
	
	
	//페이징처리된 목록 개수  검색후 가져오기
//	public int getProduct_deliveryCount(Sch sch){
//		if(sch.getP_name()==null)sch.setP_name("");
//		if(sch.getStartDate()==null)sch.setStartDate("");
//		if(sch.getEndDate()==null)sch.setEndDate("");
//		sch.setP_name("%"+sch.getP_name()+"%");
//		sch.setStartDate(sch.getStartDate());
//		sch.setEndDate(sch.getEndDate());
//		sch.setStart(1);
//		if(sch.getEnd()==0)
//		sch.setEnd(500);
//		return dao.getProduct_deliveryListbyPnameCount(sch);
//	}
//재고리스트---------------------------------------------------------
	public List<Product> getProductList(){		
		return dao.getProductList();
	}
	public CudVo insProductList(Product ins) {
		return new CudVo(dao.insProductList(ins)>0?"등록성공":"등록실패",dao.getProduct_deliveryList());
	}
	
    public boolean isProductExists(String p_name) {
        if (p_name == null || p_name.trim().isEmpty()) {
            return false; // 빈 값이면 false 반환
        }
        return dao.Ckp_name(p_name) > 0;
    }
    
	public List<Product_delivery> getProduct_deliveryListbyp_name1(String p_name) {
		if(p_name==null) {
			p_name="";
		}
		return dao.getProduct_deliveryListbyP_name1(p_name);
	}
    
    
    
}
