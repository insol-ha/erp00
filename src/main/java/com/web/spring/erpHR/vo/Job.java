package com.web.spring.erpHR.vo;

public class Job {
	private int jobid;
	private String jname;
	private int auth;
	private int minsal;
	private int maxsal;
	public int getJobid() {
		return jobid;
	}
	public void setJobid(int jobid) {
		this.jobid = jobid;
	}
	public String getJname() {
		return jname;
	}
	public void setJname(String jname) {
		this.jname = jname;
	}
	public int getAuth() {
		return auth;
	}
	public void setAuth(int auth) {
		this.auth = auth;
	}
	public int getMinsal() {
		return minsal;
	}
	public void setMinsal(int minsal) {
		this.minsal = minsal;
	}
	public int getMaxsal() {
		return maxsal;
	}
	public void setMaxsal(int maxsal) {
		this.maxsal = maxsal;
	}
	public Job(int jobid, String jname, int auth, int minsal, int maxsal) {
		this.jobid = jobid;
		this.jname = jname;
		this.auth = auth;
		this.minsal = minsal;
		this.maxsal = maxsal;
	}
	public Job() {
		// TODO Auto-generated constructor stub
	}
}
