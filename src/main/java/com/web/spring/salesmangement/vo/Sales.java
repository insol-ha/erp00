package com.web.spring.salesmangement.vo;

import java.util.Date;

public class Sales {
	private int no;
	private String pname;
	private int cnt;
	private int price;
	private Date saledate;
	private String salesdate;
	private long tot;
	private String dname;
	private String start;
	private String end;
	private int store;
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public Date getSaledate() {
		return saledate;
	}
	public void setSaledate(Date saledate) {
		this.saledate = saledate;
	}
	public String getSalesdate() {
		return salesdate;
	}
	public void setSalesdate(String salesdate) {
		this.salesdate = salesdate;
	}
	public long getTot() {
		return tot;
	}
	public void setTot(long tot) {
		this.tot = tot;
	}
	public String getDname() {
		return dname;
	}
	public void setDname(String dname) {
		this.dname = dname;
	}
	public String getStart() {
		return start;
	}
	public void setStart(String start) {
		this.start = start;
	}
	public String getEnd() {
		return end;
	}
	public void setEnd(String end) {
		this.end = end;
	}
	public int getStore() {
		return store;
	}
	public void setStore(int store) {
		this.store = store;
	}
	public Sales() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Sales(int no, String pname, int cnt, int price, Date saledate, String salesdate, long tot, String dname,
			String start, String end, int store) {
		super();
		this.no = no;
		this.pname = pname;
		this.cnt = cnt;
		this.price = price;
		this.saledate = saledate;
		this.salesdate = salesdate;
		this.tot = tot;
		this.dname = dname;
		this.start = start;
		this.end = end;
		this.store = store;
	}
	
	
}
