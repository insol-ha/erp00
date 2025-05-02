package com.web.spring.erpHR.vo;

public class Empgrade {
	private int empno;
	private int gyear;
	private int first;
	private int second;
	private int third;
	private int gradeemp;
	public int getEmpno() {
		return empno;
	}
	public void setEmpno(int empno) {
		this.empno = empno;
	}
	public int getGyear() {
		return gyear;
	}
	public void setGyear(int gyear) {
		this.gyear = gyear;
	}
	public int getFirst() {
		return first;
	}
	public void setFirst(int first) {
		this.first = first;
	}
	public int getSecond() {
		return second;
	}
	public void setSecond(int second) {
		this.second = second;
	}
	public int getThird() {
		return third;
	}
	public void setThird(int third) {
		this.third = third;
	}
	public int getGradeemp() {
		return gradeemp;
	}
	public void setGradeemp(int gradeemp) {
		this.gradeemp = gradeemp;
	}
	public Empgrade(int empno, int gyear, int first, int second, int third, int gradeemp) {
		this.empno = empno;
		this.gyear = gyear;
		this.first = first;
		this.second = second;
		this.third = third;
		this.gradeemp = gradeemp;
	}
	public Empgrade() {
		// TODO Auto-generated constructor stub
	}
}
