package com.spring.app.chatting.domain;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor // 기본 생성자를 추가해주는 Lombok 어노테이션, 이게 있어야 바로 new 할 수 있어서 값을 받을 수 있다!
public class ReadStatusUpdateRequest {
    
    private String lastReadTimestamp; // 채팅방에서 마지막으로 메세지를 읽은 시간(받을 때 스트링이다.)
    
    
}//end of class...
