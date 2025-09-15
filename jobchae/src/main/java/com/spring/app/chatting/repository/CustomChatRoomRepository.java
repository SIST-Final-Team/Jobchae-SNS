package com.spring.app.chatting.repository;

import java.time.Instant;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.apache.catalina.Pipeline;
import org.bson.Document;
import org.eclipse.tags.shaded.org.apache.xpath.operations.Gt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.MongoExpression;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.aggregation.*;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.stereotype.Repository;
import org.springframework.data.mongodb.core.aggregation.ConditionalOperators;

import com.spring.app.chatting.domain.ChatRoomDTO;

import lombok.RequiredArgsConstructor;

import static com.mongodb.client.model.Filters.gt;
import static org.springframework.data.mongodb.core.aggregation.Aggregation.*;
import static org.springframework.data.mongodb.core.aggregation.ArrayOperators.Filter.filter;
import static org.springframework.data.mongodb.core.aggregation.ArrayOperators.Last.lastOf;
import static org.springframework.data.mongodb.core.aggregation.ConditionalOperators.ifNull;
import static org.springframework.data.mongodb.core.query.TypedCriteriaExtensionsKt.size;

@RequiredArgsConstructor
@Repository
public class CustomChatRoomRepository {

	
	@Autowired
	MongoOperations mongo; // 몽고 디비를 직접 커스텀 하려한다.

