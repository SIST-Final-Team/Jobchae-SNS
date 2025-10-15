package com.spring.app.chatting.repository;

import com.spring.app.chatting.domain.ChatMessage;
import com.spring.app.chatting.domain.ChatMessageDTO;
import com.spring.app.chatting.domain.ChatRoomReadStatus;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.aggregation.*;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Repository;

import java.time.Instant;
import java.util.List;

@RequiredArgsConstructor // 생성자 자동 주입
@Repository
public class CustomChatMessagesRepository {
    
    private final MongoOperations mongo;
    
    // 상수 정의
    private static final int MESSAGE_COUNT = 20;
    private static final int UNREAD_COUNT = 5;
    
    
    // 안읽은 메세지 찾아서 나오는 배열식(all_messages는 날짜기준 내림차순(DESC)으로 정렬된 배열필드이다.)
    AggregationExpression unReadMessages =
            ArrayOperators.Filter.filter("all_messages")
                    .as("msg")
                    .by(ComparisonOperators.Gt.valueOf("$$msg.sendDate")
                            .greaterThan(ConditionalOperators.ifNull(
                                    ArrayOperators.ArrayElemAt
                                            .arrayOf("myReadStatus.lastReadTimestamp")
                                            .elementAt(0) // 배열의 첫번째 요소 접근(어차피 하나)
                            ).then(java.time.Instant.EPOCH))
                    );
    
    // 안읽은 메세지의 배열의 길이가 0보다 크면 안읽은 메세지가 있다.
    // 안 읽은 메시지가 있으면 true, 없으면 false로 만드는 식(정확히는 boolean 필드에 매핑하면 1은 true, 0은 false
    AggregationExpression hasUnreadCondition =
            ComparisonOperators.Gt.valueOf(
                    ArrayOperators.Size.lengthOfArray(unReadMessages)
            ).greaterThanValue(0);
    
    // 가장 오래된 안읽은 메세지의 인덱스 찾기(all_messages에서 제일 첫번재 안읽은 메세지 인덱스)
    AggregationExpression firstUnreadIndex =
            ArrayOperators.IndexOfArray.arrayOf("all_messages").indexOf( // 3. 그 메시지가 all_messages의 몇 번째 인덱스인지 찾아라
                    ArrayOperators.ArrayElemAt.arrayOf( // 2. 정렬된 배열의 첫 번째 요소를 가져와라 (이게 '가장 오래된' 안읽은 메시지)
                            ArrayOperators.SortArray.sortArray(unReadMessages) // 1. 안읽은 메시지 목록을 오름차순으로 '다시 정렬'해라
                                    .by(Sort.by(Sort.Direction.ASC, "sendDate"))
                    ).elementAt(0) // 나온 첫번째 인덱스의 값
            );// 그 값의 인덱스는 무엇이라고 말하고 있는 것이다.
    
    // 원하는 itemCount = min(totalSize, firstUnreadIndex + PREV + 1)
    // 채팅방 메세지 배열필드의 총 길이
    AggregationExpression totalSize = ArrayOperators.Size.lengthOfArray("all_messages");
    
    // 내림차순 정렬된 all_messages 배열에서 제일 오래된 안읽은 메세지 앞의 메세지 5개를 가져올 때 개수
    AggregationExpression endCount =
            ArithmeticOperators.Add.valueOf(firstUnreadIndex)
                    .add(UNREAD_COUNT).add(1);
    
    // 가져와야하는 메세지 개수가 전체 메세지양보다 많으면 그냥 모두 가져온다.
    AggregationExpression limitedItemCount =
            ConditionalOperators.when(ComparisonOperators.Gt.valueOf(endCount)
                            .greaterThanValue(totalSize))
                    .then(totalSize)
                    .otherwise(endCount);
    
    // 반환되는 메소드는 여기!
    public ChatMessageDTO customFindChatMessagesByRoomId(String roomId, String member_id, int loadChatStartToInt) {
     
        // 안 읽은 메세지가 있는지 가볍게 find 한다.
        boolean existUnRead = checkUnReadMessages(roomId, member_id);
        
        if (existUnRead) {// 안 읽은 메세지가 있는 경우, true
            // 내림차순 기반 어그리제이션 실행
            Aggregation agg = createUnreadMessagesAggregation(roomId, member_id);
            AggregationResults<ChatMessageDTO> result =
                    mongo.aggregate(agg, "chat_messages", ChatMessageDTO.class);
            
            return result.getUniqueMappedResult(); // 이거 검색 안되면 null임
        
        } else {// 안 읽은 메세지가 없는 경우, false, 효율적인 쿼리 실행, 최신 메세지부터 20개씩 가져올 것이다.
            Query query = new Query(Criteria.where("roomId").is(roomId));
            // 최신 메시지부터 가져오기 위해 내림차순 정렬
            query.with(Sort.by(Sort.Direction.DESC, "sendDate"));
            // 최신 메세지 0개, 그 다음은 20개의 아이템을 건너뛰고 라는 뜻, loadChatStart 갯수만큼 아이템 스킵
            query.skip(loadChatStartToInt);
            // 20개씩 가져오기, 최대갯수기 때문에 20개보다 적은 양이 남아도 다 가져올 것이다.
            query.limit(MESSAGE_COUNT);
            
            // 채팅방의 모든 메세지를 최신순으로 가져왔다.
            List<ChatMessage> findMessageList = mongo.find(query, ChatMessage.class);
            
            // ChatMessageDTO 타입으로 변환해서 리턴
            return ChatMessageDTO.allReadOfChatMessageDTO(findMessageList);
        }//end of if else
        
    }//end of public List<ChatMessage> customFindChatMessagesByRoomId_2(String roomId, String member_id, String loadChatStart) {}...
    
    
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // 메소드
    
