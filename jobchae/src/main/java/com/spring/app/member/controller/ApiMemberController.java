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
import org.springframework.web.bind.annotation.RestController;

import com.spring.app.member.service.MemberService;
import com.spring.app.member.domain.MemberCareerVO;
import com.spring.app.member.domain.MemberEducationVO;
import com.spring.app.member.domain.MemberVO;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;


@Controller
@RequestMapping(value="/api/member/*")
@RestController
public class ApiMemberController {

	@Autowired
	MemberService service;
	
	// === 이준영 시작 === //
	
	// 지역 검색 시 자동 완성 해주는 메소드
	@Operation(summary = "지역 검색", description = "지역명으로 지역 검색")
    @Parameter(name = "region_name", description = "지역명")
	@GetMapping("region/search")
	public List<Map<String, String>> regionSearch(@RequestParam String region_name) {
		// 입력한 검색어 찾기
		return service.regionSearchShow(region_name);
	
	}//end of public List<Map<String, String>> regionSearch(@RequestParam String member_region) {}...
	
	// === 이준영 끝 === //
	
	// === 김규빈 시작 === //

	@Operation(summary = "직종 검색", description = "직종명으로 직종 검색")
    @Parameter(name = "params", description = "job_name: 직종명, size: 가져올 개수")
	@GetMapping("job/search")
	public List<Map<String, String>> searchJob(@RequestParam Map<String, String> params) {
		
		List<Map<String, String>> jobList = service.getJobListForAutocomplete(params);
		
		if(jobList == null) {
			jobList = new ArrayList<>();
		}
		
		return jobList;
	}

	@Operation(summary = "회사 검색", description = "회사명으로 회사 검색")
    @Parameter(name = "params", description = "company_name: 회사명, size: 가져올 개수")
	@GetMapping("company/search")
	public List<Map<String, String>> searchCompany(@RequestParam Map<String, String> params) {
		
		List<Map<String, String>> companyList = service.getCompanyListForAutocomplete(params);
		
		if(companyList == null) {
			companyList = new ArrayList<>();
		}
		
		return companyList;
	}

	@Operation(summary = "전공 검색", description = "전공명으로 전공 검색")
    @Parameter(name = "params", description = "major_name: 전공명, size: 가져올 개수")
	@GetMapping("major/search")
	public List<Map<String, String>> searchMajor(@RequestParam Map<String, String> params) {
		
		List<Map<String, String>> majorList = service.getMajorListForAutocomplete(params);
		
		if(majorList == null) {
			majorList = new ArrayList<>();
		}
		
		return majorList;
	}

	@Operation(summary = "학교 검색", description = "학교명으로 전공 검색")
    @Parameter(name = "params", description = "school_name: 학교명, size: 가져올 개수")
	@GetMapping("school/search")
	public List<Map<String, String>> searchSchool(@RequestParam Map<String, String> params) {
		
		List<Map<String, String>> schoolList = service.getSchoolListForAutocomplete(params);
		
		if(schoolList == null) {
			schoolList = new ArrayList<>();
		}
		
		return schoolList;
	}

	@Operation(summary = "보유기술 검색", description = "보유기술명으로 전공 검색")
    @Parameter(name = "params", description = "skill_name: 보유기술명, size: 가져올 개수")
	@GetMapping("skill/search")
	public List<Map<String, String>> searchSkill(@RequestParam Map<String, String> params) {
		
		List<Map<String, String>> skillList = service.getSkillListForAutocomplete(params);
		
		if(skillList == null) {
			skillList = new ArrayList<>();
		}
		
		return skillList;
	}
	
	@Operation(summary = "회원경력 1개 조회", description = "회원경력 일련번호로 회원경력 1개 조회")
    @Parameter(name = "member_career_no", description = "회원경력 일련번호")
	@GetMapping("member-career")
	public MemberCareerVO getMemberCareer(HttpServletRequest request, @RequestParam String member_career_no) {
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("member_career_no", member_career_no);
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		if(loginuser != null) {
			paraMap.put("login_member_id", loginuser.getMember_id());
		}
		else {
			paraMap.put("login_member_id", " "); // 로그인하지 않은 경우 빈 값 입력
		}

		return service.getMemberCareer(paraMap);
	}

	@Operation(summary = "한 회원의 회원경력 목록 조회", description = "회원 아이디로 회원경력 목록 조회")
    @Parameter(name = "member_id", description = "조회할 회원 아이디, PathVariable")
	@GetMapping("member-career/{member_id}")
	public List<MemberCareerVO> getMemberCareerByMemberId(HttpServletRequest request, @PathVariable String member_id) {
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("member_id", member_id);
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		if(loginuser != null) {
			paraMap.put("login_member_id", loginuser.getMember_id());
		}
		else {
			paraMap.put("login_member_id", " "); // 로그인하지 않은 경우 빈 값 입력
		}

		return service.getMemberCareerListByMemberId(paraMap);
	}

