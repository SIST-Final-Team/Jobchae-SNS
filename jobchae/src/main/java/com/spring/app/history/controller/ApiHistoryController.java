package com.spring.app.history.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.spring.app.history.domain.ProfileViewVO;
import com.spring.app.history.domain.SearchHistoryVO;
import com.spring.app.history.service.HistoryService;
import com.spring.app.member.domain.MemberVO;
import com.spring.app.member.service.MemberService;

import io.swagger.v3.oas.annotations.Operation;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RestController
@RequestMapping(value="/history/*")
public class ApiHistoryController {

    @Autowired
    HistoryService service;

	@Autowired
	MemberService memberService;

	@Operation(summary = "검색 기록 조회", description = "한 회원의 검색 기록 조회")
	@GetMapping("search")
	public List<SearchHistoryVO> getSearchHistory(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		// 로그인 여부 확인
		if(loginuser == null) {
			return new ArrayList<>();
		}
		else {
			return service.findSearchHistoryByMemberId(loginuser.getMember_id());
		}
	}

	@Operation(summary = "프로필 조회 기록 조회", description = "한 회원의 프로필 조회 기록 조회")
	@GetMapping("profile")
	public List<MemberVO> getProfileView(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		// 로그인 여부 확인
		if(loginuser == null) {
			return new ArrayList<>();
		}
		else {
			List<ProfileViewVO> profileViewVOList = service.findProfileViewByMemberId(loginuser.getMember_id());

			List<String> memberIdList = new ArrayList<>();
			for(ProfileViewVO profileViewVO: profileViewVOList) {
				memberIdList.add(profileViewVO.getProfileViewMemberId());
			}

			System.out.println(memberIdList.get(0));
			System.out.println(memberIdList.get(1));

			List<MemberVO> memberList = memberService.getMemberListByMemberId(memberIdList);
			
			System.out.println(memberList.size());

			return memberList;
		}
	}
}
