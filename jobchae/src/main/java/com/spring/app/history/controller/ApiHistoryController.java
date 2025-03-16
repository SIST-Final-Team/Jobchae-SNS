package com.spring.app.history.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.spring.app.config.AES256_Configuration;
import com.spring.app.history.domain.ProfileViewVO;
import com.spring.app.history.domain.SearchHistoryVO;
import com.spring.app.history.domain.ViewCountVO;
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

    private final AES256_Configuration AES256_Configuration;

    @Autowired
    HistoryService service;

	@Autowired
	MemberService memberService;

    ApiHistoryController(AES256_Configuration AES256_Configuration) {
        this.AES256_Configuration = AES256_Configuration;
    }

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

			if(profileViewVOList.size() > 0) {

				List<String> memberIdList = new ArrayList<>();
				for(ProfileViewVO profileViewVO: profileViewVOList) {
					memberIdList.add(profileViewVO.getProfileViewMemberId());
				}
	
				List<MemberVO> memberList = memberService.getMemberListByMemberId(memberIdList);
	
				return memberList;
			}
			else {
				return new ArrayList<>();
			}
		}
	}

	@Operation(summary = "조회수 통계 조회", description = "한 회원의 조회수 통계 조회")
	@GetMapping("view-count/{viewCountTargetType}/{viewCountType}")
	public List<ViewCountVO> getViewCount(HttpServletRequest request, @PathVariable String viewCountTargetType, @PathVariable String viewCountType) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		// 로그인 여부 확인
		if(loginuser == null) {
			return new ArrayList<>();
		}
		else {
			return service.findViewCountByMemberId(loginuser.getMember_id(), viewCountTargetType, viewCountType);
		}
	}
}
