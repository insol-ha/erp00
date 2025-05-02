package com.web.spring.AttMng;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.web.spring.Final.vo.Att;



@Mapper
public interface LeaveMngtDao {

	@Select("SELECT empno , ename, pto,wfh, usedpto , usedwfh FROM att")
	List<Att> getAttList(); 
	
	
	@Update("UPDATE att \r\n"
			+ "SET usedpto = 0, usedwfh = 0")
	int uptUsedpto();
	
	
	
	
	
	
}
