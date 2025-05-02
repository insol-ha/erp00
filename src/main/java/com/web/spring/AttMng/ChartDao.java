package com.web.spring.AttMng;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.web.spring.Final.vo.Att;


@Mapper
public interface ChartDao {

//	@Select("select ename, usedpto, (pto-usedpto) as unusedpto"
//			+ "wfh, usedwfh from att")
//	List<Att> getChartList();
	
	
	
	@Select("select empno, ename, pto, wfh,usedpto,usedwfh, (pto-usedpto) as unusedpto\r\n"
			+ "	from att")
	List<Att> getChartList();
	
	
//	@Select("select * from gantt")
//	List<Gantt> getGanttList();
	
	
}
