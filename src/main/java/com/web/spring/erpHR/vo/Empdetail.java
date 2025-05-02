package com.web.spring.erpHR.vo;

public class Empdetail {
	private int empno;
	private String address;
	private long rrn;
	private double sal;
	private double comm;
	public int getEmpno() {
		return empno;
	}
	public void setEmpno(int empno) {
		this.empno = empno;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public long getRrn() {
		return rrn;
	}
	public void setRrn(long rrn) {
		this.rrn = rrn;
	}
	public double getSal() {
		return sal;
	}
	public void setSal(double sal) {
		this.sal = sal;
	}
	public double getComm() {
		return comm;
	}
	public void setComm(double comm) {
		this.comm = comm;
	}
	public Empdetail(int empno, String address, long rrn, double sal, double comm) {
		this.empno = empno;
		this.address = address;
		this.rrn = rrn;
		this.sal = sal;
		this.comm = comm;
	}
	public Empdetail() {
		// TODO Auto-generated constructor stub
	}
}
