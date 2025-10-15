package com.spring.app.chatting.controller;

import java.net.http.HttpRequest;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZonedDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.spring.app.chatting.domain.*;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.context.event.EventListener;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.chatting.service.ChatService;
import com.spring.app.member.domain.MemberVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.web.socket.messaging.SessionConnectedEvent;

@RequiredArgsConstructor
@Controller
@RequestMapping("/chat/*") // 클래스 레벨에 추가
public class ChattingController {

	
	private final ChatService chatservice; // 채팅 서비스
	
	
	// 채팅 메인 페이지
	@GetMapping("mainChat")
	@ResponseBody
	public ModelAndView requiredLogin_showChatMainPage(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
        mav.setViewName("chat/chatting");
//		System.out.println("확인용!!! 연결됨 => ");
		return mav;
	}//end of public ModelAndView showChatMainPage(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {}...

 
	// 채팅 메인 페이지 (채팅방 지정)
	@GetMapping("mainChat/{roomId}")
	@ResponseBody
	public ModelAndView requiredLogin_showChatMainPage(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, @PathVariable String roomId) {
        mav.setViewName("chat/chatting");
        mav.addObject("roomId", roomId);
        return mav;
	}//end of public ModelAndView showChatMainPage(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, @PathVariable String roomId) {}...
	
	
	// 채팅방 목록 불러오기 메소드
	@PostMapping("loadChatRoom")
	@ResponseBody
	public List<ChatRoomDTO> loadChatRoom(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser"); // 현재 사용자 VO
		// 현재 로그인 사용자가 참여하고 있는 채팅방 목록 불러오기
		List<ChatRoomDTO> chatRoomDTOList = chatservice.getChatRoomList(loginuser.getMember_id());
		return chatRoomDTOList;
	}//end of public List<ChatRoomDTO> loadChatRoom(HttpServletRequest request) {}...
	
	
	
