package com.web.spring.storage;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.web.spring.storage.vo.Product;
import com.web.spring.storage.vo.Product_delivery;
import com.web.spring.storage.vo.Product_order;
import com.web.spring.storage.vo.Sch;



@Mapper


//------------------Porduct_order-------------------------------------------------
public interface A13_Dao {
	
	//전체 구매리스트 조건없이 불러오기
	@Select("SELECT \r\n"
			+ "    orderno, \r\n"
			+ "    p_id, \r\n"
			+ "    empno, \r\n"
			+ "    p_name, \r\n"
			+ "    TO_CHAR(period, 'YYYY-MM-DD') AS period, \r\n"
			+ "    price, \r\n"
			+ "    email, \r\n"
			+ "    TO_CHAR(delivery_date, 'YYYY-MM-DD') AS delivery_date, \r\n"
			+ "    cnt \r\n"
			+ "FROM product_order \r\n"
			+ "order by orderno")
	List<Product_order> getProduct_orderList();
	

	//전체 구매리스트 날짜, 물건명 검색후 리스트 불러오기
	@Select("SELECT \r\n"
			+ "    orderno, \r\n"
			+ "    p_id, \r\n"
			+ "    empno, \r\n"
			+ "    p_name, \r\n"
			+ "    TO_CHAR(period, 'YYYY-MM-DD') AS period, \r\n"
			+ "    price, \r\n"
			+ "    email, \r\n"
			+ "    TO_CHAR(delivery_date, 'YYYY-MM-DD') AS delivery_date, \r\n"
			+ "    cnt \r\n"
			+ "FROM product_order WHERE p_name LIKE #{p_name} \r\n"
			+ "AND (#{startDate} IS NULL OR #{endDate} IS NULL OR TRUNC(delivery_date) BETWEEN TO_DATE(#{startDate}, 'YYYY-MM-DD') AND TO_DATE(#{endDate}, 'YYYY-MM-DD')) \r\n"
			+ "order by orderno")
	List<Product_order> getProduct_orderListbyPname(Product_order sch);
	
	// 구매정보 등록
	@Insert("INSERT INTO product_order VALUES(order_seq.nextval,p_id_seq.nextval,#{empno},#{p_name},\r\n"
			+ "trunc(sysdate)+10,#{price},#{email},trunc(sysdate)+2,#{cnt})")
	int insProduct_orderList(Product_order ins);
	

	// 구매정보 수정
	@Update("UPDATE PRODUCT_ORDER\r\n"
			+ "	SET empno=#{empno},\r\n"
			+ "		p_name=#{p_name},\r\n"
			+ "		price=#{price},\r\n"
			+ "		cnt=#{cnt},\r\n"
			+ "		email=#{email}\r\n"
			+ "	WHERE orderno=#{orderno}")
	int uptProduct_orderList(Product_order upt);
	
	// 구매정보 세부사항
	@Select("SELECT \r\n"
			+ "    orderno, \r\n"
			+ "    p_id, \r\n"
			+ "    empno, \r\n"
			+ "    p_name, \r\n"
			+ "    TO_CHAR(period, 'YYYY-MM-DD') AS period, \r\n"
			+ "    price, \r\n"
			+ "    email, \r\n"
			+ "    TO_CHAR(delivery_date, 'YYYY-MM-DD') AS delivery_date, \r\n"
			+ "    cnt \r\n"
			+ "FROM product_order where orderno=#{orderno} \r\n"
			+ "order by orderno")
	Product_order getProduct_orderListbyorderno(@Param("orderno") int orderno);
	
