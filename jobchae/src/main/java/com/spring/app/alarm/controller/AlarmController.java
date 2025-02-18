package com.spring.app.alarm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;



@Controller
public class AlarmController {

	
	
	@GetMapping("/test")
	@ResponseBody
	public String selectAlarm(){
		
		return "alarm";
	}
	
	
}
