package com.spring.app.chatting.domain;

import java.time.Instant;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import java.util.stream.Stream;

import lombok.*;
import org.bson.types.ObjectId;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "chat_room")
@Builder
@Data
public class ChatRoom {
	
	@Id
	private String roomId; // 채팅방 식별자
    // private ObjectId roomId; // 채팅방 식별자
	
	private List<PartiMember> partiMemberList; // 채팅방 참여자 식별자
	
	private String roomName;
	
	private Instant createdDate; // 채팅방 생성일자
	
	
	// 새로운 방의 아이디를 랜덤하게 부여한다.
	public static ChatRoom create_chatRoom(String room_name, List<PartiMember> partiMemberList) {
		return ChatRoom.builder()
				.partiMemberList(partiMemberList)
				.roomName(room_name)
				.createdDate(Instant.now())
				.build();
	}
    
    // 채팅방에 새로운 사람을 추가하려고 만든 메소드
    public static List<PartiMember> addNewPartiMember(List<String> invitedMemberIdList,
                                                         List<String> invitedMemberNameList) {
        // 두 리스트의 크기가 다르면 짝을 지을 수 없으므로 예외 처리를 해주는 것이 안전
        if (invitedMemberIdList.size() != invitedMemberNameList.size()) {
            throw new IllegalArgumentException("ID 리스트와 이름 리스트의 크기가 일치하지 않습니다.");
        }
        // List<PartiMember> resultList =  new ArrayList<PartiMember>();
        return IntStream.range(0, invitedMemberIdList.size()) // 1. 0부터 리스트 크기 - 1까지의 숫자 스트림 생성 (인덱스 스트림)
                .mapToObj(i -> PartiMember.createPartiMember( // 2. 각 인덱스를 사용해 객체로 매핑 (mapToObj 사용)
                        invitedMemberIdList.get(i),            // i번째 ID
                        invitedMemberNameList.get(i)           // i번째 이름
                ))
                .toList(); // 3. 생성된 PartiMember 객체들을 새로운 리스트로 수집
    }
	
	
}
