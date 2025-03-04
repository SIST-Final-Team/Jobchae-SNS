package com.spring.app.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;


@Configuration
// WebSocket을 사용하기 위한 설정
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {

    // 클라이언트에서 웹소켓을 연결할 때 사용할 주소를 설정
    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        // /ws로 접속하면 SockJS를 통해 웹소켓을 사용하도록 설정
        registry.addEndpoint("/ws").withSockJS();
    }

    // 메시지 브로커가 사용할 주소를 설정
    // 메시지 브로커란 서버와 클라이언트 사이의 메시지를 전달하는 역할을 한다.
    @Override
    public void configureMessageBroker(MessageBrokerRegistry registry) {
        // /topic, /queue로 시작하는 주소로 메시지를 보내면 메시지 브로커가 처리하도록 설정
        // /topic은 구독자에게 메시지를 보내는 주소, /queue는 특정 사용자에게 메시지를 보내는 주소
        registry.enableSimpleBroker("/topic", "/queue");

        // /app으로 시작하는 주소로 메시지를 보내면 컨트롤러가 처리하도록 설정
        registry.setApplicationDestinationPrefixes("/app");

        // /user로 시작하는 주소로 메시지를 보내면 특정 사용자에게 메시지를 보내도록 설정
        registry.setUserDestinationPrefix("/user");
    }
}
