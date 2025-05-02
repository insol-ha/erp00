package com.web.spring.board.VO;

import java.util.Date;

public class ContentVO {
	// no writer contentComment trgdte
	private int rno;
	private int no;
	private int writer;
	private String content;
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	private String contentComment;
	private Date regdte;
	public ContentVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ContentVO(int rno, int no, int writer, String contentComment, Date regdte) {
		super();
		this.rno = rno;
		this.no = no;
		this.writer = writer;
		this.contentComment = contentComment;
		this.regdte = regdte;
	}
	public int getRno() {
		return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getWriter() {
		return writer;
	}
	public void setWriter(int writer) {
		this.writer = writer;
	}
	public String getContentComment() {
		return contentComment;
	}
	public void setContentComment(String contentComment) {
		this.contentComment = contentComment;
	}
	public Date getRegdte() {
		return regdte;
	}
	public void setRegdte(Date regdte) {
		this.regdte = regdte;
	}
	
	


}