package com.web.spring.AttMng;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.web.spring.Final.vo.Salary;

@Mapper
public interface TaxDao {

	
	
//	@Select("SELECT s.sal AS sal , s.depen AS depen "
//			+ "FROM SALARY s JOIN erpemp e ON e.empno = s.empno "
//			+ "WHERE e.ename = #{ename}")
	
	@Select("SELECT s.sal, s.depen\r\n"
			+ "FROM SALARY s, erpemp e\r\n"
			+ "WHERE e.ename = #{ename}\r\n"
			+ "AND e.empno = s.empno")
	
	Salary salList(@Param("ename") String ename);

	
	
}
