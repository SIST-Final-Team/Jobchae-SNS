package com.spring.app.chatting.repository;

import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArrayList;

@Repository // 이 클래스를 스프링 빈(Bean)으로 등록, 기본적으로 싱글톤으로 관리
public class RoomPartiMemberIdListRepository {
    
    private final ChatRoomRepository chatRoomRepository; // 채팅방 레포지토리
    
    public RoomPartiMemberIdListRepository(ChatRoomRepository chatRoomRepository) {
        this.chatRoomRepository = chatRoomRepository;
    }
    // ConcurrentHashMap은 원자성을 보장한다. 들어온 순서대로 읽고 쓴다.
    // CopyOnWriteArrayList 는 동시성을 보장해서 쓰는 동안만 락을 걸고 읽기는 아니여서 속도가 빠르다.
    private final ConcurrentHashMap<String, CopyOnWriteArrayList<String>>roomMemberIdMapList = new ConcurrentHashMap<>();
    
    
    // 채팅방 인원 최초 저장하기 메소드(느슨한 결합으로 보안을 챙김)
    public List<String> getMemberIdList(String roomId) {
        return internalGetMemberIdList(roomId);
    }
    
    // 채팅방 인원 최초 저장하기 메소드(내부에서만 돌아간다. 캡슐화하여 보안을 챙기자)
    private CopyOnWriteArrayList<String> internalGetMemberIdList(String roomId) {
        return roomMemberIdMapList.computeIfAbsent(roomId, key ->
                // 채팅방번호로 된 키가 없으면 그 채팅방의 모든 참여자 아이디 리스트 가져오기
                new CopyOnWriteArrayList<>(chatRoomRepository.findPartiMemberIdListById(key)) // 동시성 리스트
        );
    }//end of public List<String> setMemberIdList(String roomId) {}...
    
    
    // 채팅방 인원 추가 메소드
    public List<String> addMemberIdList(String roomId, List<String> invitedMemberIdList) {
        CopyOnWriteArrayList<String> memberIdList = internalGetMemberIdList(roomId);
        memberIdList.addAllAbsent(invitedMemberIdList);
        return memberIdList;
    }
    
    // 채팅방 나갔을 때 감소 메소드
    public List<String> removeMemberIdList(String roomId, String loginUserId) {
        CopyOnWriteArrayList<String> memberIdList = internalGetMemberIdList(roomId);
        memberIdList.remove(loginUserId);
        return memberIdList;
    }
    
    

}//end of class...





