package com.web.spring.AttMng;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.spring.Final.vo.Att;



@Service
public class ChartService {

	@Autowired(required = false)
	private ChartDao dao;

	public List<Att> getChartList(){
		return dao.getChartList();
		
	}
	
	
}

