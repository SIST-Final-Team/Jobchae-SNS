package com.spring.app.alarm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;



@Controller
@RequestMapping("/alarm")
public class AlarmController {

	
	
	@GetMapping("{member_id}")
	public String selectAlarm(@PathVariable String member_id){
		
		return "Alarm/alarm";
	}

	@GetMapping("test/{member_id}")
	public String alarmTest(@PathVariable String member_id){
		
		return "Alarm/alarmtest";
	}
	
	@GetMapping("test2/{member_id}")
	public String realTimeAlarmTest(@PathVariable String member_id){
		
		return "Alarm/realtimealarmtest";
	}
	
	
}
