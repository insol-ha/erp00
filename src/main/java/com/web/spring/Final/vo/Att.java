package com.web.spring.Final.vo;

public class Att {

	private int empno;
	private String ename;
	private int jobid;
	private double pto;
	private int wfh;
	private double usedpto;
	private double unusedpto;
	private double usedwfh;
	public Att() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Att(int empno, String ename, int jobid, double pto, int wfh, double usedpto, double unusedpto,
			double usedwfh) {
		super();
		this.empno = empno;
		this.ename = ename;
		this.jobid = jobid;
		this.pto = pto;
		this.wfh = wfh;
		this.usedpto = usedpto;
		this.unusedpto = unusedpto;
		this.usedwfh = usedwfh;
	}
	public int getEmpno() {
		return empno;
	}
	public void setEmpno(int empno) {
		this.empno = empno;
	}
	public String getEname() {
		return ename;
	}
	public void setEname(String ename) {
		this.ename = ename;
	}
	public int getJobid() {
		return jobid;
	}
	public void setJobid(int jobid) {
		this.jobid = jobid;
	}
	public double getPto() {
		return pto;
	}
	public void setPto(double pto) {
		this.pto = pto;
	}
	public int getWfh() {
		return wfh;
	}
	public void setWfh(int wfh) {
		this.wfh = wfh;
	}
	public double getUsedpto() {
		return usedpto;
	}
	public void setUsedpto(double usedpto) {
		this.usedpto = usedpto;
	}
	public double getUnusedpto() {
		return unusedpto;
	}
	public void setUnusedpto(double unusedpto) {
		this.unusedpto = unusedpto;
	}
	public double getUsedwfh() {
		return usedwfh;
	}
	public void setUsedwfh(double usedwfh) {
		this.usedwfh = usedwfh;
	}
	
	
}
