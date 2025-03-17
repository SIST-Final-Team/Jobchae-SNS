package com.spring.app.search.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.spring.app.member.domain.MemberVO;
import com.spring.app.search.domain.SearchBoardVO;
import com.spring.app.search.domain.SearchCompanyVO;
import com.spring.app.search.domain.SearchMemberVO;
import com.spring.app.search.service.SearchService;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping(value="/api/search/*")
@RestController
public class ApiSearchController {
	
	@Autowired
	SearchService service;
	
	@Operation(summary = "글 검색", description = "글 내용으로 글 검색")
    @Parameter(name = "params", description = "검색을 위한 Map")
	@GetMapping("board")
	public List<SearchBoardVO> searchBoard(HttpServletRequest request, @RequestParam Map<String, String> params) {
		
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
	
	@Operation(summary = "회원 검색", description = "회원명으로 회원 검색")
    @Parameter(name = "params", description = "검색을 위한 Map")
	@GetMapping("member")
	public List<SearchMemberVO> searchMember(HttpServletRequest request, @RequestParam Map<String, Object> params) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		// 로그인 여부 확인
		if(loginuser != null) {
			params.put("login_member_id", loginuser.getMember_id());
		}
		else {
			params.put("login_member_id", null);
		}
		
		// 현재 회사 일련번호 배열
		if(params.get("arr_fk_company_no") != null) {
			String[] arr_fk_company_no = ((String) params.get("arr_fk_company_no")).split("\\,");
			params.put("arr_fk_company_no", arr_fk_company_no);
		}
		else {
			params.put("arr_fk_company_no", null);
		}
		
		// 현재 학력 일련번호 배열
		// if(params.get("fk_school_no") != null) {
		// 	String[] arr_fk_school_no = ((String) params.get("fk_school_no")).split("\\,");
		// 	params.put("arr_fk_school_no", arr_fk_school_no);
		// }
		// else {
		// 	params.put("arr_fk_school_no", null);
		// }
		
		// 보유기술 일련번호 배열
		if(params.get("arr_fk_skill_no") != null) {
			String[] arr_fk_skill_no = String.valueOf(params.get("arr_fk_skill_no")).split("\\,");
			params.put("arr_fk_skill_no", arr_fk_skill_no);
		}
		else {
			params.put("arr_fk_skill_no", null);
		}
		
		// 지역 일련번호 배열
		if(params.get("arr_fk_region_no") != null) {
			String[] arr_fk_region_no = ((String) params.get("arr_fk_region_no")).split("\\,");
			params.put("arr_fk_region_no", arr_fk_region_no);
		}
		else {
			params.put("arr_fk_region_no", null);
		}
		
		if(params.get("start") == null) {
			params.put("start", "1");
			params.put("end", "4");
		}
		
		return service.searchMemberByName(params);
	}
	
	@Operation(summary = "회사 검색", description = "회사명으로 회사 검색")
    @Parameter(name = "params", description = "검색을 위한 Map")
	@GetMapping("company")
	public List<SearchCompanyVO> searchCompany(HttpServletRequest request, @RequestParam Map<String, Object> params) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		// 로그인 여부 확인
		if(loginuser != null) {
			params.put("login_member_id", loginuser.getMember_id());
		}
		else {
			params.put("login_member_id", null);
		}
		
		// 업종 일련번호 배열
		if(params.get("arr_fk_industry_no") != null) {
			String[] arr_fk_industry_no = ((String) params.get("arr_fk_industry_no")).split("\\,");
			params.put("arr_fk_industry_no", arr_fk_industry_no);
		}
		
		// 회사 규모 배열
		if(params.get("arr_company_size") != null) {
			String[] arr_company_size = ((String) params.get("arr_company_size")).split("\\,");
			params.put("arr_company_size", arr_company_size);
		}
		
		// 지역 일련번호 배열
		if(params.get("arr_fk_region_no") != null) {
			String[] arr_fk_region_no = ((String) params.get("arr_fk_region_no")).split("\\,");
			params.put("arr_fk_region_no", arr_fk_region_no);
		}
		
		if(params.get("start") == null) {
			params.put("start", "1");
			params.put("end", "4");
		}
		
		return service.searchCompanyByName(params);
	}
	
	@Operation(summary = "글 1개 조회", description = "글 번호로 글 1개 조회")
	@GetMapping("board/{board_no}")
	public List<SearchBoardVO> getBoardOne(HttpServletRequest request, @PathVariable String board_no) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		Map<String, String> params = new HashMap<>();

		params.put("board_no", board_no);

		// 로그인 여부 확인
		if(loginuser != null) {
			params.put("login_member_id", loginuser.getMember_id());
		}
		else {
			params.put("login_member_id", null);
		}
		
		params.put("start", "1");
		params.put("end", "1");
		params.put("searchWord", "");
		
		return service.searchBoardByContent(params);
	}

}
