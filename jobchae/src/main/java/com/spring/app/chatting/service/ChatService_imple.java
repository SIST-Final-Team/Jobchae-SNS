package com.spring.app.chatting.service;

import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import com.spring.app.chatting.domain.*;
import com.spring.app.chatting.repository.*;
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
    // private final RoomPartiMemberIdListRepository roomPartiMemberIdListRepository;
    private final CacheRepository cacheRepository;
    private final ChatRoomReadStatusRepository chatRoomReadStatusRepository;
	public ChatService_imple(MongoTemplate mongoTemplate, SimpMessagingTemplate simpMessagingTemplate, MemberDAO dao, CacheRepository cacheRepository, ChatRoomReadStatusRepository chatRoomReadStatusRepository) {
        this.mongoTemplate = mongoTemplate;
        this.simpMessagingTemplate = simpMessagingTemplate;
        this.dao = dao;
        this.cacheRepository = cacheRepository;
        // this.roomPartiMemberIdListRepository = roomPartiMemberIdListRepository;
        this.chatRoomReadStatusRepository = chatRoomReadStatusRepository;
    }
    
    
    // 현재 로그인한 유저의 모든 채팅방 불러오기 메소드
	@Override
    @Transactional
	public List<ChatRoomDTO> getChatRoomList(String member_id) {
		
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


	
	
	// 채팅 메세지 저장(웹소켓 구독 및 전송)
	@Override
    @Transactional
	public ChatMessage saveChat(ChatMessage chat) {
        
        // List<String> memberIdList = cacheRepository.getCacheRoomMemberIds(chat.getRoomId());
        // for(String member_id : memberIdList) {
        //     System.out.println("캐시에서 아이디 리스트 출력되는지 => "+ member_id);
        // }
		ChatMessage saveChatMessage = chatRepository.save(chat);
        
        // 채탱방의 모든 사람들에게 메시지 전송
        TransactionSynchronizationManager.registerSynchronization(new TransactionSynchronization() {
            @Override
            public void afterCommit() { // 모든 몽고디비 작업이 끝나고 실행되는 구분
                List<String> roomPartiMemberIdList = cacheRepository.getCacheRoomMemberIds(chat.getRoomId());
                for (String member_id : roomPartiMemberIdList) {
                    // 각 멤버의 개인 큐(/user/{memberId}/message/{roomId})로 메시지를 전송
                    simpMessagingTemplate.convertAndSendToUser(member_id, "/message", saveChatMessage);
                }//end of for...
            }
        });//end of TransactionSynchronizationManager.registerSynchronization(new TransactionSynchronization() {}...
        
        return saveChatMessage;
        
	}//end of public ChatMessage saveChat(ChatMessage chat) {}...

	
	
	// 채팅방의 채팅 내역 조회
	@Override
    @Transactional(readOnly = true) // 조회는 이게 효율적
	public List<ChatMessage> loadChatHistory(String roomId) {
		
        // 캐시에 데이터를 넣어주자
        cacheRepository.getCacheRoomMemberIds(roomId);
        
        // 어그리제이션을 통해 안읽은 채팅방의 채팅은 안읽은 채팅 기준으로 위로 20개, 밑으로 전부 가져오고
        // 모든 채팅을 읽은 채팅방의 채팅은 제일 최신 채팅부터 오래된 채팅 순으로 20개씩 가져온다.
        
        
        // 저장된 메세지의 크로스 사이트 스크립트 공격에 대응하는 안전한 코드(시큐어코드) 로 출력하기
        List<ChatMessage> afterChatMessageList = chatRepository.findChatByRoomId(roomId);
        
        List<ChatMessage> beforeChatMessageList =
                afterChatMessageList.stream()
                        .map(chatMessage -> ChatMessage.safeMessage(chatMessage))
                        .toList();
        
        return beforeChatMessageList;
	}//end of public List<ChatMessage> loadChatHistory(String roomId) {}...
    
    
    // // 지금 로그인한 사용자가 메세지를 읽었을 때 읽은 사람 목록에 추가(읽음 처리)
    // @Override
    // @Transactional
    // public void messageReadChack(String roomId, String member_id) {
    //     // 메세지들 중 readMembers 리스트에 나의 아이디가 없는 경우
    //     Query query = new Query(Criteria.where("roomId").is(roomId)
    //                                     .and("readMembers").nin(member_id)); // not in(들어있지 않다는 뜻)
    //     // 중복방지해서 넣기
    //     Update update = new Update().addToSet("readMembers", member_id);
    //
    //     // 여러문서를 한꺼번에 업데이트하자
    //     mongoTemplate.updateMulti(query, update, ChatMessage.class);
    // }//end of public void messageReadChack(String roomId, String memberId) {}...
    
 
	
	// 채팅방 개설 메소드
	@Override
    @Transactional
	public ChatRoom createChatRoom(MemberVO loginuser, List<String> follow_id_List, List<String> follow_name_List) {
        
        // 초대하려는 사람의 아이디가 있는지 검색(프론트를 아주 믿으면 안됨)
        boolean existAllMember = dao.existsAllMembersByIds(follow_id_List, follow_id_List.size());
        
        // 채팅 참여자 목록(로그인유저까지)의 아이디 리스트로 지금 현재 저장되어 있는 채팅방 중 똑같은 참여자가 있는지 검색
        List<String> joinMemberIdList = new ArrayList<>();
        joinMemberIdList.add(loginuser.getMember_id()); // 로그인한 유져 아이디도 넣어줌
        joinMemberIdList.addAll(follow_id_List); // 접속한 모든 사람 아이디 리스트
        
        // 모든 채팅방에서 지금 들어온 채팅 참여자랑 똑같은 partiMemberList로 갖고 있는지 검색
        // 조건을 두개 줘야지 all() 연산자는 특정 요소를 모두 포함만 하면 다 검색되니 갯수도 맞춰준 것
        Query query = new Query(new Criteria().andOperator( // 크리터리아 API 객체를 바로 생성 후 작성
                Criteria.where("partiMemberList").size(joinMemberIdList.size()),  // 배열의 사이즈가 똑같아야함
                Criteria.where("partiMemberList.member_id").all(joinMemberIdList) // 배열이 all(배열)의 요소를 모두 가지는지
        ));
        // 검색(없으면 null, 뽑아져 나온 채팅방은 )
        ChatRoom selectChatRoom = mongoTemplate.findOne(query, ChatRoom.class);
        
        ChatRoom resultChatRoom = null;
        // 초대하려는 모든 사람이 존재하고 중복인원인 채팅방이 검색이 안된다면
        if (existAllMember && selectChatRoom == null) {
            // 받아온 리스트를 파티멤버타입으로 만들어준다.
            List<PartiMember> partiMemberList = new ArrayList<>();
            
            for (int i = 0; i < follow_id_List.size(); i++) {
                partiMemberList.add(PartiMember.createPartiMember(follow_id_List.get(i), follow_name_List.get(i)));
            }
            // 로그인 유저 정보도 넣어준다.
            partiMemberList.add(PartiMember.createPartiMember(loginuser.getMember_id(), loginuser.getMember_name()));
            
            // 방의 기본이름은 빈 배열
            String room_name = "";
            // 저장해야하는 채팅방 정보
            resultChatRoom = ChatRoom.create_chatRoom(room_name ,partiMemberList);
            
            ChatRoom savedChatRoom = chatRoomRepository.save(resultChatRoom); // 채팅방 저장
            
            // 모든 트렌젝션이 끝나고 실행되게 만들어준다. (이 부분은 사람에게 메시지를 보내도록 하고 구현해야함)
            TransactionSynchronizationManager.registerSynchronization(new TransactionSynchronization() {
                @Override
                public void afterCommit() { // 모든 몽고디비 작업이 끝나고 실행되는 구분
                    cacheRepository.getCacheRoomMemberIds(savedChatRoom.getRoomId()); // 캐시에 저장
                    
                    // 개설된 채팅방의 roomId 를 가져오자(
                    String roomId = savedChatRoom.getRoomId();
                    // 로그인한 사람과 채팅방에 속한 인원 이름 리스트
                    follow_name_List.add(loginuser.getMember_name());
                    ChatMessage chatMessage = ChatMessage.enterMessage(roomId, follow_name_List);
                    chatRepository.save(chatMessage); // 메세지 저장
                    for (String joinMember_id  : joinMemberIdList) {
                        // 채팅방 구독중인 모든 사용자에게 메세지 보내기
                        simpMessagingTemplate.convertAndSendToUser(joinMember_id, "/message", chatMessage);
                    }//end of for...
                }
            });//end of TransactionSynchronizationManager.registerSynchronization(new TransactionSynchronization() {}...
            
        } else if(existAllMember && selectChatRoom != null) {
            // 정말 존재하는 사람이고 만약 방이 이미 존재하는 경우 기존의 채팅방으로 이동시켜야 한다.
            resultChatRoom = selectChatRoom;
        }// end of if...
        
        return resultChatRoom;
		
	}//end of public ChatRoom createChatRoom(String loginuser_member_id, String loginuserFolowId) {}...
    
    
    
    // 초대된 사람 채팅방 입장
    @Override
    @Transactional
    public void enterChatRoom(String member_id ,String roomId, List<String> invitedMemberIdList) {
        
        // 초대하려는 사람의 이름이 있는지 검색(프론트를 아주 믿으면 안됨)
        boolean existAllMember = dao.existsAllMembersByIds(invitedMemberIdList, invitedMemberIdList.size());
        
        // 들어온 채팅방이 있는지 확인
        ChatRoom chatroom = chatRoomRepository.findById(roomId)
                .orElseThrow(() -> new IllegalArgumentException("존재하지 않는 채팅방입니다."));
        
        // 방에 로그인한 사람(초대하는 사람)도 있어야하니 검증해주자
        boolean isExistLoginuser = chatroom.getPartiMemberList().stream()
                .anyMatch(partiMember -> partiMember.getMember_id().equals(member_id));
        
        // 이미 방에 있는 사람인지도 확인
        // 채팅방에 이미 존재하는 사람들을 Set 타입의 객체로 만들어준다.(성능 때문, Set은 중복허용이 안된다!)
        Set<String> partiMemberIdList = chatroom.getPartiMemberList().stream()
                .map(PartiMember::getMember_id) // partiMember -> partiMember.getMember_id()와 동일
                .collect(Collectors.toSet()); // Set 타입으로 변환
        
        // 초대하려는 사람이 이미 방에 있는 사람인지 검증(리스트가 나오면 한사람이라도 있는 것이다.)
        // 검색이 안되면 toList() 라서 빈 리스트를 반환! []
        // 처음 방만들기 때는 안되지만 나중에 초대된 사람이 들어왔을 때 지금 멤버에 일치하는 채팅방 중복을 허용했다.
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
            // 업데이트 내용 반환
            ChatRoom updateChatRoom = mongoTemplate.findAndModify(query, update, options,ChatRoom.class);

            if (updateChatRoom != null) {
                ChatMessage chatMessage = ChatMessage.enterMessage(roomId, invitedMemberNameList);
                // 저장
                chatRepository.save(chatMessage);
                
                // 모든 트렌젝션이 끝나고 실행되게 만들어준다.
                TransactionSynchronizationManager.registerSynchronization(new TransactionSynchronization() {
                    @Override
                    public void afterCommit() { // 모든 몽고디비 작업이 끝나고 실행되는 구분
                        // 캐시에 다시 저장 후 출력
                        List<String> allMemberList = cacheRepository.addOrDeleteCacheMemberIds(roomId);
                        
                        // 채팅방 구독중인 모든 사용자에게 메세지 보내기
                        for (String member_id  : allMemberList) {
                            // 채팅방에 새로 들어온 사용자와 기존 채팅방 사람들에게 메세지 보내기
                            simpMessagingTemplate.convertAndSendToUser(member_id, "/message", chatMessage);
                        }//end of for...
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
                    // 캐시에 새로운 내용 덮어쓰기
                    List<String> leftMemberList = cacheRepository.addOrDeleteCacheMemberIds(roomId);
                    
                    // 채팅방 구독중인 모든 사용자에게 메세지 보내기
                    for (String leftMemberId  : leftMemberList) {
                        // 채팅방에 새로 들어온 사용자에게 메세지 보내기
                        simpMessagingTemplate.convertAndSendToUser(leftMemberId, "/message", chatMessage);
                    }//end of for...
                }
            });//end of TransactionSynchronizationManager.registerSynchronization(new TransactionSynchronization() {}...
		}//
	}//end of public void leaveChatRoom(String roomId, String member_id, String member_name) {}...
    
    
    
    // 지금 로그인한 사용자가 채팅방에 들어오거나, 새로운 채팅을 받거나, 채팅방을 떠날 때 마지막으로 읽은 채팅방 시간을 기록
    @Override
    public void updateReadTimesChatRoom(String roomId, String member_id, Instant readTime) {
    
        Query query = new Query(Criteria.where("userId").is(member_id).and("roomId").is(roomId));
        
        Update update = new Update().set("lastReadTimestamp", readTime);
        // 클라이언트가 보낸 정확한 시간으로 업데이트
        mongoTemplate.upsert(query, update, ChatRoomReadStatus.class);
    
    }//end of public void readTimesChatRoom(String roomId, String memberId, LocalDateTime readTime) {}...
    
 
    
    
}//end of class...