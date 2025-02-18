package com.spring.app.alarm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.app.alarm.service.AlarmService;
import com.spring.app.member.domain.MemberVO;


@Controller
@RequestMapping(value="api/alarm/*")
public class ApiAlarmController {

	@Autowired
	private AlarmService alarmService;
	
	
//	알람 읽음 변경 메서드
	@GetMapping("updateAlarmRead/{notification_no}")
	@ResponseBody
	public String updateAlarmRead(@PathVariable String notification_no){
		
		return "updateAlarmRead";
	}
	
//	알람 입력 메서드
	@GetMapping("insertAlarm/{notification_no}")
	@ResponseBody
	public int insertAlarm(@PathVariable String notification_no){
		
		MemberVO user001 = new MemberVO();
		user001.setMember_id("user001");
		
		int result = alarmService.insertAlarm(user001);
		
		return result;
	}
	
//	알람 삭제 메서드
	@GetMapping("deleteAlarm/{notification_no}")
	@ResponseBody
	public int deleteAlarm(@PathVariable String notification_no){
		
		
		return 1;
	}
	
}
