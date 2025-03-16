package com.spring.app.index.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/*")
public class IndexController {
	
	@GetMapping("/")
	public String main() {
		return "redirect:/index";
	}
	
	@GetMapping("index")
	public String index(HttpServletRequest request) {

		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginuser") == null) { // 로그인하지 않은 경우 로그인 페이지로 이동
			return "redirect:member/login";
		}
		else { // 로그인 한 경우 피드로 이동
			return "redirect:board/feed";
		}
	}
}
