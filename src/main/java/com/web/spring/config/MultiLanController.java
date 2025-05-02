package com.web.spring.config;

import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.LocaleResolver;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class MultiLanController{

	// 컨테이너에서 선언한 지역 언어선택 객체 호출
	@Autowired(required = false)
	private LocaleResolver localeResolver;
	
	// http://localhost:1111/multilang2
	@GetMapping("multilang2")
	public String multilang(@RequestParam(value="lang",defaultValue="ko")String lang,
				HttpServletRequest request,
				HttpServletResponse response){
		System.out.println("언어 선택:"+lang);
		
		Locale locale = new Locale(lang);
		localeResolver.setLocale(request, response, locale);
		return "WEB-INF\\erp\\att\\login2.jsp";
	}
	
}
