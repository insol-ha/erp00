package com.web.spring.erpHR.vo;

public class Depart {
	private int deptno;
	private String dname;
	private String loc;
	private int managerid;
	public int getDeptno() {
		return deptno;
	}
	public void setDeptno(int deptno) {
		this.deptno = deptno;
	}
	public String getDname() {
		return dname;
	}
	public void setDname(String dname) {
		this.dname = dname;
	}
	public String getLoc() {
		return loc;
	}
	public void setLoc(String loc) {
		this.loc = loc;
	}
	public int getManagerid() {
		return managerid;
	}
	public void setManagerid(int managerid) {
		this.managerid = managerid;
	}
	public Depart(int deptno, String dname, String loc, int managerid) {
		this.deptno = deptno;
		this.dname = dname;
		this.loc = loc;
		this.managerid = managerid;
	}
	public Depart() {
		// TODO Auto-generated constructor stub
	}
}
