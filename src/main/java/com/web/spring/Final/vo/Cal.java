package com.web.spring.Final.vo;

import java.sql.Timestamp;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class Cal {
//	id number primary key,
//	title varchar2(100),
//	start1 Date,  
//	end1 Date,
//	content varchar2(100),
//	backgroundcolor varchar2(50),
//	textcolor varchar2(50),
//	allday number(1)
//  empno number 
	
	private int id; // 1
	private String ename; // 2
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date start; // 3
	@DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date end; // 4
	private String content; // 5
	private String backgroundColor; // 6
	private String textColor; // 7
	private boolean allDay; // 8
	private int empno;
   
	public Cal() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Cal(int id, String ename, Date start, Date end, String content, String backgroundColor, String textColor,
			boolean allDay, int empno) {
		super();
		this.id = id;
		this.ename = ename;
		this.start = start;
		this.end = end;
		this.content = content;
		this.backgroundColor = backgroundColor;
		this.textColor = textColor;
		this.allDay = allDay;
		this.empno = empno;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getEname() {
		return ename;
	}
	public void setEname(String ename) {
		this.ename = ename;
	}
	public Date getStart() {
		return start;
	}
	public void setStart(Date start) {
		this.start = start;
	}
	public Date getEnd() {
		return end;
	}
	public void setEnd(Date end) {
		this.end = end;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getBackgroundColor() {
		return backgroundColor;
	}
	public void setBackgroundColor(String backgroundColor) {
		this.backgroundColor = backgroundColor;
	}
	public String getTextColor() {
		return textColor;
	}
	public void setTextColor(String textColor) {
		this.textColor = textColor;
	}
	public boolean isAllDay() {
		return allDay;
	}
	public void setAllDay(boolean allDay) {
		this.allDay = allDay;
	}
	public int getEmpno() {
		return empno;
	}
	public void setEmpno(int empno) {
		this.empno = empno;
	}
	

	
	
}
