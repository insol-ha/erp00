package com.web.spring.erpHR.vo;

import java.time.LocalDate;

import com.fasterxml.jackson.annotation.JsonFormat;

public class Emphistory {
	private int empno;
	private String ename;
	public String getEname() {
		return ename;
	}
	public void setEname(String ename) {
		this.ename = ename;
	}
	private String empnoSch;
	public String getEmpnoSch() {
		return empnoSch;
	}
	public void setEmpnoSch(String empnoSch) {
		this.empnoSch = empnoSch;
	}
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	private LocalDate startdate;
	private String startdateStr;
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	private LocalDate enddate;
	private String enddateStr;
	private int deptno;
	private int jobid;
	private String dname;
	private String jname;
	public String getDname() {
		return dname;
	}
	public void setDname(String dname) {
		this.dname = dname;
	}
	public String getJname() {
		return jname;
	}
	public void setJname(String jname) {
		this.jname = jname;
	}
	public int getEmpno() {
		return empno;
	}
	public void setEmpno(int empno) {
		this.empno = empno;
	}
	public String getStartdateStr() {
		return startdateStr;
	}
	public void setStartdateStr(String startdateStr) {
		this.startdateStr = startdateStr;
	}
	public LocalDate getStartdate() {
		return startdate;
	}
	public void setStartdate(LocalDate startdate) {
		this.startdate = startdate;
	}
	public LocalDate getEnddate() {
		return enddate;
	}
	public void setEnddate(LocalDate enddate) {
		this.enddate = enddate;
	}
	public String getEnddateStr() {
		return enddateStr;
	}
	public void setEnddateStr(String enddateStr) {
		this.enddateStr = enddateStr;
	}
	public int getDeptno() {
		return deptno;
	}
	public void setDeptno(int deptno) {
		this.deptno = deptno;
	}
	public int getJobid() {
		return jobid;
	}
	public void setJobid(int jobid) {
		this.jobid = jobid;
	}
	public Emphistory() {
		// TODO Auto-generated constructor stub
	}
}
