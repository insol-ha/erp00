package com.web.spring.erpHR;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;

import com.web.spring.erpHR.vo.Depart;
import com.web.spring.erpHR.vo.Empdetail;
import com.web.spring.erpHR.vo.Emphistory;
import com.web.spring.erpHR.vo.Erpemp;
import com.web.spring.erpHR.vo.Job;

@Mapper
public interface LoginDao {
	@Select ("""
SELECT e.*, j.auth, d.dname FROM erpemp e JOIN job j ON e.JOBID =j.JOBID 
join depart d on d.deptno=e.deptno
where empno = #{empno} and pwd = #{pwd}""")
	Erpemp login(Erpemp log);
	
	@Select("""
SELECT e.*, d.*, j.* FROM erpemp e JOIN depart d ON e.deptno =d.DEPTNO 
JOIN job j ON j.jobid=e.JOBID where ename like #{ename} and dname like #{dname}
order by empno
			""")
	List<Erpemp> getEmpList(Erpemp sch);
	
	@Select("select * from depart order by deptno")
	List<Depart> getDepartList();
	
	@Select("select * from job order by jobid")
	ArrayList<Job> getJobList();
	
	@Insert("""
			INSERT INTO erpemp  
			VALUES (#{empno, jdbcType=INTEGER}, 
			        #{ename, jdbcType=VARCHAR}, 
			        #{pwd, jdbcType=VARCHAR}, 
			        TO_CHAR(TRUNC(SYSDATE), 'YYYY-MM-DD'), 
			        #{jobid, jdbcType=INTEGER}, 
			        #{pnum, jdbcType=VARCHAR}, 
			        #{email, jdbcType=VARCHAR}, 
			        #{deptno, jdbcType=INTEGER}, 
			        #{managerid, jdbcType=INTEGER})
			""")
	@SelectKey(statement="SELECT erpemp_seq.nextval  FROM dual", 
	keyProperty = "empno", before=true, resultType=int.class)
			int insertErpEmp(Erpemp ins);
	@Insert("""
INSERT INTO emphistory values(#{empno, jdbcType=INTEGER},
TO_CHAR(TRUNC(SYSDATE),'YYYY-MM-DD'),null,
#{deptno, jdbcType=INTEGER}, #{jobid, jdbcType=INTEGER})
			""")
			int insertEmpHistory(Erpemp ins);
			
	@Update("""
update erpemp set ename=#{ename, jdbcType=VARCHAR}, pwd=#{pwd, jdbcType=VARCHAR}, 
hired=#{hired, jdbcType=DATE}, jobid=#{jobid, jdbcType=INTEGER},
pnum=#{pnum, jdbcType=VARCHAR}, email=#{email, jdbcType=VARCHAR},
deptno=#{deptno, jdbcType=INTEGER}, managerid=#{managerid, jdbcType=INTEGER}
where empno=#{empno, jdbcType=INTEGER}
			""")
			int updateErpEmp(Erpemp upt);

	
	@Delete("delete erpemp where empno=#{empno}")
	int deleteErpEmp(@Param("empno") int empno);
	
	@Delete("delete emphistory where empno=#{empno}")
	int deleteEmpHistory(@Param("empno") int empno);
	
	@Select("""
SELECT e.*, d.*, j.* FROM erpemp e JOIN depart d ON e.deptno =d.DEPTNO 
JOIN job j ON j.jobid=e.JOBID where empno = #{empno}
			""")
	Erpemp getErpEmp(@Param("empno") int empno); 

	@Select("select eh.*,j.jname,d.dname from emphistory eh join depart d on d.deptno=eh.deptno "
			+ "join job j on j.jobid=eh.jobid where empno=#{empno}")
	List<Emphistory> getEmphistory(@Param("empno") int empno);
	
	@Select("select * from empdetail where empno = #{empno}")
	Empdetail getEmpdetail(@Param("empno") int empno);
	
	@Select("select empno from erpemp")
	List<Integer> getEmpnoList();
}
