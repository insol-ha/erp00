package com.web.spring.erpHR;

import java.time.LocalDate;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.type.JdbcType;

import com.web.spring.erpHR.vo.Depart;
import com.web.spring.erpHR.vo.Emphistory;
import com.web.spring.erpHR.vo.Job;

@Mapper
public interface HrDao {
	
	@Select("select * from depart where dname like #{dname} and loc like #{loc} order by deptno")
	List<Depart> getDepartList(Depart sch);
	
	@Insert("""
insert into depart values(deptno_seq.nextval,#{dname, jdbcType=VARCHAR},
 #{loc, jdbcType=VARCHAR},#{managerid, jdbcType=INTEGER})
			""")
	int insertDepart(Depart ins);
	
	@Select("""
select * from depart where deptno=#{deptno}
			""")
	Depart getDepart(@Param("deptno") int deptno);
	
	@Update("""
update depart set dname=#{dname, jdbcType=VARCHAR}, loc=#{loc, jdbcType=VARCHAR}, managerid=#{managerid, jdbcType=INTEGER} where deptno=#{deptno, jdbcType=INTEGER}
			""")
	int updateDepart(Depart upt);
	
	@Delete("""
delete depart where deptno = #{deptno}
			""")
	int deleteDepart(@Param("deptno") int deptno);
	
	@Select("select * from job where jname like #{jname} order by jobid")
	List<Job> getJobList(Job sch);
	
	@Select("""
select eh.*, d.dname,e.ename,j.jname from emphistory eh join depart d on eh.deptno=d.deptno 
JOIN erpemp e ON e.empno=eh.empno join job j on eh.jobid=j.jobid
where ename like #{ename} and dname like #{dname} order by eh.empno, eh.enddate desc
			""")
	List<Emphistory> getHistoryList(Emphistory sch);
	
	@Insert("""
	INSERT INTO emphistory values(#{empno, jdbcType=INTEGER},
	TO_CHAR(TRUNC(SYSDATE),'YYYY-MM-DD'),null,
	#{deptno, jdbcType=INTEGER}, #{jobid, jdbcType=INTEGER})
						""")
	int insertEmpHistory(Emphistory ins);
	
	@Update("""
	Update emphistory set enddate = TO_CHAR(TRUNC(SYSDATE), 'YYYY-MM-DD') 
	where empno = #{empno} and enddate IS NULL
			""")
	int endEmpHistory(Emphistory ins);
	
	@Update("""
	update erpemp set jobid=#{jobid}, deptno=#{deptno} where empno=#{empno}
			""")
	int updateEmpByHistory(Emphistory ins);

	@Results({
	    @Result(property = "startdate", column = "startdate", javaType = LocalDate.class, jdbcType = JdbcType.DATE)
	})
	@Select("select * from emphistory where empno=#{empno} and startdate=to_date(#{startdateStr, jdbcType=VARCHAR},'YYYY-MM-DD')")
	Emphistory getEmpHistory(@Param("empno") int empno, @Param("startdateStr") String startdateStr);
	
	@Update("""
update emphistory set enddate=#{enddateStr, jdbcType=DATE}, deptno=#{deptno}, jobid=#{jobid} where empno=#{empno} and startdate=#{startdateStr}
			""")
	int updateEmpHistory(Emphistory upt);
	
	@Delete("delete emphistory where empno=#{empno} and startdate=to_date(#{startdateStr, jdbcType=VARCHAR},'YYYY-MM-DD')")
	int deleteEmpHistory(@Param("empno") int empno, @Param("startdateStr") String startdateStr);
	
}