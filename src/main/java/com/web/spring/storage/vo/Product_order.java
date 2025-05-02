package com.web.spring.storage.vo;

import java.util.Date;

public class Product_order {
	private int orderno;
	private int p_id;
	private int empno;
	private String p_name;
	private String period;
	private int price;
	private String email;
	private String delivery_date;
	private int cnt;
	private String startDate;
	private String endDate;
	
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public Product_order() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Product_order(int orderno, int p_id, int empno, String p_name, String period, int price, String email,
			String delivery_date, int cnt) {
		super();
		this.orderno = orderno;
		this.p_id = p_id;
		this.empno = empno;
		this.p_name = p_name;
		this.period = period;
		this.price = price;
		this.email = email;
		this.delivery_date = delivery_date;
		this.cnt = cnt;
	}
	public int getOrderno() {
		return orderno;
	}
	public void setOrderno(int orderno) {
		this.orderno = orderno;
	}
	public int getP_id() {
		return p_id;
	}
	public void setP_id(int p_id) {
		this.p_id = p_id;
	}
	public int getEmpno() {
		return empno;
	}
	public void setEmpno(int empno) {
		this.empno = empno;
	}
	public String getP_name() {
		return p_name;
	}
	public void setP_name(String p_name) {
		this.p_name = p_name;
	}
	public String getPeriod() {
		return period;
	}
	public void setPeriod(String period) {
		this.period = period;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getDelivery_date() {
		return delivery_date;
	}
	public void setDelivery_date(String delivery_date) {
		this.delivery_date = delivery_date;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	
	

}