	// 현재 로그인 사용자가 참여하고 있는 채팅방 목록, 최신 채팅내역 조회
	public List<ChatRoomDTO> findAllWithLatestChatByMemberId(String member_id) {
  
		Aggregation agg = newAggregation(

		// 	// [시작 & 필터링] 'chat_room'에서 시작하여 사용자가 참여한 방만 필터링
		// 	Aggregation.match(Criteria.where("partiMemberList").elemMatch(Criteria.where("member_id").is(member_id))),
        //
        //     // [2단계: (필수!) ID -> String 변환]
        //     // 모든 lookup을 위해, DB에 ObjectId로 저장된 _id 필드를 String으로 변환하여 임시 필드에 저장합니다.
        //     // 당신의 ChatRoom 클래스에서 @Id 필드 이름이 'roomId'이므로, "$roomId"를 사용합니다.
        //     Aggregation.addFields().addField("roomIdAsString")
        //             .withValue(ConvertOperators.ToString.toString("$_id")).build(),
        //
        //     // 첫번째 조인, 각 채팅방에서 나의 마지막 읽음 시간 정보 조인
        //     Aggregation.lookup(
        //             "chat_room_readStatus", // 조인할 대상 컬렉션
        //             "roomIdAsString",            // chat_room의 필드 (로컬 필드, 변환된 스트링이다.)
        //             "roomId",                    // chat_room_readStatus의 필드 (외부 필드)
        //             "readStatus"                 // 결과를 담을 새 배열 필드 이름
        //     ),
        //
        //     // 읽음 상태 필터링
        //     // 조인된 readStatus 배열에서 '나의' 읽음 상태만 남기고, 없으면 null인 객체를 유지
        //     Aggregation.addFields().addField("myReadStatus").withValue(
        //             ArrayOperators.Filter.filter("readStatus")
        //                     .as("status")
        //                     .by(ComparisonOperators.Eq.valueOf("$$status.userId").equalToValue(member_id))
        //     ).build(),                                                     // $$는 변수를 의미
        //     Aggregation.unwind("myReadStatus", true), // preserveNullAndEmptyArrays: true
        //
        //     // 두번째 조인, 각 채팅방에 모든 메시지 정보 조인
        //     Aggregation.lookup("chat_messages", "roomIdAsString", "roomId", "all_messages"),
        //
        //     // 메세지 배열 해제(1:1 쌍으로 만들어서 펼친다.)
        //     Aggregation.unwind("all_messages", true),
        //
        //     // 안 읽음 비교 플래그 생성
        //     // 메세지 시간 > 나의 마지막 읽음 시간 비교
        //     Aggregation.addFields()
        //             .addField("isUnreadMessage")
        //             .withValue(
        //                     // $gt (Greater Than) 연산
        //                     ComparisonOperators.Gt.valueOf("all_messages.sendDate")
        //                             .greaterThan(
        //                                     // myReadStatus가 없으면(null), 아주 먼 과거 시간을 기준으로 삼아 모든 메시지를 '안 읽음'(true)으로 처리
        //                                     ConditionalOperators.ifNull("myReadStatus.lastReadTimestamp")
        //                                             .then(java.time.Instant.EPOCH) // 1970-01-01T00:00:00Z
        //                             )
        //             ).build(),
        //
        //     // 최신 메시지 순으로 정렬
        //     Aggregation.sort(Sort.by(Sort.Direction.DESC, "all_messages.sendDate")),
        //
        //     // [8단계: 재그룹화] (최종 수정)
        //     Aggregation.group("roomIdAsString") // 기준을 명확하게 roomIdAsString으로 통일
        //             // $$ROOT 전체 대신, 필요한 부분만 명시적으로 가져와서 구조를 만듭니다.
        //             .first("$$ROOT").as("chatRoom") // chatRoom 필드에는 원본 ChatRoom의 모든 정보를 담은 $$ROOT를 넣습니다.
        //             .first("all_messages").as("latestChat") // latestChat 필드에는 최신 메시지를 넣습니다.
        //             .max("isUnreadMessage").as("unReadChat"), // 그룹 내에 안 읽은 메시지가 하나라도 있으면(true)
        //
        //     // [9단계: 최종 정리] (로직 수정)
        //     Aggregation.project()
        //             .and("chatRoom").as("chatRoom") // DTO 필드에 맞게 재구성
        //             .and("latestChat").as("latestChat")
        //             .and("unReadChat").as("unReadChat"),
        //
        //     // [10단계: 최종 정렬] (기존 로직)
        //     Aggregation.sort(Sort.by(Sort.Direction.DESC, "latestChat.sendDate"))
        // );
        //
        // AggregationResults<ChatRoomDTO> result = mongo.aggregate(agg, "chat_room", ChatRoomDTO.class);
        //
        // return result.getMappedResults();

            
                
            // [1단계: 필터링]
            match(Criteria.where("partiMemberList").elemMatch(Criteria.where("member_id").is(member_id))),
        
            // [(필수!) ID -> String 변환]
            // 모든 lookup을 위해, DB에 ObjectId로 저장된 _id 필드를 String으로 변환하여 임시 필드에 저장합니다.
            // 당신의 ChatRoom 클래스에서 @Id 필드 이름이 'roomId'이므로, "$roomId"를 사용합니다.
            Aggregation.addFields().addField("roomIdAsString")
                    .withValue(ConvertOperators.ToString.toString("$_id")).build(),
            // [2단계: 관련 데이터 조인]
            Aggregation.lookup("chat_room_readStatus", "roomIdAsString", "roomId", "readStatus"),
        
            // 나의 읽음 상태만 필터링
            Aggregation.addFields().addField("myReadStatus").withValue(
                    ArrayOperators.Filter.filter("readStatus")
                            .as("status")
                            .by(ComparisonOperators.Eq.valueOf("$$status.userId").equalToValue(member_id))
            ).build(),
        
            // [5단계: 모든 메시지 조인] (기존과 동일)
            Aggregation.lookup("chat_messages", "roomIdAsString", "roomId", "all_messages"),
            
            // [6단계-A: 정렬된 메시지 배열 생성]
            Aggregation.addFields().addField("sorted_messages")
                    .withValue(// all_messages 배열을 정렬합니다.
                            ArrayOperators.SortArray.sortArrayOf("all_messages")
                            // 정렬 기준: 'sendDate' 필드를 내림차순(DESC)으로
                                .by(Sort.by(Sort.Direction.DESC, "sendDate"))
                    ).build(),
            
            // 최신 메시지(배열 마지막 요소 꺼내기)
            Aggregation.addFields().addField("latestChat")
                    .withValue(ArrayOperators.ArrayElemAt.arrayOf("sorted_messages")
                        .elementAt(0))
                        // 내림차순 정렬된 것의 첫번째
                    .build(),
        
            // 안읽음 여부
            Aggregation.addFields().addField("unReadChat").withValue(
                    ComparisonOperators.Gt.valueOf(
                            ArrayOperators.Size.lengthOfArray(
                                    ArrayOperators.Filter.filter("all_messages")
                                            .as("msg")
                                            .by(ComparisonOperators.Gt.valueOf("$$msg.sendDate")
                                                    .greaterThan(ConditionalOperators.ifNull(
                                                            ArrayOperators.ArrayElemAt
                                                                    .arrayOf("myReadStatus.lastReadTimestamp")
                                                                    .elementAt(0) // 배열의 첫번째 요소 접근
                                                            )
                                                            .then(java.time.Instant.EPOCH))
                                            )
                            )
                    ).greaterThanValue(0)
            ).build(),
            
        
            // 8. projection
            Aggregation.project()
                    .and(Aggregation.ROOT).as("chatRoom") // $$ROOT
                    .and("latestChat").as("latestChat")
                    .and("unReadChat").as("unReadChat"),
                
            Aggregation.sort(Sort.by(Sort.Direction.DESC, "latestChat.sendDate"))
        );
        
        AggregationResults<ChatRoomDTO> result =
                mongo.aggregate(agg, "chat_room", ChatRoomDTO.class);
        
        return result.getMappedResults();
        
        // // 나의 마지막 읽음 시간 추출
        // Aggregation.addFields().addField("myLastReadTimestamp").withValue(
        //         AggregationExpression.from((MongoExpression) new Document("$let", new Document("vars",
        //                 new Document("myStatus",
        //                         filter("readStatus")
        //                                 .as("status")
        //                                 .by(ComparisonOperators.Eq.valueOf("$$status.userId").equalToValue(member_id))
        //                 )
        //         )).append("in",
        //                 // $$myStatus 배열의 첫 번째 요소의 lastReadTimestamp 필드가 null인지 확인
        //                 ConditionalOperators.when(
        //                         // 조건: 이 필드가 존재하는가? (또는 null이 아닌가?)
        //                         // $$myStatus 배열이 비어있으면 이 필드 자체가 존재하지 않아 null로 평가됨
        //                         ComparisonOperators.Ne.valueOf(
        //                                 ArrayOperators.ArrayElemAt.arrayOf("$$myStatus.lastReadTimestamp").elementAt(0)
        //                         ).notEqualToValue(null))
        //                         .then(// 존재하면(null이 아니면) 그 값을 사용
        //                               ArrayOperators.ArrayElemAt.arrayOf("$$myStatus.lastReadTimestamp").elementAt(0)
        //                         )
        //                         .otherwise(// 존재하지 않으면(null이면) EPOCH 사용
        //                                 Instant.EPOCH)
        // ))).build(),
        
        // // [5단계: 모든 메시지 조인] (기존과 동일)
        // Aggregation.lookup("chat_messages", "roomIdAsString", "roomId", "all_messages"),
        
        
        
                
                
        
       
        
        
        // // 기존의 어그리제이션, 혹시 몰라서 남겨두었다.
		// 	// [조인] chat_room의 _id와 chat_messages의 roomId를 기준으로 LEFT JOIN 수행
		// 	Aggregation.addFields()
		// 			.addField("roomIdStr")
		// 			.withValue(ConvertOperators.ToString.toString("$_id")).build(),// $_id는 필드가 담고 있는 값(value)
		// 	Aggregation.lookup("chat_messages", "roomIdStr", "roomId", "all_messagesInChatroom"),
        //
		// 	// [배열 해체] 메시지 배열을 풀어냄. 메시지 없는 방도 유지 (핵심!) (all_messagesInChatroom:데이터1) 이런 형식으로 만듬
		// 	Aggregation.unwind("all_messagesInChatroom", true), // preserveNullAndEmptyArrays: true
        //
        //     // 안 읽은 메세지가 있는 경우(채팅방에 안읽은 메세지가 있는 경우) true, 없으면 false
        //     Aggregation.addFields()
        //             .addField("isReadChat")
        //             .withValue(
        //                     // BooleanOperators.Not 빌더를 사용하여 전체 조건을 감싼다.
        //                     BooleanOperators.Not.not(
        //                             // ArrayOperators.In 빌더를 사용하여 $in 연산을 정의
        //                             ArrayOperators.In.arrayOf(
        //                                     // ConditionalOperators.ifNull 빌더를 사용하여 $ifNull 연산을 정의
        //                                     ConditionalOperators.ifNull("all_messagesInChatroom.readMembers")
        //                                                         .then(new ArrayList<>()) // null 이면 빈 배열 반환
        //                             )                           // 번역기가 인식할 수 있는 new ArrayList<>() 사용
        //                             .containsValue(member_id)
        //                     )
        //                 ).build(),
        //
		// 	// [정렬] 메시지가 있는 경우 최신순으로 정렬. 없는 경우는 null 상태로 유지됨.
		// 	Aggregation.sort(Sort.by(Sort.Direction.DESC, "all_messagesInChatroom.sendDate")),
        //
		// 	// [재그룹화] 다시 채팅방 ID 기준으로 그룹화하여 최신 메시지 1개만 남김
		// 	Aggregation.group("_id") // chat_room의 고유 ID로 그룹화
		// 			// 채팅방 정보는 그룹의 첫 번째 문서에서 가져옴
		// 			.first("$$ROOT").as("chatRoom")
		// 			// 최신 메시지 정보도 그룹의 첫 번째 문서에서 가져옴
		// 			.first("all_messagesInChatroom").as("latestChat")
        //             // .anyElementTrue("isReadChat").as("isReadChat"),
        //             // 버전이 차이나서 못쓴다. (isReadChat 필드에 true가 하나라도 있으면 true)
        //             .max("isReadChat").as("isReadChat"),
        //             // true는 1, false는 0 이라서 제일 큰 값을 반환하면 똑같이 작동한다.
        //
		// 	// [최종 정리] DTO에 매핑하기 좋은 구조로 필드 정리
		// 	Aggregation.project()
		// 			.and("chatRoom").as("chatRoom") // 채팅방 전체 정보
		// 			.and("latestChat.message").as("latestChat.message")
		// 			.and("latestChat.sendDate").as("latestChat.sendDate")
		// 			.and("latestChat.senderId").as("latestChat.senderId")
		// 			.and("latestChat.senderName").as("latestChat.senderName")
        //             .and("isReadChat").as("unReadChat"),
        //
		// 	// [정렬] 최종 채팅방 목록 전체를 최신 메시지 시간순으로 정렬
		// 	Aggregation.sort(Sort.by(Sort.Direction.DESC, "latestChat.sendDate"))
		// );
        //
		// // Aggregation 실행 (시작 컬렉션이 "chat_room"으로 변경됨)
		// AggregationResults<ChatRoomDTO> result = mongo.aggregate(agg, "chat_room", ChatRoomDTO.class);
        //
		// return result.getMappedResults();

	}//end of public List<ChatRoomDTO> findAllWithLatestChatByMemberId(String member_id) {}...
	
	
	
	
	
	
	
}//end of class...
