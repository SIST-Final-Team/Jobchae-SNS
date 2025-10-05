package com.spring.app.chatting.service;

import java.time.Instant;
import java.util.List;

import com.spring.app.chatting.domain.ChatMessage;
import com.spring.app.chatting.domain.ChatMessageDTO;
import com.spring.app.chatting.domain.ChatRoom;
import com.spring.app.chatting.domain.ChatRoomDTO;
import com.spring.app.member.domain.MemberVO;

public interface ChatService {

	// 현재 로그인한 유저의 모든 채팅방 불러오기 메소드
	List<ChatRoomDTO> getChatRoomList(String member_id);

	// 채팅 메세지 저장
	ChatMessage saveChat(ChatMessage chat);

	// 채팅방의 채팅 내역 조회
	ChatMessageDTO loadChatHistory(String roomId, String member_id, String loadChatCount);
	
	// 채팅방 개설 메소드
	ChatRoom createChatRoom(MemberVO loginuser, List<String> folow_id_List, List<String> folow_name_List);
	
	// 채팅방 나가기
	void leaveChatRoom(String roomId, String member_id, String member_name);
    
    // 채팅방 들어가기
    void enterChatRoom(String member_id ,String roomId, List<String> invitedMemberIdLsit);
    
    // 지금 로그인한 사용자가 채팅방에 들어오거나, 새로운 채팅을 받거나, 채팅방을 떠날 때 마지막으로 읽은 채팅방 시간을 기록
    void updateReadTimesChatRoom(String roomId, String memberId, Instant readTime);
    
}
