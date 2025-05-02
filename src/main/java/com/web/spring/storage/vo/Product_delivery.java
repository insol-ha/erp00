package com.web.spring.storage.vo;

public class Product_delivery {
	private int orderno;
	private String p_name;
	private int price;
	private String delivery_date;
	private int cnt;
	private int inventory;
	private String startDate;
	private String endDate;
	private int start1;
	private int end1;
	private int ncnt;
	private String inputtype;
	
	
	public String getInputtype() {
		return inputtype;
	}
	public void setInputtype(String inputtpe) {
		this.inputtype = inputtpe;
	}
	public int getNcnt() {
		return ncnt;
	}
	public void setNcnt(int ncnt) {
		this.ncnt = ncnt;
	}
	public int getStart1() {
		return start1;
	}
	public void setStart1(int start1) {
		this.start1 = start1;
	}
	public int getEnd1() {
		return end1;
	}
	public void setEnd1(int end1) {
		this.end1 = end1;
	}
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
	public Product_delivery() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Product_delivery(int orderno, String p_name, int price, String delivery_date, int cnt, int inventory) {
		super();
		this.orderno = orderno;
		this.p_name = p_name;
		this.price = price;
		this.delivery_date = delivery_date;
		this.cnt = cnt;
		this.inventory = inventory;
		
	}
	public int getOrderno() {
		return orderno;
	}
	public void setOrderno(int orderno) {
		this.orderno = orderno;
	}
	public String getP_name() {
		return p_name;
	}
	public void setP_name(String p_name) {
		this.p_name = p_name;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
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
	public int getInventory() {
		return inventory;
	}
	public void setInventory(int inventory) {
		this.inventory = inventory;
	}
	

}
