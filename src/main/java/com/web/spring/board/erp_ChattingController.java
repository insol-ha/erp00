package com.web.spring.board;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class erp_ChattingController {
	
	@Value("${erp_socketServer}")
	private String erp_socketServer;
	
	// http://localhost:1111/chatting
	@GetMapping("chatting")
	public String chatting(Model d) {
		d.addAttribute("socketServer", erp_socketServer);
		
		return "WEB-INF\\erp\\board\\chatting.jsp";
	}

}
