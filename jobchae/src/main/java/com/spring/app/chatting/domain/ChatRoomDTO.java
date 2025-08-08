package com.spring.app.chatting.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@AllArgsConstructor
@Setter
public class ChatRoomDTO { // 채팅방 목록을 불러올 때 편하게 불러오는 용도의 DTO

	private ChatRoom chatRoom; // 채팅방 정보들
	
	private ChatMessage latestChat; // 채팅방 마지막 메세지 정보

	private List<String> memberProfileList; // 참여자 프로필 목록
	
}//end of class...
