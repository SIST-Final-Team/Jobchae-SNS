package com.spring.app.chatting.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import com.spring.app.chatting.domain.PartiMember;
import com.spring.app.member.domain.MemberVO;
import com.spring.app.member.model.MemberDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.FindAndModifyOptions;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

import com.spring.app.chatting.domain.ChatMessage;
import com.spring.app.chatting.domain.ChatRoom;
import com.spring.app.chatting.domain.ChatRoomDTO;
import com.spring.app.chatting.repository.ChatRepository;
import com.spring.app.chatting.repository.ChatRoomRepository;
import com.spring.app.chatting.repository.CustomChatRoomRepository;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.TransactionSynchronization;
import org.springframework.transaction.support.TransactionSynchronizationManager;




@Service
public class ChatService_imple implements ChatService{

	@Autowired
	private ChatRepository chatRepository; // 채팅 레포지토리

	@Autowired
	private ChatRoomRepository chatRoomRepository; // 채팅방 레포지토리

	@Autowired
	private CustomChatRoomRepository customChatRoomRepository; // 채팅방 커스텀 레포지토리
	
	// 생성자 매개변수로 선언하는 것이 더 좋다.
	private final MongoTemplate mongoTemplate;
	private final SimpMessagingTemplate simpMessagingTemplate; // WebSocket으로 메시지를 보내기 위한 템플릿
    private final MemberDAO dao;
	public ChatService_imple(MongoTemplate mongoTemplate, SimpMessagingTemplate simpMessagingTemplate, MemberDAO dao) {
        this.mongoTemplate = mongoTemplate;
        this.simpMessagingTemplate = simpMessagingTemplate;
        this.dao = dao;
    }
	
	
    
    
    // 현재 로그인한 유저의 모든 채팅방 불러오기 메소드
	@Override
	public List<ChatRoomDTO> getChatRoomList(String member_id) {
		
        //
        
        
		// 현재 로그인 사용자가 참여하고 있는 채팅방 목록, 최신 채팅내역 조회
		List<ChatRoomDTO> chatRoomRespDTOList = customChatRoomRepository.findAllWithLatestChatByMemberId(member_id);
		
		// 참여하고 있는 채팅방이 존재하지 않는 경우
		if (chatRoomRespDTOList.isEmpty()) {
			return chatRoomRespDTOList;
		}

		// 채팅방 프로필 목록 불러오기
		for(ChatRoomDTO chatRoomDTO : chatRoomRespDTOList) {
			// 참여자 아이디 목록을 최대 4개까지 추출
			List<String> memberIdList = chatRoomDTO.getChatRoom().getPartiMemberList()
					.stream()
					.map(PartiMember::getMember_id)
					.limit(4)
					.toList();

			// 참여자 아이디 목록으로 회원 정보 조회
			List<MemberVO> memberVOList = dao.getMemberListByMemberId(memberIdList);

			// 회원 프로필을 DTO에 저장
			chatRoomDTO.setMemberProfileList(memberVOList
					.stream()
					.filter(memberVO -> !memberVO.getMember_id().equals(member_id))
					.map(MemberVO::getMember_profile)
					.toList());
		}

		return chatRoomRespDTOList;
		
	}//end of public List<ChatRoomRespDTO> getChatRoomList(String member_id) {}... 


	
	
	// 채팅 메세지 저장
	@Override
	public ChatMessage saveChat(ChatMessage chat) {
		
//		ChatRoom chatRoom = chatRoomRepository.findChatRoomByRoomId(chat.getRoomId());
//		int readCount = chatRoom.getParticipants().size();
//
//		// 읽지 않은 인원 수가 정장적으로 나오지 않는경우 예외처리
//		if (readCount < 1) {
//			log.error("[ERROR] : readCount 값 오류 : {}", readCount);
//			throw new BusinessException(ExceptionCode.CREATE_CHATROOM_FAILD);
//		}
//
//		chat.updateUnReadCount(readCount - 1);
		
		return chatRepository.save(chat);
		
	}//end of public ChatMessage saveChat(ChatMessage chat) {}...

	
	
	// 채팅방의 채팅 내역 조회
	@Override
	public List<ChatMessage> loadChatHistory(String roomId) {
		return chatRepository.findChatByRoomId(roomId);
	}
	
	
	
	// 채팅방 개설 메소드
	@Override
	public ChatRoom createChatRoom(MemberVO loginuser, List<String> follow_id_List, List<String> follow_name_List) {
		
        // 기존에 같은 멤버로 존재하는 채팅방이 있는지 검색
        
        
        
        
		// 받아온 리스트를 파티멤버타입으로 만들어준다.
		List<PartiMember> partiMemberList = new ArrayList<>();
		
		for (int i = 0; i < follow_id_List.size(); i++) {
			partiMemberList.add(PartiMember.createPartiMember(follow_id_List.get(i), follow_name_List.get(i)));
		}
		// 로그인 유저 정보도 넣어준다.
		partiMemberList.add(PartiMember.createPartiMember(loginuser.getMember_id(), loginuser.getMember_name()));
		
		// 방의 기본이름은 유저의 이름과 나머지 참여자의 이름을 조합한다.
		String room_name = String.join(",", follow_name_List); // 이름 리스트를 스트링으로 변환
		
		ChatRoom chatroom = ChatRoom.create_chatRoom(room_name ,partiMemberList);
		
		return chatRoomRepository.save(chatroom); // 채팅방 저장
		
	}//end of public ChatRoom createChatRoom(String loginuser_member_id, String loginuserFolowId) {}...
    
    
    
