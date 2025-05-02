package com.web.spring.erpHR;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.spring.erpHR.vo.Depart;
import com.web.spring.erpHR.vo.Emphistory;

@Service
public class HrService {
	@Autowired(required=false)
	private HrDao dao;
	
	public List<Depart> getDepartList(Depart sch){
		if(sch.getDname()==null) sch.setDname("");
		sch.setDname("%"+sch.getDname()+"%");
		if(sch.getLoc()==null) sch.setLoc("");
		sch.setLoc("%"+sch.getLoc()+"%");
		return dao.getDepartList(sch);
	}
	
	public String insertDepart(Depart ins) {
		return dao.insertDepart(ins)>0?"등록성공":"등록실패";
	}
	
	public Depart getDepart(int deptno) {
		return dao.getDepart(deptno);
	}
	
	public String updateDepart(Depart upt) {
		return dao.updateDepart(upt)>0?"수정성공":"수정실패";
	}
	public String deleteDepart(int deptno) {
		return dao.deleteDepart(deptno)>0?"삭제성공":"삭제실패";
	}
	
	public List<Emphistory> getHistoryList(Emphistory sch){
		if(sch.getEname()==null) sch.setEname("");
		sch.setEname("%"+sch.getEname()+"%");
		if(sch.getDname()==null) sch.setDname("");
		sch.setDname("%"+sch.getDname()+"%");
		return dao.getHistoryList(sch);
	}
	
	public String insertEmpHistory(Emphistory ins) {
		Date today = new Date();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String td = format.format(today);
		Emphistory ckEh = dao.getEmpHistory(ins.getEmpno(), td);
		// 금일 새 업무가 시작된 이력이 있는지 검사
		String msg = "";
		if(ckEh!=null) { // 금일 새 업무가 등록이 되어있으면 등록x
			msg = "금일 인사이동 이력이 이미 존재합니다";
		}else { // 금일 등록된 업무가 없을땐 등록 진행
			int end = dao.endEmpHistory(ins);
			int history = dao.insertEmpHistory(ins);
			if(end>0&&history>0) {
				int uptEmp = dao.updateEmpByHistory(ins);
				if(uptEmp>0) {
					msg = "현재 업무 종료 성공\n신규 업무 등록 성공\n기존 사원정보가 변경되었습니다";
				}else {
					msg = "현재 업무 종료 성공\n신규 업무 등록 성공\n기존 사원정보 변경 실패";
				}
			}else if(end<1&&history>0) {
				msg = "현재 업무 종료 실패\n신규 업무 등록 성공";
			}else if(end>0&&history<1) {
				msg = "현재 업무 종료 성공\n신규 업무 등록 실패";
			}
		}
		return msg;
	}
	
	public Emphistory getEmphistory(int empno, String startdateStr) {
		return dao.getEmpHistory(empno,startdateStr);
	}
	
	public String updateEmpHistory(Emphistory upt) {
		if(upt.getEnddateStr()=="") {
			upt.setEnddateStr(null);
		}
		return dao.updateEmpHistory(upt)>0?"수정성공":"수정실패";
	}
	public String deleteEmpHistory(int empno, String startdateStr) {
		return dao.deleteEmpHistory(empno,startdateStr)>0?"삭제성공":"삭제실패";
	}
}
