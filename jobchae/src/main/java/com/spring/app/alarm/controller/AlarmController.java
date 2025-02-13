package com.spring.app.alarm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value="/alarm/*")
public class AlarmController {
	
	@GetMapping("selectAlarm/{userid}")
	@ResponseBody
	public String selectAlarm(@PathVariable String userid){
		
		return userid;
	}
	
	@GetMapping("updateAlarmRead")
	@ResponseBody
	public String updateAlarmRead(){
		
		return "updateAlarmRead";
	}
	
	@GetMapping("deleteAlarm")
	@ResponseBody
	public String deleteAlarm(){
		
		return "deleteAlarm";
	}
	
}
