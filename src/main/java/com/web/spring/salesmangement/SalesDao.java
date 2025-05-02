package com.web.spring.salesmangement;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;


import com.web.spring.salesmangement.vo.Sales;

@Mapper
public interface SalesDao {

	@Select("SELECT no,pname,cnt,price,\r\n"
			+ "(cnt*price) AS tot,to_char(saledate,'YYYY-MM-DD') salesdate,store \r\n"
			+ "FROM SALESMANGEMENT s order by no") 
	List<Sales> getSalesList();
	
	@Select("SELECT s.no,s.pname,s.cnt,s.price,(s.cnt*s.price) AS tot,"
			+ "TO_CHAR(s.saledate, 'YYYY-MM-DD') AS salesdate ,"
			+ "s.store, d.dname FROM salesmangement s\r\n "
			+ "join depart d on s.store = d.deptno "
			+ "WHERE d.dname LIKE #{dname} "
			+ "AND (#{start} IS NULL OR #{end} IS NULL OR TRUNC(saledate) "
			+ "BETWEEN TO_DATE(#{start},'YYYY-MM-DD') "
			+ "AND TO_DATE(#{end},'YYYY-MM-DD')) order by no")
	List<Sales> getSalesList1(Sales sch);

	@Select("SELECT * FROM SALESMANGEMENT WHERE pname = #{pname}")
	Sales getSales(@Param("pname") String pname);
	
	@Insert("INSERT INTO salesmangement values"
			+ "(#{no},#{pname},#{cnt},#{price},"
			+ "#{saledate},#{store})")
	int insertSales1(Sales ins);
	
	@Insert("INSERT INTO salesmangement "
			+ "values(sale_seq.nextval,#{pname},#{cnt},#{price},"
			+ "to_date(#{salesdate},'YYYY-MM-DD'),#{store})")
	int insertSales2(Sales ins);

	@Select("SELECT no,pname,cnt,price,(cnt*price) AS tot,to_char(saledate,'YYYY-MM-DD') salesdate,store FROM salesmangement WHERE NO=#{no}")
	Sales getSales1(@Param("no") int no);
	
	@Update("UPDATE SALESMANGEMENT SET pname=#{pname}, "
			+ "cnt=#{cnt}, price=#{price},"
			+ " saledate=#{salesdate}, store=#{store} "
			+ "WHERE NO=#{no}")
	int updateSale(Sales upt);
	
	@Delete("DELETE FROM  SALESMANGEMENT WHERE NO=#{no}")
	int deleteSale(@Param("no") int no);
	

}
