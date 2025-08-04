package com.spring.app.chatting.service;

import java.util.ArrayList;
import java.util.List;

import com.spring.app.chatting.domain.PartiMember;
import com.spring.app.member.domain.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.chatting.domain.ChatMessage;
import com.spring.app.chatting.domain.ChatRoom;
import com.spring.app.chatting.domain.ChatRoomDTO;
import com.spring.app.chatting.repository.ChatRepository;
import com.spring.app.chatting.repository.ChatRoomRepository;
import com.spring.app.chatting.repository.CustomChatRoomRepository;

import static com.spring.app.chatting.domain.PartiMember.createPartiMember;


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
	public ChatRoom createChatRoom(MemberVO loginuser, List<String> follow_id_List, List<String> follow_name_List) {
		
		// 받아온 리스트를 파티멤버타입으로 만들어준다.
		List<PartiMember> partiMemberList = new ArrayList<>();
		
		for (int i = 0; i < follow_id_List.size(); i++) {
			partiMemberList.add(createPartiMember(follow_id_List.get(i), follow_name_List.get(i)));
		}
		// 로그인 유저 정보도 넣어준다.
		partiMemberList.add(createPartiMember(loginuser.getMember_id(), loginuser.getMember_name()));
		
		// 방의 기본이름은 유저의 이름과 나머지 참여자의 이름을 조합한다.
		String room_name = String.join(",", follow_name_List); // 이름 리스트를 스트링으로 변환
		
		ChatRoom chatroom = ChatRoom.create_chatRoom(room_name ,partiMemberList);
		
		return chatRoomRepository.save(chatroom); // 채팅방 저장
		
	}//end of public ChatRoom createChatRoom(String loginuser_member_id, String loginuserFolowId) {}...
	
	
}//end of class...











