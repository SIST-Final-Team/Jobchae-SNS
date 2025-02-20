package com.spring.app.alarm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;



@Controller
@RequestMapping(value="alarm/*")
public class AlarmController {

	
	
	@GetMapping("/alarm/{member_id}")
	public String selectAlarm(@PathVariable String member_id){
		
		return "Alarm/alarm";
	}
	
	
}
