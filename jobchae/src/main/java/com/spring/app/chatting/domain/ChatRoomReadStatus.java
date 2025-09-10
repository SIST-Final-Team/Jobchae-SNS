package com.spring.app.chatting.domain;


import jakarta.persistence.Id;
import lombok.*;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.Instant;
import java.time.LocalDateTime;

@Document(collection = "chat_room_readStatus")
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class ChatRoomReadStatus {
    
    @Id
    private String id; // 아이디
    
    private String roomId; // 방번호
    
    private String userId; // 유저아이디
    
    private Instant lastReadTimestamp; // 마지막으로 채팅방에서 메세지를 읽은 시간
    
    
    
    
    
}//end of class...
