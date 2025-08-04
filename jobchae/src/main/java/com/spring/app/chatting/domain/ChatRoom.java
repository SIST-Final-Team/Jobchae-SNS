package com.spring.app.chatting.domain;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

import lombok.*;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "chat_room")
@Builder
@Data
public class ChatRoom {
	
	@Id
	private String roomId; // 채팅방 식별자
	
	private List<PartiMember> partiMemberList; // 채팅방 참여자 식별자
	
	private String roomName;
	
	private LocalDateTime createdDate; // 채팅방 생성일자 
	
	
	// 새로운 방의 아이디를 랜덤하게 부여한다.
	public static ChatRoom create_chatRoom(String room_name, List<PartiMember> partiMemberList) {
		return ChatRoom.builder()
				.partiMemberList(partiMemberList)
				.roomName(room_name)
				.createdDate(LocalDateTime.now())
				.build();
	}
	
	
}
