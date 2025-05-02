package com.web.spring.performance.vo;

import java.util.Date;

public class Eachperfor { 
	private String name;
	private int target;
	private int sellcnt;
	private Date sellmonth;
	private String emonth;
	private String job;
	private int deptno;
	public Eachperfor() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Eachperfor(String name, int target, int sellcnt, Date sellmonth) {
		super();
		this.name = name;
		this.target = target;
		this.sellcnt = sellcnt;
		this.sellmonth = sellmonth;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getTarget() {
		return target;
	}
	public void setTarget(int target) {
		this.target = target;
	}
	public int getSellcnt() {
		return sellcnt;
	}
	public void setSellcnt(int sellcnt) {
		this.sellcnt = sellcnt;
	}
	public Date getSellmonth() {
		return sellmonth;
	}
	public void setSellmonth(Date sellmonth) {
		this.sellmonth = sellmonth;
	}
	public String getEmonth() {
		return emonth;
	}
	public void setEmonth(String emonth) {
		this.emonth = emonth;
	}
	public String getJob() {
		return job;
	}
	public void setJob(String job) {
		this.job = job;
	}
	public int getDeptno() {
		return deptno;
	}
	public void setDeptno(int deptno) {
		this.deptno = deptno;
	}
	
}
