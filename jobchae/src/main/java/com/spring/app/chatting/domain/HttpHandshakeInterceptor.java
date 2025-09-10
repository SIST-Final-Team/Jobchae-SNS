package com.spring.app.chatting.domain;

import com.spring.app.member.domain.MemberVO;
import jakarta.servlet.http.HttpSession;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.HandshakeInterceptor;

import java.util.Map;

public class HttpHandshakeInterceptor implements HandshakeInterceptor {
    
    //웹페이지에 로그인한 사용자만 웹소캣을 연결할 수 있도록 중간에 인터셉트 하는 메소드
    @Override
    public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response,
                                   WebSocketHandler wsHandler, Map<String, Object> attributes) throws Exception {
        if (request instanceof ServletServerHttpRequest) {
            ServletServerHttpRequest servletRequest = (ServletServerHttpRequest) request;
            HttpSession httpSession = servletRequest.getServletRequest().getSession();
            
            MemberVO loginuser = (MemberVO) httpSession.getAttribute("loginuser");
            
            if (loginuser != null) {
                // WebSocket 세션 속성(attributes)에 사용자 ID 저장
                attributes.put("member_id", loginuser.getMember_id());
                return true; // 핸드셰이크 승인
            }
        }
        return false; // 로그인하지 않은 사용자는 연결 거부
    }//end of public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler, Map<String, Object> attributes) throws Exception {}...}...
    
    
    
    @Override
    public void afterHandshake(ServerHttpRequest request, ServerHttpResponse response,
                               WebSocketHandler wsHandler, Exception exception) {
        
    
    }
    
}//end of class...
