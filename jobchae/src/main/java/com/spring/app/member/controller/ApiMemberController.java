package com.spring.app.member.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.app.member.service.MemberService;
import com.spring.app.member.domain.MemberVO;

import io.swagger.v3.oas.annotations.parameters.RequestBody;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;


@Controller
@RequestMapping(value="/api/member/*")
public class ApiMemberController {

	@Autowired
	MemberService service;
	
	@GetMapping("job/search")
	@ResponseBody
	public List<Map<String, String>> searchJob(@RequestParam Map<String, String> params) {
		
		List<Map<String, String>> jobList = service.getJobListForAutocomplete(params);
		
		if(jobList == null) {
			jobList = new ArrayList<>();
		}
		
		return jobList;
	}
	
	@GetMapping("company/search")
	@ResponseBody
	public List<Map<String, String>> searchCompany(@RequestParam Map<String, String> params) {
		
		List<Map<String, String>> companyList = service.getCompanyListForAutocomplete(params);
		
		if(companyList == null) {
			companyList = new ArrayList<>();
		}
		
		return companyList;
	}
	
	@GetMapping("major/search")
	@ResponseBody
	public List<Map<String, String>> searchMajor(@RequestParam Map<String, String> params) {
		
		List<Map<String, String>> majorList = service.getMajorListForAutocomplete(params);
		
		if(majorList == null) {
			majorList = new ArrayList<>();
		}
		
		return majorList;
	}
	
	@PostMapping("member-career/add")
	@ResponseBody
	public String addMemberCareer(HttpServletRequest request, @RequestBody Map<String, String> requestBody) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		requestBody.put("fk_member_id", loginuser.getMember_id());

		int n = service.addMemberCareer(requestBody);

		JSONObject jsonObj = new JSONObject();
		jsonObj.put("result", n);

		return jsonObj.toString();
	}

	@PostMapping("member-career/update")
	@ResponseBody
	public String updateMemberCareer(HttpServletRequest request, @RequestBody Map<String, String> requestBody) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		requestBody.put("fk_member_id", loginuser.getMember_id());
		
		int n = service.updateMemberCareer(requestBody);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("result", n);
		
		return jsonObj.toString();
	}

	@PostMapping("member-career/delete")
	@ResponseBody
	public String deleteMemberCareer(HttpServletRequest request, @RequestParam String member_career_no) {
		Map<String, String> paraMap = new HashMap<>();
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		paraMap.put("fk_member_id", loginuser.getMember_id());
		paraMap.put("member_career_no", member_career_no);
		
		int n = service.deleteMemberCareer(paraMap);

		JSONObject jsonObj = new JSONObject();
		jsonObj.put("result", n);
		
		return jsonObj.toString();
	}
	
}
