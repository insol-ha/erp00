package com.web.spring.board.VO;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class Board {
	
	private int level;
	private int num;
	private int no;
	private int refno;
	private String subject;
	private int writer;
	private String content;
	private int readcnt;
	private Date regdte;
	private String regdteS;
	
	public String getRegdteS() {
		return regdteS;
	}

	public void setRegdteS(String regdteS) {
		this.regdteS = regdteS;
	}

	private Date uptdte;
	private MultipartFile[] reports;
	private List<String> flist; // 상세화면에서 첨부된 파일 리스트 
	private List<ContentVO> relist;
	//no refno subject writer content readcnt regdte uptdte
	public Board() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public Board(int no, int refno, int writer, String subject, String content, int readcnt, Date regdte,
			Date uptdte) {
		super();
		this.no = no;
		this.refno = refno;
		this.writer = writer;
		this.subject = subject;
		this.content = content;
		this.readcnt = readcnt;
		this.regdte = regdte;
		this.uptdte = uptdte;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getRefno() {
		return refno;
	}
	public void setRefno(int refno) {
		this.refno = refno;
	}
	public int getWriter() {
		return writer;
	}
	public void setWriter(int writer) {
		this.writer = writer;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getReadcnt() {
		return readcnt;
	}
	public void setReadcnt(int readcnt) {
		this.readcnt = readcnt;
	}
	public Date getRegdte() {
		return regdte;
	}
	public void setRegdte(Date regdte) {
		this.regdte = regdte;
	}
	public Date getUptdte() {
		return uptdte;
	}
	public void setUptdte(Date uptdte) {
		this.uptdte = uptdte;
	}

	public MultipartFile[] getReports() {
		return reports;
	}

	public void setReports(MultipartFile[] reports) {
		this.reports = reports;
	}

	public List<String> getFlist() {
		return flist;
	}

	public void setFlist(List<String> flist) {
		this.flist = flist;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	public List<ContentVO> getRelist() {
		return relist;
	}

	public void setRelist(List<ContentVO> relist) {
		this.relist = relist;
	}

	

	
	
	
	
}
