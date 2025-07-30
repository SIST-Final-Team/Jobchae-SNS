package com.spring.app.chatting.domain;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import lombok.Builder;
import lombok.Data;

@Document(collection = "chat_room")
@Builder
@Data
public class ChatRoom {
	
	@Id
	private String roomId; // 채팅방 식별자
	
	private List<PartiMember> partiMember; // 채팅방 참여자 식별자
	
	private String roomName;
	
	private LocalDateTime createdDate; // 채팅방 생성일자 
	
	
	// 새로운 방의 아이디를 랜덤하게 부여한다.
	public ChatRoom create_chatRoom(String room_name) {
		ChatRoom chatRoom = new ChatRoom(roomId, partiMember, room_name, createdDate);
		chatRoom.roomId = UUID.randomUUID().toString();
		chatRoom.roomName = room_name;
		chatRoom.createdDate = LocalDateTime.now(); // 생성 시간 기록
		return chatRoom;
	}
	
	
}
