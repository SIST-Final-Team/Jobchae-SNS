package com.spring.app.chatting.service;

import java.util.List;

import com.spring.app.member.domain.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.chatting.domain.ChatMessage;
import com.spring.app.chatting.domain.ChatRoom;
import com.spring.app.chatting.domain.ChatRoomDTO;
import com.spring.app.chatting.repository.ChatRepository;
import com.spring.app.chatting.repository.ChatRoomRepository;
import com.spring.app.chatting.repository.CustomChatRoomRepository;

@Service
public class ChatService_imple implements ChatService{

	@Autowired
	private ChatRepository chatRepository; // 채팅 레포지토리

	@Autowired
	private ChatRoomRepository chatRoomRepository; // 채팅방 레포지토리

	@Autowired
	private CustomChatRoomRepository customChatRoomRepository; // 채팅방 커스텀 레포지토리
	
	
	
	// 현재 로그인한 유저의 모든 채팅방 불러오기 메소드
	@Override
	public List<ChatRoomDTO> getChatRoomList(String member_id) {
		
		// 현재 로그인 사용자가 참여하고 있는 채팅방 목록, 최신 채팅내역 조회
		List<ChatRoomDTO> chatRoomRespDTOList = customChatRoomRepository.findAllWithLatestChatByMemberId(member_id);

		// 참여하고 있는 채팅방이 존재하지 않는 경우
		if (chatRoomRespDTOList.isEmpty()) {
			return chatRoomRespDTOList;
		}

		return chatRoomRespDTOList;
		
	}//end of public List<ChatRoomRespDTO> getChatRoomList(String member_id) {}... 


	
	
	// 채팅 메세지 저장
	@Override
	public ChatMessage saveChat(ChatMessage chat) {
		
//		ChatRoom chatRoom = chatRoomRepository.findChatRoomByRoomId(chat.getRoomId());
//		int readCount = chatRoom.getParticipants().size();
//
//		// 읽지 않은 인원 수가 정장적으로 나오지 않는경우 예외처리
//		if (readCount < 1) {
//			log.error("[ERROR] : readCount 값 오류 : {}", readCount);
//			throw new BusinessException(ExceptionCode.CREATE_CHATROOM_FAILD);
//		}
//
//		chat.updateUnReadCount(readCount - 1);
		
		return chatRepository.save(chat);
		
	}//end of public ChatMessage saveChat(ChatMessage chat) {}...

	
	
	// 채팅방의 채팅 내역 조회
	@Override
	public List<ChatMessage> loadChatHistory(String roomId) {
		return chatRepository.findChatByRoomId(roomId);
	}
	
	
	
	// 채팅방 개설 메소드
	@Override
	public ChatRoom createChatRoom(MemberVO loginuser, List<String> folow_id_List, List<String> folow_name_List) {
		
		// 파티멤버타입으로 받자
		
		
		return null;
		
	}//end of public ChatRoom createChatRoom(String loginuser_member_id, String loginuserFolowId) {}...
	
	
}//end of class...











