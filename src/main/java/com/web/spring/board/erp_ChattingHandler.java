package com.web.spring.board;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

// 컨테이너에서 chatHandler라는 이름으로 등록하는데 이는 front단에서 chat로 호출가능하다.
// ws:localhost:3030/chat  js로 호출시, chatHandler backend 연동 WebSocketConfig에서 처리 해준다.
@Component("erp_chatHandler")
public class erp_ChattingHandler extends TextWebSocketHandler{
	// 접속한 클라이언트 할당..(소켓아이디, 소켓세션으로 )
	private Map<String, WebSocketSession> users = new ConcurrentHashMap();
	
	// 접속시 처리되는 메서드
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// TODO Auto-generated method stub
		//super.afterConnectionEstablished(session);
		System.out.println("[소켓 서버단]접속되었습니다.!!"+session.getId());
		// 접속했을 때, 하나씩 할당 처리..
		users.put(session.getId(), session);
	}
	// 메시지를 전송시 처리
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// 클라이언트로 부터 전달할 메시지
		System.out.println(session.getId()+":"+message.getPayload());
		
		// 접속한 모든 클라이언트에 전달(메시지전달)
		for(WebSocketSession ws: users.values()) {
			ws.sendMessage(message);
		}
	}
	
	// 접속을 종료했을 때..
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
			
		users.remove(session.getId());
		System.out.println("#접속 종료! 해당 session id로 제외 처리#");
	}
	
	// 채팅시 에러 발생시..
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		System.out.println(session.getId()+" 예외 발생:"+exception.getMessage());
	}


	

}
