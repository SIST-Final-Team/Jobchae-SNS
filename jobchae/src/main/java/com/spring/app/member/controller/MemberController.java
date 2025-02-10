package com.spring.app.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.member.Service.MemberService;

@Controller
@RequestMapping(value="/member/*")
public class MemberController {

	
	@Autowired
	MemberService service;
	
	// 로그인 폼 페이지 요청
//	@GetMapping("login")
//	public ModelAndView login(ModelAndView mav) {
//		mav.setViewName(" /login/loginform"); // view 단 페이지
//		//
//		return mav;
//
//	}// end of public String getMethodName() {}...
	
	
	
	
	
	
	
	
	
	
	
}//end of class...



