    // 안 읽은 메세지가 있는지 없는지 확인하는 쿼리 메소드
    private boolean checkUnReadMessages(String roomId, String member_id) {
        
        Query query = new Query(Criteria.where("roomId").is(roomId).and("userId").is(member_id));
        ChatRoomReadStatus readStatus = mongo.findOne(query, ChatRoomReadStatus.class);
        
        // 사용자의 읽음 정보가 없으면 모든 메세지가 안 읽은 것으로 간주
        Instant lastReadTimestamp = (readStatus != null && readStatus.getLastReadTimestamp() != null)
                ? readStatus.getLastReadTimestamp()
                : Instant.EPOCH; // null 이면 1970년 기준으로 판단
        
        // 마지막 읽은 시간 이후에 온 메시지가 1개라도 있는지 확인
        Query unreadMessageQuery = new Query(Criteria.where("roomId").is(roomId)
                .and("sendDate").gt(lastReadTimestamp)); // great then
        
        return mongo.exists(unreadMessageQuery, ChatMessage.class); // boolean 타입(true, false)
    }//end of private boolean checkUnReadMessages(String roomId, String member_id) {}...
    
    
    // 안 읽은 메세지가 있는 경우 어그리제이션 실행 함수
    private Aggregation createUnreadMessagesAggregation(String roomId, String member_id) {
        return Aggregation.newAggregation( // 스테틱이네?
                // 특정 채팅방 하나 선택 필터링
                Aggregation.match(Criteria.where("roomId").is(roomId)),
                
                // 메세지를 하나의 문서에 모음
                Aggregation.group().push("$$ROOT").as("all_messages"),
                
                // all_messages 배열을 내림차순으로 해야함!!!!!
                Aggregation.addFields().addField("all_messages")
                        .withValue(ArrayOperators.SortArray.sortArrayOf("all_messages")
                                .by(Sort.by(Sort.Direction.DESC, "sendDate")))
                        .build(),
                
                // 해당 채팅방의 읽음 상태 컬렉션 조인
                Aggregation.lookup(
                        "chat_room_readStatus",
                        "all_messages.0.roomId",
                        "roomId",
                        "myReadStatus"),
                
                // 채팅방의 특정 사용자만 필터링(로그인한 사람의 아이디)
                Aggregation.addFields().addField("myReadStatus")
                        .withValue(ArrayOperators.Filter.filter("myReadStatus")
                                .as("readStatus")
                                .by(ComparisonOperators.Eq.valueOf("$$readStatus.userId").equalToValue(member_id))
                        ).build(),
                
                // 최정 결과 프로젝트 매핑
                Aggregation.project()
                        .and(hasUnreadCondition).as("existUnReadChat") // 안읽은 메세지 존재 여부 매핑
                        .and(ConditionalOperators.when(hasUnreadCondition)
                                .then(// 안읽은 메세지가 있을 경우(true)
                                        // 제일 오래된 안읽은 메세지 index 기준으로 잘라내기
                                        ArrayOperators.Slice.sliceArrayOf("all_messages")
                                                .itemCount(limitedItemCount))
                                .otherwise( // 여기는 이론상 오지않지만 안전장치로 남겨뒀다.(최신메세지 20개 반환)
                                        ArrayOperators.Slice.sliceArrayOf("all_messages")
                                                .itemCount(MESSAGE_COUNT)
                                )
                        ).as("chatMessageList")
                        // 안 읽은 메시지가 없을 때 index가 -1이 될 수 있으므로, 조건부로 값을 할당
                        .and(ConditionalOperators.when(hasUnreadCondition)
                                .then(firstUnreadIndex)
                                .otherwise(-1) // 혹은 null, 원하는 기본값 (여기도 이론상 오지않음)
                        ).as("oldestUnreadMessageIndex")
        );
    }//end of private Aggregation createUnreadMessagesAggregation(String roomId, String member_id) {}...
    
    
    
}//end of class...
