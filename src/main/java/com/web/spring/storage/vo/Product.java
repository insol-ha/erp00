package com.web.spring.storage.vo;

public class Product {
	private int pcode;
	private String p_name;
	private int price;
	private int inventory;
	private String etc;
	
	public String getEtc() {
		return etc;
	}
	public void setEtc(String etc) {
		this.etc = etc;
	}
	public Product() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Product(int pcode, String p_name, int price, int inventory) {
		super();
		this.pcode = pcode;
		this.p_name = p_name;
		this.price = price;
		this.inventory = inventory;
	}
	public int getPcode() {
		return pcode;
	}
	public void setPcode(int pcode) {
		this.pcode = pcode;
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
	public int getInventory() {
		return inventory;
	}
	public void setInventory(int inventory) {
		this.inventory = inventory;
	}
	

}
