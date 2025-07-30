package com.spring.app.chatting.service;

import java.util.List;

import com.spring.app.chatting.domain.ChatMessage;
import com.spring.app.chatting.domain.ChatRoom;
import com.spring.app.chatting.domain.ChatRoomDTO;
import com.spring.app.member.domain.MemberVO;

public interface ChatService {

	// 현재 로그인한 유저의 모든 채팅방 불러오기 메소드
	List<ChatRoomDTO> getChatRoomList(String member_id);

	// 채팅 메세지 저장
	ChatMessage saveChat(ChatMessage chat);

	// 채팅방의 채팅 내역 조회
	List<ChatMessage> loadChatHistory(String roomId);
	
	// 채팅방 개설 메소드
	ChatRoom createChatRoom(MemberVO loginuser, List<String> folow_id_List, List<String> folow_name_List);
}
