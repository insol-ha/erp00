package com.web.spring.performance;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.web.spring.performance.vo.Eachperfor;
import com.web.spring.performance.vo.Perform;

@Mapper
public interface Pdao {
	
	//@Select("SELECT * FROM PERFORbYSTORE WHERE store LIKE #{store}")
	@Select("SELECT \r\n"
			+ "    s.store, \r\n"
			+ "    d.dname AS dname,max(to_char(s.saledate,'YYYY-MM-DD')) AS month, \r\n"
			+ "    SUM(s.price * s.cnt) AS tot\r\n"
			+ "FROM SALESMANGEMENT s\r\n"
			+ "JOIN depart d ON s.store = d.deptno\r\n"
			+ "GROUP BY s.store, d.dname order by s.store")
	List<Perform> getPerform();
	
	
	
	@Select("SELECT ea.empno,ea.name, ea.job,ea.TARGET,ea.SELLCNT, "
			+ "to_char(ea.SELLMONTH,'YYYY-MM') emonth,d.dname, d.deptno \r\n"
			+ "from eachperfor ea \r\n"
			+ "JOIN ERPEMP e ON e.empno = ea.empno\r\n"
			+ "JOIN DEPART d ON d.deptno =e.deptno \r\n"
			+ "where e.deptno = #{deptno} ORDER BY empno")
	List<Eachperfor> geteachperfor(Eachperfor sch);
	
}
