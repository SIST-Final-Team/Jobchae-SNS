package com.spring.app.search.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.spring.app.member.domain.MemberVO;
import com.spring.app.search.domain.SearchBoardVO;
import com.spring.app.search.service.SearchService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping(value="/api/search/*")
@RestController
public class ApiSearchController {
	
	@Autowired
	SearchService service;
	
	@GetMapping("board")
	public List<SearchBoardVO> getMethodName(HttpServletRequest request, @RequestParam Map<String, String> params) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		// 로그인 여부 확인
		if(loginuser != null) {
			params.put("login_member_id", loginuser.getMember_id());
		}
		else {
			params.put("login_member_id", null);
		}
		
		if(params.get("start") == null) {
			params.put("start", "1");
			params.put("end", "4");
		}
		
		return service.searchBoardByContent(params);
	}
	

}