	//-------------------Product delivery---------------------------------------------------------
	// 전체 입출고 리스트 조건없이 불러오기
	  @Select("	SELECT  rownum ncnt,\r\n"
	    		+ "		    d.orderno, \r\n"
	    		+ "		    d.P_NAME, \r\n"
	    		+ "		    p.price, \r\n"
	    		+ "		    d.inputtype, \r\n"
	    		+ "		    p.inventory, \r\n"
	    		+ "		    TO_CHAR(d.delivery_date, 'YYYY-MM-DD') AS DELIVERY_DATE, \r\n"
	    		+ "		    d.cnt\r\n"
			+ "FROM product_delivery d, product p WHERE p.p_name=d.p_name \r\n"
			+ "ORDER BY orderno")
	List<Product_delivery> getProduct_deliveryList();
	//전체 입출고리스트 날짜, 물건명 검색후 리스트 불러오기
	  @Select("	SELECT  rownum ncnt,\r\n"
	    		+ "		    d.orderno, \r\n"
	    		+ "		    d.P_NAME, \r\n"
	    		+ "		    p.price, \r\n"
	    		+ "		    d.inputtype, \r\n"
	    		+ "		    p.inventory, \r\n"
	    		+ "		    TO_CHAR(d.delivery_date, 'YYYY-MM-DD') AS DELIVERY_DATE, \r\n"
	    		+ "		    d.cnt\r\n"
			+ "FROM product_delivery d, product p WHERE p.p_name=d.p_name and d.p_name LIKE #{p_name} \r\n"
			+ "AND (#{startDate} IS NULL OR #{endDate} IS NULL OR TRUNC(delivery_date) BETWEEN TO_DATE(#{startDate}, 'YYYY-MM-DD') AND TO_DATE(#{endDate}, 'YYYY-MM-DD')) \r\n"
			+ "order by ncnt")
	List<Product_delivery> getProduct_deliveryListbyPname(Product_delivery sch);
	
	
	//페이징처리된 목록
//	  @Select("	SELECT * FROM(SELECT rownum ncnt,\r\n"
//	    		+ "		    orderno, \r\n"
//	    		+ "		    P_NAME, \r\n"
//	    		+ "		    PRICE ,  \r\n"
//	    		+ "		    TO_CHAR(delivery_date, 'YYYY-MM-DD') AS DELIVERY_DATE, \r\n"
//	    		+ "		    cnt,\r\n"
//	    		+ "		    inventory\r\n"
//	    		+ "		FROM product_delivery \r\n"
//	    		+ "		WHERE p_name LIKE #{p_name}\r\n"
//				+ "	AND (#{startDate} IS NULL OR #{endDate} IS NULL OR TRUNC(delivery_date) BETWEEN TO_DATE(#{startDate}, 'YYYY-MM-DD') AND TO_DATE(#{endDate}, 'YYYY-MM-DD')) \r\n"
//	    		+ "		ORDER BY ncnt)\r\n"
//	    		+ "		WHERE ncnt BETWEEN #{start} AND #{end}")
//	List<Product_delivery> getProduct_deliveryListbyPname(Sch sch);
	
	
	//페이처리된 목록 개수
//	    @Select("	SELECT count(*) FROM(SELECT rownum ncnt,\r\n"
//	    		+ "		    orderno, \r\n"
//	    		+ "		    P_NAME, \r\n"
//	    		+ "		    PRICE ,  \r\n"
//	    		+ "		    TO_CHAR(delivery_date, 'YYYY-MM-DD') AS DELIVERY_DATE, \r\n"
//	    		+ "		    cnt,\r\n"
//	    		+ "		    inventory\r\n"
//	    		+ "		FROM product_delivery \r\n"
//	    		+ "		WHERE p_name LIKE #{p_name}\r\n"
//				+ "	AND (#{startDate} IS NULL OR #{endDate} IS NULL OR TRUNC(delivery_date) BETWEEN TO_DATE(#{startDate}, 'YYYY-MM-DD') AND TO_DATE(#{endDate}, 'YYYY-MM-DD')) \r\n"
//	    		+ "		ORDER BY orderno)\r\n"
//	    		+ "		WHERE ncnt BETWEEN #{start} AND #{end}")
//	    int getProduct_deliveryListbyPnameCount(Sch sch);


	
	

//	SELECT count(*) FROM(SELECT rownum ncnt,
//		    orderno, 
//		    P_NAME, 
//		    PRICE ,  
//		    TO_CHAR(delivery_date, 'YYYY-MM-DD') AS DELIVERY_DATE, 
//		    cnt,
//		    inventory
//		FROM product_delivery 
//		WHERE p_name LIKE #{pname}
//		AND DELIVERY_DATE BETWEEN TO_DATE(#{startDate}, 'YYYY-MM-DD')
//		AND TO_DATE(#{endDate}, 'YYYY-MM-DD')
//		ORDER BY orderno)
//		WHERE ncnt BETWEEN #{start1} AND #{end1})
	
	// 입출고정보 등록
	@Insert("INSERT INTO product_delivery VALUES(sel_seq.nextval,#{p_name},sysdate+3,#{cnt},#{inputtype})")
	int insProduct_delList(Product_delivery ins);
	
	//재고리스트---------------------------------------------------------
	@Select("SELECT * FROM(\r\n"
			+ "SELECT rownum cnt,p.* FROM product p)")
	List<Product> getProductList();
	
	@Select("SELECT count(*) FROM(\r\n"
			+ "SELECT rownum cnt,p.* FROM product p)")
	int getProductListCount();
	
	@Insert("INSERT INTO product VALUES(p_seq.nextval,#{p_name},#{price},#{inventory})")
	int insProductList(Product ins);
	@Select("SELECT count(*) FROM\r\n"
			+ " product where p_name=#{p_name}")
	int Ckp_name(@Param("p_name") String p_name);
	
	
	//재고품목의 입출고내역
	@Select("SELECT p_name,cnt,INPUTTYPE,DELIVERY_DATE FROM PRODUCT_DELIVERY  \r\n"
			+ "WHERE p_name =#{p_name}")
	List<Product_delivery> getProduct_deliveryListbyP_name1(@Param("p_name") String p_name);
	
	
}
