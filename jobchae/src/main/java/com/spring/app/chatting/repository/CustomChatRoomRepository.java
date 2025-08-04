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
				// 최신 채팅으로 정렬하고
				Aggregation.sort(Sort.by(Sort.Direction.DESC, "sendDate")),
				
				// 채팅 메시지를 roomId(String) 기준으로 그룹화하고, 최신 메시지 정보 추출
		        Aggregation.group("roomId")
		            .max("sendDate").as("sendDate")
		            .first("message").as("message")
		            .first("senderId").as("senderId")
		            .first("senderName").as("senderName"),
		            
		        // 채팅방 식별자와 join을 위한 타입 맞추기 ( object id )
			    Aggregation.addFields()
			    	.addField("roomIdObj")
			        .withValue(ConvertOperators.ToObjectId.toObjectId(
			        		   ConvertOperators.ToString.toString("$_id")  // String 변환 후 ObjectId 변환 시도
			        		)
			    ).build(),
			        
			    // 채팅방 컬렉션과 조인
			    Aggregation.lookup("chat_room", "roomIdObj", "_id", "chatRoom_arr"),
			    
			    // 조인 결과 필터링 (채팅방 정보가 존재하는 경우만)
		        Aggregation.match(Criteria.where("chatRoom_arr").ne(null)),

		        // `chatRoom` 필드는 배열이므로 단일 문서로 변환
		        Aggregation.unwind("chatRoom_arr"),

		        // 사용자가 참여한 채팅방만 필터링
		        Aggregation.match(Criteria.where("chatRoom_arr.participants").elemMatch(Criteria.where("member_id").is(member_id))),

		        // 필요한 필드만 유지하여 최종 반환 데이터 구조 정의
		        Aggregation.project()
		            .and("_id").as("roomId")  // roomId 매핑
		            .andInclude("message", "sendDate", "senderId", "senderName")  // 최신 메시지 정보
		            .and("chatRoom").as("chatRoom") // 채팅방 정보
		            .and("message").as("latestChat_message")
		            .and("sendDate").as("latestChat_sendDate")
		            .and("senderId").as("latestChat_senderId")
		            .and("senderName").as("latestChat_senderName")
		);
		// Aggregation 실행
		AggregationResults<ChatRoomDTO> result = mongo.aggregate(agg, "chat_messages", ChatRoomDTO.class);
		
		return result.getMappedResults();
		
	}//end of public List<ChatRoomDTO> findAllWithLatestChatByMemberId(String member_id) {}...
	
	
	
	
	
	
	
}//end of class...
