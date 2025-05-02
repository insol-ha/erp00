package com.web.spring.AttMng;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.spring.Final.vo.Att;
import com.web.spring.Final.vo.Cal;
import com.web.spring.Final.vo.CudVo;





@Service
public class CalService {
	@Autowired(required = false)
	private CalDao dao;

	
	public List<Cal> getCalList(){
		return dao.getCalList();
	}
	
	public List<Cal> enameCalList2(String ename){
		
	return dao.enameCalList2(ename);
	}
	
	public String contentList(String ename) {
		return dao.contentList(ename);
	}
	
	
	
public CudVo insertCal(Cal ins) {
	 if (dao.checkWorkRecord(ins) > 0) {
	        return new CudVo("출결 기록이 있는 날짜에는 연차를 신청할 수 없습니다.", dao.getCalList());
	    }
	 
	 if (dao.checkDuplicatePto(ins) > 0) {
	        return new CudVo("연차 기록이 있는 날짜에는 연차를 신청할 수 없습니다.", dao.getCalList());
	    }
	 
	 
	 
	if ("".equals(ins.getContent())) {
		ins.setContent("연차");
    }
		return new CudVo(dao.insertCal(ins)>0?"등록성공":"등록실패",
				dao.getCalList());
	}
	
	public CudVo updateCal(Cal upt) {
		return new CudVo(dao.updateCal(upt)>0?"수정성공":"수정실패",
				dao.getCalList());
	}
	
	public CudVo deleteCal(Cal del) {
		return new CudVo(dao.deleteCal(del)>0?"삭제성공":"삭제실패",
				dao.getCalList());
	}
	
	public CudVo insStart(Cal insS) {
		if (dao.checkDuplicate(insS) > 0) {
	        return new CudVo("이미 해당 날짜에 출결 기록이 있습니다.", dao.getCalList());
	    }
		if (insS.getContent() == null || insS.getContent().trim().isEmpty()) {
		        insS.setContent("출근 중");
		    }
	
		return new CudVo(dao.insStart(insS)>0?"출근 성공":"출근실패",
				dao.getCalList());
	}
	
	public CudVo uptEnd(Cal uptE) {
//		if (dao.checkDuplicate2(uptE) > 0) {
//	        return new CudVo("이미 해당 날짜에 퇴근 기록이 있습니다.", dao.getCalList());
//	    }
//		if ("출근 중".equals(uptE.getContent())) {
//			uptE.setContent("퇴근");
//	    }
//		if (dao.checkDuplicate(uptE) > 0) {
//	        return new CudVo("이미 해당 날짜에 출결 기록이 있습니다.", dao.getCalList());
//	    } 
		int check = dao.checkBeforeUptEnd(uptE.getEname());
	    
	    if (check > 0) { // '출근 중' 상태일 경우에만 퇴근 처리
	        return new CudVo(dao.uptEnd(uptE) > 0 ? "퇴근 성공" : "퇴근 실패",
	                         dao.getCalList());
	    } else {
	        return new CudVo("이미 출결 기록이 있습니다", dao.getCalList());
	    }
	}
	
	public CudVo uptUsed(Att upt) {
		return new CudVo(dao.uptUsed(upt)>0?"변경 성공":"연차 개수 부족",
				dao.getCalList());
	}
	
	public CudVo insHour1(Cal insH) {
		return new CudVo(dao.insHour1(insH)>0?"시차 1개 등록성공":"시차등록실패",
				dao.getCalList());
	}
	
	public CudVo uptUsedH(Att uptU1) {
		return new CudVo(dao.uptUsedH(uptU1)>0?"시차 변경 성공":"시차 개수 부족",
				dao.getCalList());
	}
	
	
	public CudVo inswfh(Cal insW) {
//		System.out.println("중복 개수: " + duplicateCount);
		
    if (dao.checkWorkRecord2(insW) > 0) {
        return new CudVo("출근 기록이 있는 날짜에는 재택을 신청할 수 없습니다.", dao.getCalList());
    }
    if (dao.checkDuplicateWfh(insW) > 0) {
        return new CudVo("재택 기록이 있는 날짜에는 재택을 신청할 수 없습니다.", dao.getCalList());
    }
		    
		if (dao.checkDuplicate3(insW) > 1) {
	        return new CudVo("재택 신청 횟수 초과하였습니다.", dao.getCalList());
	    }
		if ("".equals(insW.getContent())) {
			insW.setContent("재택");
	    }
		return new CudVo(dao.inswfh(insW)>0?"재택 등록성공":"재택 등록실패",
				dao.getCalList());
	}
	
	
	public CudVo uptUsedW(Att uptW) {
		return new CudVo(dao.uptUsedW(uptW)>0?"재택 개수 변경 성공":"재택 개수 부족",
				dao.getCalList());
	}
	
	
	
}