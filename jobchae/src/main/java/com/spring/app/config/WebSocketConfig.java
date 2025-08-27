package com.spring.app.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.scheduling.TaskScheduler;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;
import org.springframework.web.socket.server.support.DefaultHandshakeHandler;

import java.security.Principal;
import java.util.List;
import java.util.Map;


@Configuration
// WebSocket을 사용하기 위한 설정
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {

    // 클라이언트에서 웹소켓을 연결할 때 사용할 주소를 설정
    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        // /ws로 접속하면 SockJS를 통해 웹소켓을 사용하도록 설정
        registry.addEndpoint("/ws").setHandshakeHandler(new DefaultHandshakeHandler(){
            //TODO: 이 코드는 인증 관련 코드인데 원리에 대해 좀 더 공부해야 할 듯
            @Override
            protected Principal determineUser(ServerHttpRequest request
                                              , WebSocketHandler wsHandler
                                              , Map<String, Object> attributes) {
                // URL 파라미터에서 user-id 가져오기
                String userId = request.getURI().getQuery();
                System.out.println("determineUser: " + userId);
                if(userId != null && userId.contains("user-id=")) {
                    userId = userId.split("user-id=")[1].split("&")[0];
                    System.out.println("determineUser: " + userId);
                    return new StompPrincipal(userId);
                }
                return null;
            }
        }).withSockJS();
    }

    // 메시지 브로커가 사용할 주소를 설정
    // 메시지 브로커란 서버와 클라이언트 사이의 메시지를 전달하는 역할을 한다.
    @Override
    public void configureMessageBroker(MessageBrokerRegistry registry) {
        // /topic, /queue로 시작하는 주소로 메시지를 보내면 메시지 브로커가 처리하도록 설정
        // /topic은 구독자에게 메시지를 보내는 주소, /queue는 특정 사용자에게 메시지를 보내는 주소
        // /room는 해당 주소를 구독하고 있는 클라이언트들에게 메시지 전달(채팅설정)
        registry.enableSimpleBroker("/topic", "/queue", "/room", "/user")
                .setHeartbeatValue(new long[]{30000, 30000})
                .setTaskScheduler(heartBeatScheduler());

        // /app으로 시작하는 주소로 메시지를 보내면 컨트롤러가 처리하도록 설정
        registry.setApplicationDestinationPrefixes("/app", "/send");

        // /user로 시작하는 주소로 메시지를 보내면 특정 사용자에게 메시지를 보내도록 설정
        registry.setUserDestinationPrefix("/user");
    }
    
    // <<< 하트비트를 위한 TaskScheduler 빈 등록 >>>
    @Bean
    public TaskScheduler heartBeatScheduler() {
        ThreadPoolTaskScheduler scheduler = new ThreadPoolTaskScheduler();
        // 스케줄러의 스레드 이름을 지정합니다. (선택 사항)
        scheduler.setThreadNamePrefix("websocket-heartbeat-scheduler-");
        return scheduler;
    }

    public static class StompPrincipal implements Principal {
        private final String name;

        public StompPrincipal(String name) {
            this.name = name;
        }

        @Override
        public String getName() {
            return name;
        }
    }
}
