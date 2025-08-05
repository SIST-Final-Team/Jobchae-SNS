package com.spring.app.chatting.repository;

import org.springframework.data.mongodb.repository.MongoRepository;

import com.spring.app.chatting.domain.ChatRoom;


public interface ChatRoomRepository extends MongoRepository<ChatRoom, String> {

	
//	// 사용자가 속한 모든 채팅방 내역 조회
//	@Query(value = "{ 'participants.memberNo': { $all: [?0] } }", sort = "{ 'productNo': 1 }")
//	List<ChatRoom> findAllByMemberNoOrderByProductNoAsc(String memberNo);

}



