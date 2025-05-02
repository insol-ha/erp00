package com.web.spring.AttMng;

import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.spring.Final.vo.Cal;
import com.web.spring.Final.vo.CudVo;


@Service
public class CSService {

	@Autowired(required = false)
	private CSDao dao;
	
	
	public List<Cal> CalList(){
		return dao.CalList();
	} // 검색전 전체 출결 내역 출력
	

	public List<Cal> CalList2(Cal sch) {
	    if (sch.getEname() == null) sch.setEname("");
	    if (sch.getContent() == null) sch.setContent("");

	    // 현재 연도의 1월 1일과 12월 31일을 기본값으로 설정
	    Calendar calendar = Calendar.getInstance();
	    if (sch.getStart() == null) {
	        calendar.set(Calendar.MONTH, Calendar.JANUARY);
	        calendar.set(Calendar.DAY_OF_MONTH, 1);
	        sch.setStart(calendar.getTime());
	    }

	    if (sch.getEnd() == null) {
	        calendar.set(Calendar.MONTH, Calendar.DECEMBER);
	        calendar.set(Calendar.DAY_OF_MONTH, 31);
	        sch.setEnd(calendar.getTime());
	    }
	    
	    sch.setEname("%" + sch.getEname() + "%");
	    sch.setContent("%" + sch.getContent() + "%");
	    return dao.CalList2(sch);
	}

	
	public Cal empnoByList(int id) {
		
		
		return dao.empnoByList(id);
	}
	
	public CudVo calUpdate(Cal calupt) {
		return new CudVo(dao.calUpdate(calupt)>0?"수정성공":"수정실패",
				dao.CalList());
	}
	
	public CudVo calDelete(Cal del) {
		return new CudVo(dao.calDelete(del)>0?"삭제성공":"삭제실패",
				dao.CalList());
	}
	
	
	
	
}
