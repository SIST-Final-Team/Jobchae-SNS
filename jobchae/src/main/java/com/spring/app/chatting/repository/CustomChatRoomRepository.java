package com.spring.app.chatting.repository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.aggregation.Aggregation;
import org.springframework.data.mongodb.core.aggregation.AggregationResults;
import org.springframework.data.mongodb.core.aggregation.ConvertOperators;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.stereotype.Repository;

import com.spring.app.chatting.domain.ChatRoomDTO;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class CustomChatRoomRepository {

	
	@Autowired
	MongoOperations mongo; // 몽고 디비를 직접 커스텀 하려한다.

	// 현재 로그인 사용자가 참여하고 있는 채팅방 목록, 최신 채팅내역 조회
	public List<ChatRoomDTO> findAllWithLatestChatByMemberId(String member_id) {

		Aggregation agg = Aggregation.newAggregation(
			// [시작 & 필터링] 'chat_room'에서 시작하여 사용자가 참여한 방만 필터링
			Aggregation.match(Criteria.where("partiMemberList").elemMatch(Criteria.where("member_id").is(member_id))),

			// [조인] chat_room의 _id와 chat_messages의 roomId를 기준으로 LEFT JOIN 수행
			//    lookup을 위해 chat_room의 _id (ObjectId)를 String으로 변환한 필드 추가
			Aggregation.addFields()
					.addField("roomIdStr")
					.withValue(ConvertOperators.ToString.toString("$_id")).build(),
			Aggregation.lookup("chat_messages", "roomIdStr", "roomId", "all_messages"),

			// [배열 해체] 메시지 배열을 풀어냄. 메시지 없는 방도 유지 (핵심!)
			Aggregation.unwind("all_messages", true), // preserveNullAndEmptyArrays: true

			// [정렬] 메시지가 있는 경우 최신순으로 정렬. 없는 경우는 null 상태로 유지됨.
			Aggregation.sort(Sort.by(Sort.Direction.DESC, "all_messages.sendDate")),

			// [재그룹화] 다시 채팅방 ID 기준으로 그룹화하여 최신 메시지 1개만 남김
			Aggregation.group("_id") // chat_room의 고유 ID로 그룹화
					// 채팅방 정보는 그룹의 첫 번째 문서에서 가져옴
					.first("$$ROOT").as("chatRoom")
					// 최신 메시지 정보도 그룹의 첫 번째 문서에서 가져옴
					.first("all_messages").as("latestChat"),

			// [최종 정리] DTO에 매핑하기 좋은 구조로 필드 정리
			Aggregation.project()
					.and("chatRoom._id").as("roomId")
					.and("chatRoom").as("chatRoom") // 채팅방 전체 정보
					.and("latestChat.message").as("latestChat.message")
					.and("latestChat.sendDate").as("latestChat.sendDate")
					.and("latestChat.senderId").as("latestChat.senderId")
					.and("latestChat.senderName").as("latestChat.senderName"),

			// [정렬] 최종 채팅방 목록 전체를 최신 메시지 시간순으로 정렬
			Aggregation.sort(Sort.by(Sort.Direction.DESC, "latestChat.sendDate"))
		);

		// Aggregation 실행 (시작 컬렉션이 "chat_room"으로 변경됨)
		AggregationResults<ChatRoomDTO> result = mongo.aggregate(agg, "chat_room", ChatRoomDTO.class);
		
		return result.getMappedResults();
		
	}//end of public List<ChatRoomDTO> findAllWithLatestChatByMemberId(String member_id) {}...
	
	
	
	
	
	
	
}//end of class...
