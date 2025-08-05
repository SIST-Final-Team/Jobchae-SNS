package com.spring.app.chatting.controller;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.http.HttpServletResponse;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.chatting.domain.ChatMessage;
import com.spring.app.chatting.domain.ChatRoom;
import com.spring.app.chatting.domain.ChatRoomDTO;
import com.spring.app.chatting.service.ChatService;
import com.spring.app.member.domain.MemberVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

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
	
	
	
 	// 여러명 참여 가능한 채팅 채팅방 개설(일단 1대1 채팅방 개설을 만들고 여러명으로 수정해야함)
 	@PostMapping("createchatroom")
 	@ResponseBody                                                   // 로그인한 유저의 친구 아이디 리스트, 친구 이름 리스트
 	public Map<String, String> createChatRoom(HttpServletRequest request, @RequestParam(name= "follow_id_List") List<String> follow_id_List,
											  @RequestParam(name = "follow_name_List") List<String> follow_name_List) {
		
 		HttpSession session = request.getSession();
 		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser"); // 현재 사용자 VO

 		// 채팅방 만들기 // 친구 아이디리스트, 이름리스트과 나의 정보를 넣어야한다.
 		ChatRoom chat_room = chatservice.createChatRoom(loginuser, follow_id_List, follow_name_List);
 		// 여기까지 했다!!
		Map<String, String> map = new HashMap<>();
		map.put("roomId", chat_room.getRoomId());
 		return map;
 	}//end of public ModelAndView createChatRoom(HttpServletRequest request, ModelAndView mav) {}...
	
	
	
	 // // 1대1 채팅방 접속
	 // @PostMapping("join")
	 // @ResponseBody
	 // public ModelAndView joinChatRoom(@RequestParam String room_id, ModelAndView mav) {
	 // 	MemberVO login_member_vo = detail.MemberDetail(); // 현재 사용자 VO
	 //
	 // 	ChatRoom chat_room = chatService.getChatRoom(room_id); // 채팅방 정보 조회
	 //
	 // 	// 채팅방 조회 실패
	 // 	if (chat_room == null) {
	 // 		log.error("[ERROR] : ChatrRoom 조회 실패");
	 // 		throw new BusinessException(ExceptionCode.JOIN_CHATROOM_FAILD);
	 // 	}
	 //
	 // 	// 채팅방의 주제 상품 정보 조회
	 // 	String pk_product_no = chat_room.getProductNo();
	 // 	Map<String, String> product_map = productService.getProductInfo(pk_product_no);
	 //
	 // 	mav.addObject("login_member_vo", login_member_vo); // 로그인 회원 정보
	 // 	mav.addObject("product_map", product_map); // 채팅 주제 상품 정보
	 // 	mav.addObject("chat_room", chat_room); // 채팅방 정보
	 //
	 // 	mav.setViewName("chat/chat");
	 // 	return mav;
	 // }// end of  public ModelAndView joinChatRoom(@RequestParam String room_id, ModelAndView mav) {}...
	
	
	
	
	
	
	
	
	// 웹소켓 구독 및 채팅 전송 
	@MessageMapping("{roomId}") // 해당 url 요청은 구독처리
	@SendTo("/room/{roomId}") // 해당 url 요청은 구독자에게 전송 및 채팅 저장
	public ChatMessage chat(@DestinationVariable String roomId, ChatMessage chat) {
		// 채팅 메시지 저장 및 반환
		chat.updateRoomId(roomId);
		chat.updateReadMembers(chat.getSenderId());
		chat.updateSendDate(LocalDateTime.now());
		System.out.println("확인용 채팅 들어오기"+chat.getMessage());
		return chatservice.saveChat(chat);
	}








	// 채팅방의 채팅 내역 조회
	@PostMapping("load_chat_history/{roomId}")
	@ResponseBody
	public List<ChatMessage> loadChatHistory(@PathVariable String roomId) {
		return chatservice.loadChatHistory(roomId);
	}//end of public List<ChatMessage> loadChatHistory(@PathVariable String roomId) {}...
    
    
    
    // 채팅방 나가기
    @PostMapping("leaveChatRoom")
    @ResponseBody
    public void leaveChatRoom(HttpServletRequest request, @RequestParam("roomId") String roomId) {
        
        HttpSession session = request.getSession();
        MemberVO loginuser = (MemberVO) session.getAttribute("loginuser"); // 현재 사용자 VO
        chatservice.leaveCahtRoom(roomId, loginuser.getMember_id(), loginuser.getMember_name());
        
    }//end of public void leaveChatRoom(@RequestParam("roomId") String roomId, @RequestParam("member_id") String member_id) {}...
	
	
	
	
	
}//end of class...
