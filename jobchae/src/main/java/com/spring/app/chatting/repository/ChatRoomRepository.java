package com.spring.app.chatting.repository;

import org.springframework.data.mongodb.repository.Aggregation;
import org.springframework.data.mongodb.repository.MongoRepository;

import com.spring.app.chatting.domain.ChatRoom;

import java.util.List;
import java.util.stream.Collectors;

public interface ChatRoomRepository extends MongoRepository<ChatRoom, String> {
    
    // 채팅방의 모든 참여자 아이디를 조회(:1 은 포함, :0 미포함)
    // @Query(value = "{'_id': ?0}", fields = "{'partiMemberList.member_id':1, '_id':0}")
    default List<String> findPartiMemberIdListById(String roomId) {
        // 이제 이 메소드는 외부의 public 인터페이스를 사용합니다.
        List<MemberIdOnly> projections = findMemberIdsUsingAggregation(roomId);
        
        return projections.stream()
                .map(MemberIdOnly::getMember_id)
                .collect(Collectors.toList());
    }
    
    @Aggregation(pipeline = {
            "{ '$match': { '_id': ?0 } }",
            "{ '$unwind': '$partiMemberList' }",
            "{ '$replaceRoot': { 'newRoot': '$partiMemberList' } }",
            "{ '$project': { 'member_id': 1, '_id': 0 } }"
    })
    List<MemberIdOnly> findMemberIdsUsingAggregation(String roomId);
    
    
    // =========================================================================
    
    
    
    
    


//	// 사용자가 속한 모든 채팅방 내역 조회
//	@Query(value = "{ 'participants.memberNo': { $all: [?0] } }", sort = "{ 'productNo': 1 }")
//	List<ChatRoom> findAllByMemberNoOrderByProductNoAsc(String memberNo);

}



