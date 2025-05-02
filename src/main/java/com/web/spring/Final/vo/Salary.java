package com.web.spring.Final.vo;

public class Salary {
	private int empno;
	private double sal;
	private int depen;
	public Salary() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Salary(int empno, double sal, int depen) {
		super();
		this.empno = empno;
		this.sal = sal;
		this.depen = depen;
	}
	public int getEmpno() {
		return empno;
	}
	public void setEmpno(int empno) {
		this.empno = empno;
	}
	public double getSal() {
		return sal;
	}
	public void setSal(double sal) {
		this.sal = sal;
	}
	public int getDepen() {
		return depen;
	}
	public void setDepen(int depen) {
		this.depen = depen;
	}

	
}
