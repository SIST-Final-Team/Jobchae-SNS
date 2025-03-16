package com.spring.app.member.controller;

import java.io.File;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.app.member.service.MemberService;
import com.spring.app.common.FileManager;
import com.spring.app.common.mail.FuncMail;
import com.spring.app.config.DefaultImageNames;
import com.spring.app.member.domain.MemberCareerVO;
import com.spring.app.member.domain.MemberEducationVO;
import com.spring.app.member.domain.MemberSkillVO;
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
@RestController // responseBody 안써도 전체가 다 된다.
public class ApiMemberController {

	@Autowired
	MemberService service;
	
	@Autowired
	FuncMail funcMail; // 이메일 인증 관련 클래스
	
	@Autowired
	FileManager fileManager; // 파일 관련 클래스

	// === 이준영 시작 === //
	
	// 지역 검색 시 자동 완성 해주는 메소드
	@Operation(summary = "지역 검색", description = "지역명으로 지역 검색")
    @Parameter(name = "region_name", description = "지역명")
	@GetMapping("region/search")
	public List<Map<String, String>> regionSearch(@RequestParam String region_name) {
		// 입력한 검색어 찾기
		return service.regionSearchShow(region_name);
	
	}//end of public List<Map<String, String>> regionSearch(@RequestParam String member_region) {}...
	
	
	// 회원이 존재하는지 검사하는 메소드(먼저 로그인 해야함)
	@PostMapping("isExistMember")
	public Map<String, Boolean> requiredLogin_isExistMember(@RequestParam Map<String, String> paraMap) {
		
		boolean isExists = service.isExistMember(paraMap);
		
		Map<String, Boolean> isExistsMap = new HashMap<>();
		isExistsMap.put("isExists", isExists); // 
		
		return isExistsMap;
	}//end of public Map<String, Boolean> isExistMember(@RequestParam Map<String, String> paraMap) {}...
	
	
	
	// 아이디 중복체크
	@PostMapping("idDuplicateCheck")
	public Map<String, Boolean> idDuplicateCheck(@RequestParam String member_id) {

		boolean isExists = service.idDuplicateCheck(member_id);

		Map<String, Boolean> id_checkMap = new HashMap<>();
		id_checkMap.put("isExists", isExists);

		return id_checkMap;

	}// end of public String postMethodName(@RequestBody String entity) {}...
	
	
	// 이메일 중복확인 및 인증메일 발송
	@PostMapping("emailCheck_Send")
	public Map<String, Boolean> emailCheck_Send(HttpServletRequest request, @RequestParam String member_email) {

		Map<String, Boolean> email_check_SendMap = new HashMap<>();

		// 메일이 정상적으로 전송되었는지 유무를 알아오기 위한 용도
		boolean sendMailSuccess = false;

		// 이메일 중복 검사
		boolean isExists = service.emailCheck(member_email);

		if (!isExists) { // 이메일 중복이 없으면

			// 인증 이메일을 발송한다!
			sendMailSuccess = funcMail.sendMail(request, member_email);
			// 여기까지 했다. 이메일 보내는 메소드를 완성하고 그걸 위에 오토와이어드로 선언, 사용하면 끝!

		} // end of if (!isExists) {}...

		// 이메일 중복여부 넣어주자
		email_check_SendMap.put("isExists", isExists);
		// 이메일 발송여부도 넣어주자
		email_check_SendMap.put("sendMailSuccess", sendMailSuccess);

		return email_check_SendMap;

	}// end of public String postMethodName(@RequestBody String entity) {}...
	
	
	
	// 이메일 인증메일 발송
	@PostMapping("emailSend")
	public Map<String, Boolean> emailSend(HttpServletRequest request, @RequestParam String member_email) {

		Map<String, Boolean> email_SendMap = new HashMap<>();

		// 메일이 정상적으로 전송되었는지 유무를 알아오기 위한 용도
		boolean sendMailSuccess = false;

		// 인증 이메일을 발송한다!
		sendMailSuccess = funcMail.sendMail(request, member_email);

		// 이메일 발송여부도 넣어주자
		email_SendMap.put("sendMailSuccess", sendMailSuccess);

		return email_SendMap;

	}// end of public String postMethodName(@RequestBody String entity) {}...
	
	
	
	// 이메일 인증 번호 받아서 확인해주는 메소드
	@PostMapping("emailAuth")
	public Map<String, Boolean> emailAuth(HttpServletRequest request, @RequestParam String email_auth_text) {

		Map<String, Boolean> email_AuthMap = new HashMap<>(); // 보내줄 맵 선언

		// 이메일 인증번호를 비교해서 확인해주는 메소드
		boolean isExists = funcMail.emailAuth(request, email_auth_text); // 인증번호가 맞으면 true, 아니면 false

		email_AuthMap.put("isExists", isExists); // 넣어준다.

		return email_AuthMap;

	}// end of public Map<String, Boolean> emailAuth(@RequestParam String email_auth_text) {}...

	
	
	
	
	
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

