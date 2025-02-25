package com.spring.app.alarm.controller;

import org.springframework.beans.factory.annotation.Autowired;
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
@RequestMapping(value="api/alarm/*")
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
	public int insertAlarm(){
		//TODO 부분 완성
		MemberVO user001 = new MemberVO();
		user001.setMember_id("user001");
		
//		int result = alarmService.insertAlarm(user001);
		
		return 0;
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
		//TODO 미완성
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
