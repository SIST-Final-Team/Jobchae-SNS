package com.spring.app.alarm.controller;

import com.spring.app.alarm.domain.AlarmVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import com.spring.app.alarm.service.AlarmService;
import com.spring.app.member.domain.MemberVO;

import java.util.List;
import java.util.Map;

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
@CrossOrigin(origins = "*")
public class ApiAlarmController {

	private final SimpMessagingTemplate messagingTemplate;

	@Autowired
	private AlarmService alarmService;
	@Autowired
	public ApiAlarmController(SimpMessagingTemplate template) {
		this.messagingTemplate = template;
	}
	//로그 처리를 위한 변수
	private static final Logger logger = LoggerFactory.getLogger(ApiAlarmController.class);
	
	
//	알람 읽음 변경 메서드
	@PutMapping("updateAlarmRead/{notification_no}")
	public ResponseEntity<AlarmVO> updateAlarmRead(@PathVariable String notification_no){
		//TODO
		MemberVO member = new MemberVO();
		member.setMember_id("user001");
		AlarmVO alarm = alarmService.updateAlarmRead(member, notification_no);
		ResponseEntity<AlarmVO> response = new ResponseEntity<>(alarm, HttpStatus.OK);

		return response;
	}
	
//	알람 입력 메서드
	@PostMapping("insertAlarm")
	public ResponseEntity<AlarmVO> insertAlarm(){
		//TODO 부분 완성
		MemberVO user001 = new MemberVO();
		user001.setMember_id("user001");
		try {
			//알림 삽입
			AlarmVO alarm = alarmService.insertAlarm2(user001, AlarmVO.NotificationType.COMMENT);

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
	public ResponseEntity<AlarmVO> deleteAlarm(@PathVariable String notificationNo){
		//TODO 미완성

		ResponseEntity<AlarmVO> response = null;

		MemberVO user001 = new MemberVO();
		user001.setMember_id("user001");
		try {
			AlarmVO deletedAlarm = alarmService.deleteAlarm(user001,notificationNo);
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
	public ResponseEntity<Map> selectAlarmList(@PathVariable String pageNumber){

		MemberVO user001 = new MemberVO();
		user001.setMember_id("user001");
		int pageNo = Integer.parseInt(pageNumber);
		Map<String, Object> resultMap = alarmService.selectAlarmList(user001, pageNo);
//		logger.info("alarmList: " + resultMap);
		ResponseEntity<Map> response = ResponseEntity.ok(resultMap);
		return response;
	}

	
//	시퀀스 조회 메서드
//	@GetMapping("seq")
//	@ResponseBody
//	public int selectAlarmSeq() {
//		int seq = alarmService.selectSeq();
//		return seq;
//	}
	
}
