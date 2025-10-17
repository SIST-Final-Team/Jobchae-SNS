package com.spring.app.alarm.controller;

import com.spring.app.alarm.domain.AlarmData;
import com.spring.app.alarm.domain.AlarmVO;
import com.spring.app.board.domain.BoardVO;
import com.spring.app.board.model.BoardDAO;
import com.spring.app.follow.domain.FollowEntity;
import com.spring.app.follow.repository.FollowRepository;
import com.spring.app.follow.service.FollowService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import com.spring.app.alarm.service.AlarmService;
import com.spring.app.member.domain.MemberVO;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collector;

// 예를 들어, user001에게 개인 알림을 보내고자 한다면:
//messagingTemplate.convertAndSendToUser(
//    		"user001",              // 메시지를 받을 대상 사용자
//			"/queue/notifications", // 대상 큐 (여기서 'queue'는 메시지를 받을 채널 이름)
//			"새로운 답글이 달렸습니다!" // 전송할 메시지 내용
//);
// js에서는 이렇게 구독합니다:
// 예를 들어, user001 사용자는 웹소켓 연결 후 개인 메시지를 이렇게 구독합니다:
//stompClient.subscribe('/user/queue/notifications', function(message) {
//	console.log("개인 알림: " + message.body);
//});


@RestController
@RequestMapping(value="api/alarm/")
public class ApiAlarmController {

	private final SimpMessagingTemplate messagingTemplate;

	@Autowired
	private AlarmService alarmService;

	@Autowired
	private FollowService followService;
    @Autowired
    private BoardDAO boardDAO;

	@Autowired
	public ApiAlarmController(SimpMessagingTemplate template) {
		this.messagingTemplate = template;
	}
	//로그 처리를 위한 변수
	private static final Logger logger = LoggerFactory.getLogger(ApiAlarmController.class);
	
	
//	알람 읽음 변경 메서드
	@PutMapping("updateAlarmRead/{notification_no}")
	public ResponseEntity<AlarmVO> updateAlarmRead(@PathVariable String notification_no, HttpServletRequest request){
		//TODO
		//MemberVO user001 = new MemberVO();
		//user001.setMember_id("user001");
		HttpSession session = request.getSession();
		MemberVO member = (MemberVO) session.getAttribute("loginuser");
		AlarmVO alarm = alarmService.updateAlarmRead(member, notification_no);
		ResponseEntity<AlarmVO> response = new ResponseEntity<>(alarm, HttpStatus.OK);

		return response;
	}
	
//	알람 입력 메서드
	@PostMapping("insertAlarm")
	public ResponseEntity<AlarmVO> insertAlarm(HttpServletRequest request){
		//TODO 부분 완성
		//MemberVO user001 = new MemberVO();
		//user001.setMember_id("user001");
		HttpSession session = request.getSession();
		MemberVO member = (MemberVO) session.getAttribute("loginuser");
		try {
			//알림 삽입
			AlarmVO alarm = alarmService.insertAlarm2(member, AlarmVO.NotificationType.COMMENT);

			//알림을 구독하고 있는 사용자에게 알림 전송
			messagingTemplate.convertAndSend("/topic/alarm", alarm);

			//알림 객체 반환
			return ResponseEntity.ok(alarm);
		}
		catch (IllegalArgumentException e) {
			//400오류를 반환
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
		}


	}
	
//	알람 삭제 메서드
	@DeleteMapping("deleteAlarm/{notificationNo}")
	public ResponseEntity<AlarmVO> deleteAlarm(@PathVariable String notificationNo, HttpServletRequest request){
		//TODO 미완성

		ResponseEntity<AlarmVO> response = null;

		//MemberVO user001 = new MemberVO();
		//user001.setMember_id("user001");
		HttpSession session = request.getSession();
		MemberVO member = (MemberVO) session.getAttribute("loginuser");
		try {
			AlarmVO deletedAlarm = alarmService.deleteAlarm(member,notificationNo);
			response = ResponseEntity.ok(deletedAlarm);
			return response;
		}
		catch (IllegalArgumentException e) {
			//400오류를 반환
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
		}
	}
	
//	알림 조회 메서드
	@GetMapping("selectAlarmList/{pageNumber}")
	public ResponseEntity<Map> selectAlarmList(@PathVariable String pageNumber, HttpServletRequest request){

//		MemberVO user001 = new MemberVO();
//		user001.setMember_id("user001");
		HttpSession session = request.getSession();
		MemberVO member = (MemberVO) session.getAttribute("loginuser");
		int pageNo = Integer.parseInt(pageNumber);
		Map<String, Object> resultMap = alarmService.selectAlarmList(member, pageNo);
//		logger.info("alarmList: " + resultMap);
		ResponseEntity<Map> response = ResponseEntity.ok(resultMap);
		return response;
	}

	//댓글 알림 조회
	@GetMapping("selectAlarmListByComment/{pageNumber}")
	public ResponseEntity<Map> selectAlarmListByComment(@PathVariable String pageNumber, HttpServletRequest request){

//		MemberVO user001 = new MemberVO();
//		user001.setMember_id("user001");
		HttpSession session = request.getSession();
		MemberVO member = (MemberVO) session.getAttribute("loginuser");
		int pageNo = Integer.parseInt(pageNumber);
		Map<String, Object> resultMap = alarmService.selectAlarmListByType(member, pageNo, AlarmVO.NotificationType.COMMENT);
//		logger.info("alarmList: " + resultMap);
		ResponseEntity<Map> response = ResponseEntity.ok(resultMap);
		return response;
	}