 	// 여러명 참여 가능한 채팅 채팅방 개설
 	@PostMapping("createchatroom")
 	@ResponseBody                                                   // 로그인한 유저의 친구 아이디 리스트, 친구 이름 리스트
 	public Map<String, String> createChatRoom(HttpServletRequest request, @RequestParam(name= "follow_id_List") List<String> follow_id_List,
											  @RequestParam(name = "follow_name_List") List<String> follow_name_List) {
 		HttpSession session = request.getSession();
 		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser"); // 현재 사용자 VO

 		// 채팅방 만들기 // 친구 아이디리스트, 이름리스트과 나의 정보를 넣어야한다.
 		ChatRoom chat_room = chatservice.createChatRoom(loginuser, follow_id_List, follow_name_List);
 		
		Map<String, String> map = new HashMap<>();
		map.put("roomId", chat_room.getRoomId()); // 이게 오브젝트아디티 타입을 16진수 스트링을 변환하는 공식 API
 		return map;
 	}//end of public ModelAndView createChatRoom(HttpServletRequest request, ModelAndView mav) {}...
	
    
    // 웹소켓 구독 및 채팅 전송
    @MessageMapping("{roomId}") // 해당 url 요청은 구독처리
    // @SendTo("/room/{roomId}") // 해당 url 요청은 구독자에게 전송 및 채팅 저장
    public ChatMessage chat(@DestinationVariable String roomId, ChatMessage chat) {
        // 채팅 메시지 저장 및 반환
        // System.out.println("만약 여기서 터지는 것이 맞다면???");
        // System.out.println("시작하자마자 방번호 => "+ roomId); // 시작하자마자 방번호 => readTimes 왜 이게 나오지
        chat.updateRoomId(roomId);
        chat.updateReadMembers(chat.getSenderId()); // TODO 아무래도 입장메세지가 발송되고
        chat.updateSendDate(Instant.now());
        // System.out.println("확인용 채팅 들어오기"+chat.getMessage());
        return chatservice.saveChat(chat);
    }
    
    
	// 채팅방의 채팅 내역 조회
	@PostMapping("load_chat_history/{roomId}")
	@ResponseBody
	public ChatMessageDTO loadChatHistory(HttpServletRequest request ,@PathVariable String roomId,
                                          @RequestBody Map<String, String> loadChatStartMap) {
        // 세션에서 아이디 가져오기
        HttpSession session = request.getSession();
        MemberVO loginuser = (MemberVO) session.getAttribute("loginuser"); // 현재 사용자 VO
        String member_id = loginuser.getMember_id();
        
        String loadChatStart = loadChatStartMap.get("loadChatStart"); // 불러올 채팅의 시작인덱스
        return chatservice.loadChatHistory(roomId, member_id, loadChatStart);
	}//end of public List<ChatMessage> loadChatHistory(@PathVariable String roomId) {}...
    
    
    // 지금 로그인한 사용자가 채팅방에 들어오거나, 새로운 채팅을 받거나, 채팅방을 떠날 때 마지막으로 읽은 채팅방 시간을 기록
    //(@Payload 는 스프링이 받아온 json 객체(메세지 본문)를 메소드의 파리미터 전체에 매핑하려고 해서 받아줄 객체를 명시하는 용도다.)
    @MessageMapping("{roomId}/chatRoomReadTimes")
    public void readTimesChatRoom(@DestinationVariable String roomId, ReadStatusUpdateRequest readRequest,
                                  StompHeaderAccessor accessor) {
        // 웹소캣 헤더에서 로그인한 사용자 아이디 가져오기(이게 더 안전하고 빠르다)
        String member_id = (String) accessor.getSessionAttributes().get("member_id");
        
        // System.out.println("웹소캣헤더에서 가져온 아이디 => "+ member_id);
        // System.out.println("들어온 시간이 안보여! => "+ readRequest.getLastReadTimestamp());
        // System.out.println("들어온 채팅방번호 => " + roomId);
        
        // Instant으로 변환
        Instant readTime = Instant.parse(readRequest.getLastReadTimestamp());
        // System.out.println("변환된 시간 => "+readTime);
        
        if (member_id != null) {
            chatservice.updateReadTimesChatRoom(roomId, member_id, readTime);
        }
    }//end of public void messageReadChack(@DestinationVariable String roomId, HttpServletRequest request) {}...
    
    
    // 채팅페이지를 닫으면 마지막으로 읽고 있는 채팅방의 시간을 기록
    @PostMapping("readTimesChatRoomOnLeave")
    public void readTimesChatRoomOnLeave(HttpServletRequest request, @RequestBody Map<String, String> lastReadTimesMap) {
        HttpSession session = request.getSession();
        MemberVO loginuser = (MemberVO) session.getAttribute("loginuser"); // 현재 사용자 VO
        // 데이터 전송 성공 시
        if (loginuser != null && lastReadTimesMap != null) {
            String roomId = lastReadTimesMap.get("roomId");
            String member_id = loginuser.getMember_id();
            // LocalDateTime으로 변환
            Instant readTime = Instant.parse(lastReadTimesMap.get("timestamp"));
            // System.out.println("변환된 시간 => "+readTime);
            chatservice.updateReadTimesChatRoom(roomId, member_id, readTime);
        }
    }//end of public void readTimesChatRoomOnLeave(HttpServletRequest request, @RequestBody Map<String, String> lastReadTimesMap) {}...
    
    
    
    
    // 채팅방 초대 받으면 입장하고 메세지 보여주기 메소드
    @PostMapping("enterChatRoom")
    @ResponseBody
    public void enterChatRoom(HttpServletRequest request,@RequestParam("roomId") String roomId,
                              @RequestParam("invited_member_id_List") List<String> invitedMemberIdList) {
        HttpSession session = request.getSession();
        MemberVO loginuser = (MemberVO) session.getAttribute("loginuser"); // 현재 사용자 VO
        chatservice.enterChatRoom(loginuser.getMember_id(), roomId, invitedMemberIdList);
    }//
    
    
    // 채팅방 나가기
    @PostMapping("leaveChatRoom")
    @ResponseBody
    public void leaveChatRoom(HttpServletRequest request, @RequestParam("roomId") String roomId) {
        HttpSession session = request.getSession();
        MemberVO loginuser = (MemberVO) session.getAttribute("loginuser"); // 현재 사용자 VO
        chatservice.leaveChatRoom(roomId, loginuser.getMember_id(), loginuser.getMember_name());
    }//end of public void leaveChatRoom(@RequestParam("roomId") String roomId, @RequestParam("member_id") String member_id) {}...
    
    
	
	
	
}//end of class...
