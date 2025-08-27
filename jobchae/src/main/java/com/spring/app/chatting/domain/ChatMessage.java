package com.spring.app.chatting.domain;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;

import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


@Document(collection = "chat_messages")
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Data
public class ChatMessage {
	
	@Id
	private String id; // 채팅 식별자

//	@Field("sender_id")
	private String senderId; // 작성자 식별자	

	private String senderName; // 작성자 명

	private String roomId; // 채팅방 식별자

	private String message; // 채팅 내용

	private List<String> readMembers; // 채팅 메시지 읽은 인원 수

	private int unreadCount; // 채팅메시지 읽지 않은 인원 수

	private LocalDateTime sendDate; // 작성일자
    
    // private Map<String, Date> membersLastReadTime; // 키 값은 로그인한 아이디, 벨류는 마지막으로 읽은 시간

	@Enumerated(EnumType.STRING)
	@Builder.Default
	private ChatType chatType = ChatType.TALK; 	// 채팅 타입
								// ENTER: 입장 메시지
								// TALK: 사용자 메시지
								// LEAVE: 퇴장 메시지

	// 채팅방 식별자 변경 메소드
	public void updateRoomId(String roomId) {
		this.roomId = roomId;
	}

	// 채팅을 읽지 않은 인원 수 메소드
	public void updateUnReadCount(int readCount) {
		this.unreadCount = readCount;
	}

	// 채팅을 읽지 않은 인원 수 메소드
	public void updateReadMembers(String member_id) {
		this.readMembers = List.of(member_id);
	}

	// 채팅 작성 시간 설정 메소드
	public void updateSendDate(LocalDateTime now) {this.sendDate = now;}
    
    
    // 초대 받아서 입장하면 시스템이 보내주는 메시지
    public static ChatMessage enterMessage(String roomId, List<String> invitedMemberNameList) {
        return ChatMessage.builder()
                .senderId("system")
                .senderName("System")
                .roomId(roomId)
                .message(String.join(",", invitedMemberNameList)+" 님이 입장하셨습니다.")
                .sendDate(LocalDateTime.now())
                .chatType(ChatType.ENTER)
                .build();
    }
	
	// 퇴장하면 시스템이 보내주는 메시지
	public static ChatMessage leaveMessage(String roomId ,String member_name) {
		return ChatMessage.builder()
				.senderId("system")
				.senderName("System")
				.roomId(roomId)
				.message(member_name+" 님이 퇴장하셨습니다.")
				.sendDate(LocalDateTime.now())
				.chatType(ChatType.LEAVE)
				.build();
	}
    
    // 로그아웃하면 시스템이 보내주는 메시지
    public static ChatMessage logoutMessage(String member_id) {
        return ChatMessage.builder()
                .senderId("system")
                .senderName("System")
                .chatType(ChatType.LOGOUT) // 로그아웃 타입
                .build();
    }
	
	
	
	
}//end of class...