    // 초대된 사람 채팅방 입장
    @Override
    @Transactional
    public void enterChatRoom(String member_id ,String roomId, List<String> invitedMemberIdList) {
        
        // 초대하려는 사람의 이름이 있는지 검색(프론트를 아주 믿으면 안됌)
        boolean existAllMember = dao.existsAllMembersByIds(invitedMemberIdList);
        
        // 들어온 채팅방이 있는지 확인
        ChatRoom chatroom = chatRoomRepository.findById(roomId)
                .orElseThrow(() -> new IllegalArgumentException("존재하지 않는 채팅방입니다."));
        
        // 방에 로그인한 사람(초대하는 사람)도 있어야하니 검증해주자
        boolean isExistLoginuser = chatroom.getPartiMemberList().stream()
                .anyMatch(partiMember -> partiMember.getMember_id().equals(member_id));
        
        // 이미 방에 있는 사람인지도 확인
        // 채팅방에 이미 존재하는 사람들을 Set 타입의 객체로 만들어준다.(성능 때문에)
        Set<String> partiMemberIdList = chatroom.getPartiMemberList().stream()
                .map(PartiMember::getMember_id) // partiMember -> partiMember.getMember_id()와 동일
                .collect(Collectors.toSet()); // Set 타입으로 변환
        
        // 초대하려는 사람이 이미 방에 있는 사람인지 검증(리스트가 나오면 한사람이라도 있는 것이다.)
        // 검색이 안되면 빈 리스트를 반환! []
        List<String> isExistInvitedMemberIds = invitedMemberIdList.stream()
                .filter(invitedMemberId -> partiMemberIdList.contains(invitedMemberId)) // 조건에 충족하면
                .toList();
        
        // 초대하려는 사람이 존재하고, 로그인한 유저도 채팅방에 있고, 채팅방에 아예 존재하지 않는 참여자면 실행
        if (existAllMember && isExistLoginuser && isExistInvitedMemberIds.isEmpty()) {
            Query query = new Query(Criteria.where("_id").is(roomId));
            
            // 초대하려는 사람 이름 리스트(메시지 보낼 때도 필요)
            List<String> invitedMemberNameList = dao.isExistMemberNameByMemberId(invitedMemberIdList);
            
            //초대하려는 아이디와 이름 리스트를 각각 넣어준다.
            List<PartiMember> newPartiMemberList = ChatRoom.addNewPartiMember(invitedMemberIdList, invitedMemberNameList);
            // 이러면 개별적으로 넣어준다.
            Update update = new Update().addToSet("partiMemberList").each(newPartiMemberList);

            FindAndModifyOptions options = new FindAndModifyOptions().returnNew(true);

            ChatRoom updateChatRoom = mongoTemplate.findAndModify(query, update, options,ChatRoom.class);

            if (updateChatRoom != null) {
                ChatMessage chatMessage = ChatMessage.enterMessage(roomId, invitedMemberNameList);
                // 저장
                chatRepository.save(chatMessage);
                
                // 모든 트렌젝션이 끝나고 실행되게 만들어준다.
                TransactionSynchronizationManager.registerSynchronization(new TransactionSynchronization() {
                    @Override
                    public void afterCommit() { // 모든 몽고디비 작업이 끝나고 실행되는 구분
                        // 채팅방 구독중인 모든 사용자에게 메세지 보내기
                        simpMessagingTemplate.convertAndSend("/room/"+roomId, chatMessage);
                    }
                });//end of TransactionSynchronizationManager.registerSynchronization(new TransactionSynchronization() {}...
            }
        }//
    }//
    
    
	
	// 채팅방 나가기
	@Override
    @Transactional
	public void leaveChatRoom(String roomId, String member_id, String member_name) {
        
		// 채팅방 아이디를 이용해서 쿼리문 작성
		Query query = new Query(Criteria.where("_id").is(roomId));
		
		// 삭제할 조건 쿼리 작성(pull 은 삭제조건을 의미)
		Update update = new Update().pull("partiMemberList", Query.query(Criteria.where("member_id").is(member_id)));
		
		// 업데이트된 문서를 반환하도록 설정
		FindAndModifyOptions options = new FindAndModifyOptions().returnNew(true);
		
		// 검색을 먼저하고 처리된 결과값을 리턴한다.
		ChatRoom updateChatRoom = mongoTemplate.findAndModify(query, update, options, ChatRoom.class);
		
		// 반환이 잘되어지면
		if (updateChatRoom != null) {
			ChatMessage chatMessage = ChatMessage.leaveMessage(roomId, member_name);
            // 저장
            chatRepository.save(chatMessage);
            
            TransactionSynchronizationManager.registerSynchronization(new TransactionSynchronization() {
                @Override
                public void afterCommit() { // 모든 몽고디비 작업이 끝나고 실행되는 구분
                    // 채팅방 구독중인 모든 사용자에게 메세지 보내기
                    simpMessagingTemplate.convertAndSend("/room/"+roomId, chatMessage);
                }
            });//end of TransactionSynchronizationManager.registerSynchronization(new TransactionSynchronization() {}...
		}//
	}//end of public void leaveChatRoom(String roomId, String member_id, String member_name) {}...
    
    
    
 
    
    
}//end of class...











