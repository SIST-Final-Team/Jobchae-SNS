package com.spring.app.chatting.domain;

import lombok.*;
import org.springframework.web.util.HtmlUtils;

import java.util.List;

@Getter
@AllArgsConstructor
@Setter
@Builder
@NoArgsConstructor
public class ChatMessageDTO {
    
    // 채팅 메세지 리스트(제일 최신 메세지부터 20개씩)
    // 또는 안읽은 메세지 바로 전 20개 메세지와 안읽은 메세지 뒤로 온 모든 메세지
    private List<ChatMessage> chatMessageList;
    
    private boolean existUnReadChat; // 불러온 채팅방에 안읽은 채팅이 있는 경우 true, 없으면 false
    
    private int oldestUnreadMessageIndex; // 안읽은 메세지들 중에서 제일 오래된 메세지 인덱스
    
    // 스크립트 공격을 걸러준다음 채팅방에 보낼 때 사용하는 함수
    public static ChatMessageDTO safeChatMessageDTO(ChatMessageDTO dto) {
        
        if (dto == null || dto.getChatMessageList() == null) {
            return dto; // 원본이 null이거나 리스트가 없으면 그대로 반환
        }
        
        List<ChatMessage> safeChatMessageList = dto.getChatMessageList().stream()
                .map(chatMessage -> {
                    // TALK 타입인 메세지만 빌터패턴을 이용해서 이스케이프 처리
                    if (chatMessage.getChatType() == ChatType.TALK) {
                        return ChatMessage.safeMessage(chatMessage);
                    } else {
                        return chatMessage;
                    }//end of if (chatMessage.getChatType() == ChatType.TALK) {}...
                }).toList();
        
        return ChatMessageDTO.builder()
                .chatMessageList(safeChatMessageList)
                .existUnReadChat(dto.isExistUnReadChat())
                .oldestUnreadMessageIndex(dto.getOldestUnreadMessageIndex())
                .build();
        
        // ChatMessage.safeMessage(chatMessage); 의 빌더패턴 내용이다.
        // HtmlUtils.htmlEscape가 알아서 모든 위험한 문자를 안전한 HTML 엔티티로 변환
        // <  ->  &lt;
        // >  ->  &gt;
        // &  ->  &amp;
        // "  ->  &quot;
        // '  ->  &#39;
    }//end of public static ChatMessageDTO safeChatMessageDTO(ChatMessageDTO dto) {}...
    
    
    // ChatMessageDTO 타입의 객체를 만들어주는 빌더메소드
    public static ChatMessageDTO createChatMessageDTO(List<ChatMessage> findMessageList) {
        return ChatMessageDTO.builder()
                .chatMessageList(findMessageList)
                .existUnReadChat(false)
                .oldestUnreadMessageIndex(-1) // 제일 안읽은 메세지가 없으니 인덱스는 -1로 설정해서 고유하게 만듬
                .build();
    }
    
    
}//end of class...
