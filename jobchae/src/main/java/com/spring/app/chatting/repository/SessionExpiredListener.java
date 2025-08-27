package com.spring.app.chatting.repository;

import com.spring.app.chatting.domain.ChatMessage;
import com.spring.app.member.domain.MemberVO;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Component;

@Component
public class SessionExpiredListener implements HttpSessionListener {
    
    private final SimpMessagingTemplate messagingTemplate;
    
    public SessionExpiredListener(SimpMessagingTemplate messagingTemplate) {
        this.messagingTemplate = messagingTemplate;
    }
    
    // HTTP 세션이 만료될 때 Spring이 이 메소드를 자동으로 호출
    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        HttpSession session = se.getSession();
        MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
        
        if (loginuser != null) {
            String member_id = loginuser.getMember_id();
            
            // 채팅메세지 형식으로 보내자
            ChatMessage logoutMessage = ChatMessage.logoutMessage(member_id);
            // 프론트로 신호를 보내준다.
            messagingTemplate.convertAndSendToUser(member_id, "/errors", logoutMessage);
        }
    }
    
    
    
}//end of class...
