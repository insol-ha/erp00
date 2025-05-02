package com.web.spring.performance.vo;

import java.util.Date;

public class Perform { 
	private String store; 
	private String dname;
	public String getDname() {
		return dname;
	}
	public void setDname(String dname) {
		this.dname = dname;
	}
	private int sellparice;
	private Date selldate;
	private String month;
	private int tot;
	public Perform() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Perform(String store, int sellparice, Date selldate) {
		super();
		this.store = store;
		this.sellparice = sellparice;
		this.selldate = selldate;
	}
	public String getStore() {
		return store;
	}
	public void setStore(String store) {
		this.store = store;
	}
	public int getSellparice() {
		return sellparice;
	}
	public void setSellparice(int sellparice) {
		this.sellparice = sellparice;
	}
	public Date getSelldate() {
		return selldate;
	}
	public void setSelldate(Date selldate) {
		this.selldate = selldate;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public int getTot() {
		return tot;
	}
	public void setTot(int tot) {
		this.tot = tot;
	}
	
}
