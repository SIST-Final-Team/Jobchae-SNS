package com.spring.app.alarm.controller;

import com.spring.app.alarm.domain.AlarmVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.spring.app.alarm.service.AlarmService;
import com.spring.app.member.domain.MemberVO;


@RestController
@RequestMapping(value="api/alarm/")
public class ApiAlarmController {

	@Autowired
	private AlarmService alarmService;
	
	
//	알람 읽음 변경 메서드
	@GetMapping("updateAlarmRead/{notification_no}")
	public String updateAlarmRead(@PathVariable String notification_no){
		//TODO
		return "updateAlarmRead";
	}
	
//	알람 입력 메서드
	@GetMapping("insertAlarm")
	public ResponseEntity<AlarmVO> insertAlarm(){
		//TODO 부분 완성
		MemberVO user001 = new MemberVO();
		user001.setMember_id("user001");
		try {
			AlarmVO alarm = alarmService.insertAlarm(user001, AlarmVO.NotificationType.COMMENT);

			return ResponseEntity.ok(alarm);
		}
		catch (IllegalArgumentException e) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
		}


	}
	
//	알람 삭제 메서드
	@GetMapping("deleteAlarm/{notification_no}")
	public int deleteAlarm(@PathVariable String notification_no){
		//TODO 미완성

		return 1;
	}
	
//	알림 조회 메서드
	@GetMapping("selectAlarmList")
	public String selectAlarmList() {


		return "";
	}
	
//	시퀀스 조회 메서드
//	@GetMapping("seq")
//	@ResponseBody
//	public int selectAlarmSeq() {
//		int seq = alarmService.selectSeq();
//		return seq;
//	}
	
}
