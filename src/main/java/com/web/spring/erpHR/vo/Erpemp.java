package com.web.spring.erpHR.vo;

public class Erpemp {
	    private Integer empno;  
	    private String ename;
	    private Integer jobid;
	    private Integer managerid;
	    private String hired;  
	    private String pnum;
	    private String email;
	    private Integer deptno;
	    private String pwd;
	    private String dname;
	    private String jname;
	    private int auth;
		public int getAuth() {
			return auth;
		}
		public void setAuth(int auth) {
			this.auth = auth;
		}
		public String getHired() {
			return hired;
		}
		public void setHired(String hired) {
			this.hired = hired;
		}
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
		public Integer getEmpno() {
			return empno;
		}
		public void setEmpno(Integer empno) {
			this.empno = empno;
		}
		public String getEname() {
			return ename;
		}
		public void setEname(String ename) {
			this.ename = ename;
		}
		public Integer getJobid() {
			return jobid;
		}
		public void setJobid(Integer jobid) {
			this.jobid = jobid;
		}
		public Integer getManagerid() {
			return managerid;
		}
		public void setManagerid(Integer managerid) {
			this.managerid = managerid;
		}
		public String getPnum() {
			return pnum;
		}
		public void setPnum(String pnum) {
			this.pnum = pnum;
		}
		public String getEmail() {
			return email;
		}
		public void setEmail(String email) {
			this.email = email;
		}
		public Integer getDeptno() {
			return deptno;
		}
		public void setDeptno(Integer deptno) {
			this.deptno = deptno;
		}
		public String getPwd() {
			return pwd;
		}
		public void setPwd(String pwd) {
			this.pwd = pwd;
		}
		public Erpemp() {
			// TODO Auto-generated constructor stub
		}
		public Erpemp(Integer empno, String ename, Integer jobid, Integer managerid, String hired, String pnum,
				String email, Integer deptno, String pwd) {
			this.empno = empno;
			this.ename = ename;
			this.jobid = jobid;
			this.managerid = managerid;
			this.hired = hired;
			this.pnum = pnum;
			this.email = email;
			this.deptno = deptno;
			this.pwd = pwd;
		}
		public Erpemp(Integer empno, Integer jobid, String hired, Integer deptno) {
			this.empno = empno;
			this.jobid = jobid;
			this.hired = hired;
			this.deptno = deptno;
		}

	
}