	@Operation(summary = "보유기술 검색", description = "보유기술명으로 보유기술 검색")
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
    @Parameter(name = "memberCareerVO", description = "회원경력VO")
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
    @Parameter(name = "memberCareerVO", description = "회원경력VO")
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
    @Parameter(name = "memberEducationVO", description = "회원학력VO")
	@PostMapping("member-education/add")
	public String addMemberEducation(HttpServletRequest request, MemberEducationVO memberEducationVO) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		memberEducationVO.setFk_member_id(loginuser.getMember_id());

		int n = service.addMemberEducation(memberEducationVO);

		JSONObject jsonObj = new JSONObject();
		jsonObj.put("result", n);

		return jsonObj.toString();
	}

	@Operation(summary = "회원학력 수정", description = "회원학력 수정, 로그인 후 사용 가능")
    @Parameter(name = "memberEducationVO", description = "회원학력VO")
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
	
	@Operation(summary = "회원학력 1개 조회", description = "회원학력 일련번호로 회원학력 1개 조회")
    @Parameter(name = "member_education_no", description = "회원학력 일련번호")
	@GetMapping("member-skill")
	public MemberSkillVO getMemberSkill(HttpServletRequest request, @RequestParam String member_skill_no) {
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("member_skill_no", member_skill_no);
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		if(loginuser != null) {
			paraMap.put("login_member_id", loginuser.getMember_id());
		}
		else {
			paraMap.put("login_member_id", " "); // 로그인하지 않은 경우 빈 값 입력
		}

		return service.getMemberSkill(paraMap);
	}

	@Operation(summary = "한 회원의 회원학력 목록 조회", description = "회원 아이디로 회원학력 목록 조회")
    @Parameter(name = "member_id", description = "조회할 회원 아이디, PathVariable")
	@GetMapping("member-skill/{member_id}")
	public List<MemberSkillVO> getMemberSkillByMemberId(HttpServletRequest request, @PathVariable String member_id) {
		
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

		return service.getMemberSkillListByMemberId(paraMap);
	}

	@Operation(summary = "회원보유기술 등록", description = "회원보유기술 등록, 로그인 후 사용 가능")
    @Parameter(name = "memberSkillVO", description = "회원보유기술VO")
	@PostMapping("member-skill/add")
	public String addMemberSkill(HttpServletRequest request, MemberSkillVO memberSkillVO) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		memberSkillVO.setFk_member_id(loginuser.getMember_id());

		int n = 0;
		try {
			n = service.addMemberSkill(memberSkillVO);
		} catch (Exception e) {
			n = -1;
		}

		JSONObject jsonObj = new JSONObject();
		jsonObj.put("result", n);

		return jsonObj.toString();
	}

	@Operation(summary = "회원보유기술 삭제", description = "회원보유기술 삭제, 로그인 후 사용 가능")
    @Parameter(name = "member_skill_no", description = "회원보유기술 일련번호")
	@DeleteMapping("member-skill/delete")
	public String deleteMemberSkill(HttpServletRequest request, @RequestParam String member_skill_no) {
		Map<String, String> paraMap = new HashMap<>();
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		paraMap.put("fk_member_id", loginuser.getMember_id());
		
		paraMap.put("member_skill_no", member_skill_no);
		
		int n = service.deleteMemberSkill(paraMap);

		JSONObject jsonObj = new JSONObject();
		jsonObj.put("result", n);
		
		return jsonObj.toString();
	}
	
	@Operation(summary = "회원 프로필 배경 수정", description = "회원 프로필 배경 수정, 로그인 후 사용 가능")
    @Parameter(name = "attach_member_background_img", description = "회원 프로필 배경")
	@PutMapping("member-background-img")
	public String updateMemberBackgroundImg(HttpServletRequest request, MultipartHttpServletRequest mrequest) {
		
		MemberVO memberVO = new MemberVO();

		// 파일부터 넣어주기 
		MultipartFile attach_member_background_img = mrequest.getFile("attach_member_background_img"); // 프로필 배경 사진

		// 프로필 배경 사진 일단 기본이미지로 default
		if (!attach_member_background_img.isEmpty()) { // 스프링은 빈파일 객체로 반환해줘서 null 이 아니다!
			
			// WAS 의 webapp 의 절대경로를 알아와야한다.
			HttpSession m_session = mrequest.getSession(); // 파일용 세션
			String root = m_session.getServletContext().getRealPath("/");

			String path = root + "resources" + File.separator + "files" + File.separator + "profile";
			
			String newProFileName = "";
			// WAS(톰캣)의 디스크에 저장될 파일명
			
			byte[] bytes_member_background_img = null;
			// 첨부파일의 내용물을 담는 것
			
			try {
				bytes_member_background_img = attach_member_background_img.getBytes();
				// 첨부파일의 내용물을 읽어오는 것
				
				String origin_member_background_img_Filename = attach_member_background_img.getOriginalFilename();
//				System.out.println("origin_member_profile_Filename => "+ origin_member_profile_Filename);
				// 첨부파일명의 파일명(예:강아지.png)을 읽어오는 것
				
				// 파일 확장자
				String fileExt = origin_member_background_img_Filename.substring(origin_member_background_img_Filename.lastIndexOf(".")); 
				System.out.println("fileExt => "+fileExt);
				// 백엔드에서 한번 더 사진파일로 걸러주자
				if (!".jpg".equals(fileExt) && !".png".equals(fileExt) && !".webp".equals(fileExt) && !".jpeg".equals(fileExt)) {
					
					JSONObject jsonObj = new JSONObject();
					jsonObj.put("result", 0);
					
					return jsonObj.toString();
				}//end of if (fileExt != ".jpg" || fileExt != ".png" || fileExt != ".webp") {}...
				
				// 첨부되어진 파일을 업로드 하는 것이다.

				// MemberVO membervo 에 fileName 값과 orgFilename 값과 fileSize 값을 넣어주기
				newProFileName = fileManager.doFileUpload(bytes_member_background_img, origin_member_background_img_Filename, path);
				memberVO.setMember_background_img(newProFileName);

			} catch (Exception e) {
				e.printStackTrace();
			} // end of try catch...
			
		} else { // 들어온 프로필 배경 사진이 없을 때
			memberVO.setMember_background_img(DefaultImageNames.BackgroundfileName);
		}//end of if (!attach_member_background_img.isEmpty()) {}...

		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		memberVO.setMember_id(loginuser.getMember_id());
		
		int n = service.updateMemberBackgroundImg(memberVO);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("result", n);
		
		return jsonObj.toString();
	}
	
	@Operation(summary = "회원 프로필 사진 수정", description = "회원 프로필 사진 수정, 로그인 후 사용 가능")
    @Parameter(name = "attach_member_profile", description = "회원 프로필 사진")
	@PutMapping("member-profile")
	public String updateMemberProfile(HttpServletRequest request, MultipartHttpServletRequest mrequest) {
		
		MemberVO memberVO = new MemberVO();

		// 파일부터 넣어주기 
		MultipartFile attach_member_profile = mrequest.getFile("attach_member_profile"); // 프로필 배경 사진

		// 프로필 배경 사진 일단 기본이미지로 default
		if (!attach_member_profile.isEmpty()) { // 스프링은 빈파일 객체로 반환해줘서 null 이 아니다!
			
			// WAS 의 webapp 의 절대경로를 알아와야한다.
			HttpSession m_session = mrequest.getSession(); // 파일용 세션
			String root = m_session.getServletContext().getRealPath("/");

			String path = root + "resources" + File.separator + "files" + File.separator + "profile";
			
			String newProFileName = "";
			// WAS(톰캣)의 디스크에 저장될 파일명
			
			byte[] bytes_member_profile = null;
			// 첨부파일의 내용물을 담는 것
			
			try {
				bytes_member_profile = attach_member_profile.getBytes();
				// 첨부파일의 내용물을 읽어오는 것
				
				String origin_member_profile_Filename = attach_member_profile.getOriginalFilename();
//				System.out.println("origin_member_profile_Filename => "+ origin_member_profile_Filename);
				// 첨부파일명의 파일명(예:강아지.png)을 읽어오는 것
				
				// 파일 확장자
				String fileExt = origin_member_profile_Filename.substring(origin_member_profile_Filename.lastIndexOf(".")); 
				System.out.println("fileExt => "+fileExt);
				// 백엔드에서 한번 더 사진파일로 걸러주자
				if (!".jpg".equals(fileExt) && !".png".equals(fileExt) && !".webp".equals(fileExt) && !".jpeg".equals(fileExt)) {
					
					JSONObject jsonObj = new JSONObject();
					jsonObj.put("result", 0);
					
					return jsonObj.toString();
				}//end of if (fileExt != ".jpg" || fileExt != ".png" || fileExt != ".webp") {}...
				
				// 첨부되어진 파일을 업로드 하는 것이다.

				// MemberVO membervo 에 fileName 값과 orgFilename 값과 fileSize 값을 넣어주기
				newProFileName = fileManager.doFileUpload(bytes_member_profile, origin_member_profile_Filename, path);
				memberVO.setMember_profile(newProFileName);

			} catch (Exception e) {
				e.printStackTrace();
			} // end of try catch...
			
		} else { // 들어온 프로필 배경 사진이 없을 때
			memberVO.setMember_profile(DefaultImageNames.ProfileName);
		}//end of if (!attach_member_profile.isEmpty()) {}...

		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		memberVO.setMember_id(loginuser.getMember_id());
		
		int n = service.updateMemberProfile(memberVO);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("result", n);
		
		return jsonObj.toString();
	}
	
	

	// === 김규빈 끝 === //
	
}