	@Operation(summary = "회원경력 등록", description = "회원경력 등록, 로그인 후 사용 가능")
    @Parameter(name = "paraMap", description = "회원경력 Map")
	@PostMapping("member-career/add")
	public String addMemberCareer(HttpServletRequest request, MemberCareerVO memberCareerVO) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		memberCareerVO.setFk_member_id(loginuser.getMember_id());

		int n = service.addMemberCareer(memberCareerVO);

		JSONObject jsonObj = new JSONObject();
		jsonObj.put("result", n);

		return jsonObj.toString();
	}

	@Operation(summary = "회원경력 수정", description = "회원경력 수정, 로그인 후 사용 가능")
    @Parameter(name = "paraMap", description = "회원경력 Map")
	@PutMapping("member-career/update")
	public String updateMemberCareer(HttpServletRequest request, MemberCareerVO memberCareerVO) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		memberCareerVO.setFk_member_id(loginuser.getMember_id());
		
		int n = service.updateMemberCareer(memberCareerVO);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("result", n);
		
		return jsonObj.toString();
	}

	@Operation(summary = "회원경력 삭제", description = "회원경력 삭제, 로그인 후 사용 가능")
    @Parameter(name = "member_career_no", description = "회원경력 일련번호")
	@DeleteMapping("member-career/delete")
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
	
	@Operation(summary = "회원학력 1개 조회", description = "회원학력 일련번호로 회원학력 1개 조회")
    @Parameter(name = "member_education_no", description = "회원학력 일련번호")
	@GetMapping("member-education")
	public MemberEducationVO getMemberEducation(HttpServletRequest request, @RequestParam String member_education_no) {
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("member_education_no", member_education_no);
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		if(loginuser != null) {
			paraMap.put("login_member_id", loginuser.getMember_id());
		}
		else {
			paraMap.put("login_member_id", " "); // 로그인하지 않은 경우 빈 값 입력
		}

		return service.getMemberEducation(paraMap);
	}

	@Operation(summary = "한 회원의 회원학력 목록 조회", description = "회원 아이디로 회원학력 목록 조회")
    @Parameter(name = "member_id", description = "조회할 회원 아이디, PathVariable")
	@GetMapping("member-education/{member_id}")
	public List<MemberEducationVO> getMemberEducationByMemberId(HttpServletRequest request, @PathVariable String member_id) {
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("member_id", member_id);
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		if(loginuser != null) {
			paraMap.put("login_member_id", loginuser.getMember_id());
		}
		else {
			paraMap.put("login_member_id", " "); // 로그인하지 않은 경우 빈 값 입력
		}

		return service.getMemberEducationListByMemberId(paraMap);
	}

	@Operation(summary = "회원학력 등록", description = "회원학력 등록, 로그인 후 사용 가능")
    @Parameter(name = "paraMap", description = "회원학력 Map")
	@PostMapping("member-education/add")
	public String addMemberEducation(HttpServletRequest request, MemberEducationVO memberEducationVO) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
//		memberEducationVO.setFk_member_id(loginuser.getMember_id());
		memberEducationVO.setFk_member_id("user001");

		int n = service.addMemberEducation(memberEducationVO);

		JSONObject jsonObj = new JSONObject();
		jsonObj.put("result", n);

		return jsonObj.toString();
	}

	@Operation(summary = "회원학력 수정", description = "회원학력 수정, 로그인 후 사용 가능")
    @Parameter(name = "paraMap", description = "회원학력 Map")
	@PutMapping("member-education/update")
	public String updateMemberEducation(HttpServletRequest request, MemberEducationVO memberEducationVO) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		memberEducationVO.setFk_member_id(loginuser.getMember_id());
		
		int n = service.updateMemberEducation(memberEducationVO);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("result", n);
		
		return jsonObj.toString();
	}

	@Operation(summary = "회원학력 삭제", description = "회원학력 삭제, 로그인 후 사용 가능")
    @Parameter(name = "member_education_no", description = "회원학력 일련번호")
	@DeleteMapping("member-education/delete")
	public String deleteMemberEducation(HttpServletRequest request, @RequestParam String member_education_no) {
		Map<String, String> paraMap = new HashMap<>();
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		paraMap.put("fk_member_id", loginuser.getMember_id());
		
		paraMap.put("member_education_no", member_education_no);
		
		int n = service.deleteMemberEducation(paraMap);

		JSONObject jsonObj = new JSONObject();
		jsonObj.put("result", n);
		
		return jsonObj.toString();
	}
	
	
	

	// === 김규빈 끝 === //
	
}
