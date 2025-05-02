package com.web.spring.performance;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.spring.performance.vo.Eachperfor;
import com.web.spring.performance.vo.Perform;

@Service
public class Pservice {
	@Autowired(required=false)
	private Pdao dao;
	
	public List<Perform> getPerform(){
		return dao.getPerform();
	}
	
	
	
	public List<Eachperfor> geteachperfor(Eachperfor sch){
		if(sch.getDeptno()==0) sch.setDeptno(10);
		return dao.geteachperfor(sch);
	}
}