	//좋아요 알림 조회
	@GetMapping("selectAlarmListByLike/{pageNumber}")
	public ResponseEntity<Map> selectAlarmListByLike(@PathVariable String pageNumber, HttpServletRequest request){

//		MemberVO user001 = new MemberVO();
//		user001.setMember_id("user001");
		HttpSession session = request.getSession();
		MemberVO member = (MemberVO) session.getAttribute("loginuser");
		int pageNo = Integer.parseInt(pageNumber);
		Map<String, Object> resultMap = alarmService.selectAlarmListByType(member, pageNo, AlarmVO.NotificationType.LIKE);
//		logger.info("alarmList: " + resultMap);
		ResponseEntity<Map> response = ResponseEntity.ok(resultMap);
		return response;
	}

	//팔로우 게시물 알림 조회
	@GetMapping("selectAlarmListByFollowPost/{pageNumber}")
	public ResponseEntity<Map> selectAlarmListByFollowPost(@PathVariable String pageNumber, HttpServletRequest request){

//		MemberVO user001 = new MemberVO();
//		user001.setMember_id("user001");
		HttpSession session = request.getSession();
		MemberVO member = (MemberVO) session.getAttribute("loginuser");
		int pageNo = Integer.parseInt(pageNumber);
		Map<String, Object> resultMap = alarmService.selectAlarmListByType(member, pageNo, AlarmVO.NotificationType.FOLLOWER_POST);
//		logger.info("alarmList: " + resultMap);
		ResponseEntity<Map> response = ResponseEntity.ok(resultMap);
		return response;
	}


	@GetMapping("testLike")
	public ResponseEntity<AlarmVO> test(HttpServletRequest request) {

		//현재 로그인된 사람
		//		MemberVO user001 = new MemberVO();
//		user001.setMember_id("user001");
		HttpSession session = request.getSession();
		MemberVO member = (MemberVO) session.getAttribute("loginuser");
		//받는 사람
		String targetId = "user001";

		//알림 데이터
		AlarmData alarmData = new AlarmData();
		alarmData.setBoardId("52");
		alarmData.setBoardContent("<p>글이 어떻게</p>");

		AlarmVO alarm = alarmService.insertAlarm(member, targetId, AlarmVO.NotificationType.LIKE, alarmData);

		return ResponseEntity.ok(alarm);
	}

	@GetMapping("testComment")
	public ResponseEntity<AlarmVO> test2(HttpServletRequest request) {

		HttpSession session = request.getSession();
		//현재 로그인된 사람
		MemberVO member = (MemberVO)session.getAttribute("loginuser");

		System.out.println("멤버는 "+ member);

		//받는 사람
		String targetId = "user001";

		//알림 데이터
		AlarmData alarmData = new AlarmData();
		alarmData.setCommentId("69");
		BoardVO board = boardDAO.findOneBoardByBoardNo("241");
		alarmData.setBoardId("241");
		alarmData.setBoardContent(board.getBoard_content());

		AlarmVO alarm = alarmService.insertAlarm(member, targetId, AlarmVO.NotificationType.COMMENT, alarmData);

		return ResponseEntity.ok(alarm);
	}

	@GetMapping("testFollow")
	public ResponseEntity<AlarmVO> test3(HttpServletRequest request) {

		//현재 로그인된 사람
		//		MemberVO user001 = new MemberVO();
//		user001.setMember_id("user001");
		HttpSession session = request.getSession();
		MemberVO member = (MemberVO) session.getAttribute("loginuser");
		//받는 사람
		String targetId = "user001";

		//알림 데이터
		AlarmData alarmData = new AlarmData();

		AlarmVO alarm = alarmService.insertAlarm(member, targetId, AlarmVO.NotificationType.FOLLOW, alarmData);

		return ResponseEntity.ok(alarm);
	}

	@GetMapping("testFollowerPost")
	public ResponseEntity<List<AlarmVO>> test4(HttpServletRequest request) {

		//현재 로그인된 사람
		//		MemberVO user001 = new MemberVO();
//		user001.setMember_id("user001");
		HttpSession session = request.getSession();
		MemberVO member = (MemberVO) session.getAttribute("loginuser");



		//받는 사람

		List<FollowEntity> followerList = new ArrayList<>();
//		followerList.addAll(List.of("user001", "user003", "dltnstls89"));
		followerList = followService.getFollowers(member.getMember_id());


		//알림 데이터
		AlarmData alarmData = new AlarmData();
		alarmData.setBoardId("52");
		alarmData.setBoardContent("<p>글이 어떻게</p>");
		List<AlarmVO> alarmList = new ArrayList<>();

		followerList.stream().forEach(follow -> {
			AlarmVO alarm = alarmService.insertAlarm(member, follow.getFollowerId(), AlarmVO.NotificationType.FOLLOWER_POST, alarmData);
			alarmList.add(alarm);
		});

		return ResponseEntity.ok(alarmList);
	}

	//알림 개수 조회
	@GetMapping("selectAlarmCount")
	public int selectAlarmCount(HttpServletRequest request) {
		HttpSession session = request.getSession();
		MemberVO member = (MemberVO) session.getAttribute("loginuser");
		int count = alarmService.selectUnreadAlarmCount(member);
		return count;
	}

	
//	시퀀스 조회 메서드
//	@GetMapping("seq")
//	@ResponseBody
//	public int selectAlarmSeq() {
//		int seq = alarmService.selectSeq();
//		return seq;
//	}
	
}
