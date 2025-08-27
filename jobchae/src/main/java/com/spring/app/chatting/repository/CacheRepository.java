package com.spring.app.chatting.repository;


import org.springframework.cache.annotation.CachePut;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

@Repository
public class CacheRepository {
    
    private final ChatRoomRepository chatRoomRepository; // 채팅방 레포지토리
    
    public CacheRepository(ChatRoomRepository chatRoomRepository) {
        this.chatRoomRepository = chatRoomRepository;
    }
    
    // 캐시 데이터 추가
    @Cacheable(value = "chatRoomMemberIds", key = "#roomId")
    public List<String> getCacheRoomMemberIds(String roomId) {
        // 캐시에 데이터가 없을 때만 System.out 이 찍힌다!
        System.out.println("DB에서 roomId " + roomId + "의 멤버 목록을 조회하고 캐시에 저장");
        
        // 실제 DB에서 멤버 목록을 조회하는 로직
        // 다만, 캐시에서 반환된 리스트는 불변(immutable)으로 취급하는 것이 좋음
        return new CopyOnWriteArrayList<>(chatRoomRepository.findPartiMemberIdListById(roomId));
    }
    
    
    // 채팅방 멤버 추가 또는 삭제 후 캐시 업데이트(무조건 실행되기 때문에 추가한 후 다시 캐싱하는 용도)
    @CachePut(value = "chatRoomMemberIds", key = "#roomId")
    public List<String> addOrDeleteCacheMemberIds(String roomId) {
        
        System.out.println("멤버 추가 후, DB에서 최신 목록을 읽어 캐시를 갱신 : " + roomId);
        return new CopyOnWriteArrayList<>(chatRoomRepository.findPartiMemberIdListById(roomId));
    }
    
    
    
    
    
    
    
    
    
    
    
    
}//end of class...
