package com.web.spring.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

import com.web.spring.chat.ChatHandler;

@Configuration
@EnableWebSocket
public class WebSocketConfig implements WebSocketConfigurer{
	private final ChatHandler chatHandler;
	public WebSocketConfig(ChatHandler chatHandler) {
		this.chatHandler = chatHandler;
	}
	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		// backend(A10_ChattingHandler)와 /chat 으로 front에서 호출시, 연동된다.
		registry.addHandler(chatHandler, "/chat").setAllowedOrigins("*");
		
	}
}
