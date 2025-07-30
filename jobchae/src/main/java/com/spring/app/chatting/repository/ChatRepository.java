package com.spring.app.chatting.repository;

import java.util.List;

import org.springframework.data.mongodb.repository.MongoRepository;

import com.spring.app.chatting.domain.ChatMessage;

public interface ChatRepository extends MongoRepository<ChatMessage, String> {

	// 채팅방의 채팅 내역 조회
	List<ChatMessage> findChatByRoomId(String roomId);

//	// 채팅 내역 조회
//	List<Chat> findChatByRoomId(String roomId);
//
//	Chat findTopByRoomIdOrderBySendDateDesc(String roomId);
	
	
	
	

}
