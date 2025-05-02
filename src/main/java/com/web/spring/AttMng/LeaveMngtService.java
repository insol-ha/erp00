package com.web.spring.AttMng;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.web.spring.Final.vo.Att;


@Service
public class LeaveMngtService {

	@Autowired(required = false)
	private LeaveMngtDao dao;
	
	public List<Att> getAttList(){
		return dao.getAttList();
	}
	
	
	public String uptUsedpto(){
		return dao.uptUsedpto()>0?"초기화 성공":"초기화 실패";
	}
	
	
	@Scheduled(cron = "0 0 0 1 1 ?")
	public void executeTask() {
		String reset = dao.uptUsedpto()>0?"1월 1일 초기화 성공":"1월 1일 초기화 실패";
		System.out.println(reset);
	}

	
	
	
}
