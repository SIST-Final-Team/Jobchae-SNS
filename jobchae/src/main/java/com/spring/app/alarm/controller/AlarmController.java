package com.spring.app.alarm.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
@RequestMapping("/alarm")
public class AlarmController {

	
	
	@GetMapping("{member_id}")
	public ModelAndView requiredLogin_selectAlarm(HttpServletRequest request, HttpServletResponse response, @PathVariable String member_id ){
		ModelAndView mav = new ModelAndView();
		mav.setViewName("Alarm/alarmPage");
		return mav;
	}

	@GetMapping("test/{member_id}")
	public String alarmTest(@PathVariable String member_id){
		
		return "Alarm/alarmtest";
	}
	
	@GetMapping("test2/{member_id}")
	public String realTimeAlarmTest(@PathVariable String member_id){
		
		return "Alarm/realtimealarmtest";
	}

	@GetMapping("test3")
	public String alarmTest(){

		return "Alarm/alarm";
	}

	
	
}
