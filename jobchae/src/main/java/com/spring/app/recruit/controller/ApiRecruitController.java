package com.spring.app.recruit.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.common.FileManager;
import com.spring.app.config.DefaultImageNames;
import com.spring.app.member.domain.MemberVO;
import com.spring.app.recruit.domain.ApplyVO;
import com.spring.app.recruit.domain.RecruitVO;
import com.spring.app.recruit.service.RecruitService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;



@Controller
@RestController
@RequestMapping(value = "/api/recruit/*")
public class ApiRecruitController {

    @Autowired
    private RecruitService service;
	
	@Autowired
	FileManager fileManager; // 파일 관련 클래스

    @PutMapping("edit/{recruit_no}")
    public Map<String, String> requiredLogin_putRecruit(HttpServletRequest request, HttpServletResponse response, RecruitVO editedRecruitVO, @PathVariable String recruit_no) {

        RecruitVO recruitVO = service.getRecruit(recruit_no);

        // 아이디가 일치하는지 확인
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
        String login_member_id = loginuser.getMember_id();
        if(!recruitVO.getFk_member_id().equals(login_member_id)) {
            Map<String, String> resuiltMap = new HashMap<>();

            resuiltMap.put("result", "0");

            return resuiltMap;
        }

        if(editedRecruitVO.getRecruit_auto_fail() == null) {
            editedRecruitVO.setRecruit_auto_fail("0");
        }
        recruitVO.setRecruit_auto_fail(editedRecruitVO.getRecruit_auto_fail());
        recruitVO.setRecruit_auto_fail_message(editedRecruitVO.getRecruit_auto_fail_message());

        int n = service.updateRecruit(recruitVO);

        Map<String, String> resuiltMap = new HashMap<>();

        resuiltMap.put("result", String.valueOf(n));

        return resuiltMap;
    }

    @PutMapping("close/{recruit_no}")
    public Map<String, String> requiredLogin_putRecruitClose(HttpServletRequest request, HttpServletResponse response, @PathVariable String recruit_no) {

        Map<String, String> paraMap = new HashMap<>();

		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
        String login_member_id = loginuser.getMember_id();
        paraMap.put("login_member_id", login_member_id);

        paraMap.put("recruit_no", recruit_no);

        int n = service.closeRecruit(paraMap);

        Map<String, String> resuiltMap = new HashMap<>();

        resuiltMap.put("result", String.valueOf(n));

        return resuiltMap;
    }

    @GetMapping("{recruit_no}")
    public RecruitVO getRecruit(HttpServletRequest request, @PathVariable String recruit_no) {
        RecruitVO recruitVO = service.getRecruit(recruit_no);

        // html 경로 가져오기
        HttpSession session = request.getSession();
        String root = session.getServletContext().getRealPath("/");
        String path = root + "resources" + File.separator + "files" + File.separator + "recruit";
  
        String file_name = recruitVO.getRecruit_explain_html();

        try {
            recruitVO.setRecruit_explain(Files.readString(Paths.get(path + File.separator + file_name))); // html 파일 내용을 recruit_explain에 저장
        } catch (IOException e) {
            e.printStackTrace();
        }

        return recruitVO;
    }

    @GetMapping("my-upload")
    public List<RecruitVO> requiredLogin_getRecruitMainUpload(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, String> params) {

		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
        String login_member_id = loginuser.getMember_id();
        params.put("login_member_id", login_member_id);

        return service.getRecruitListByMemberId(params);
    }

    @GetMapping("my-save")
    public List<RecruitVO> requiredLogin_getRecruitMainSave(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, String> params) {

        HttpSession session = request.getSession();
        MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
        String login_member_id = loginuser.getMember_id();
        params.put("login_member_id", login_member_id);

        return service.getRecruitSaveListByMemberId(params);
    }

    @PostMapping("add/apply")
    public Map<String, Object> requiredLogin_addApply(HttpServletRequest request, HttpServletResponse response, ApplyVO applyVO) {

        // 이력서 파일 저장하기
		MultipartFile apply_resume_file = applyVO.getApply_resume_file(); // 이력서 파일

		if (!apply_resume_file.isEmpty()) { // 스프링은 빈파일 객체로 반환해줘서 null 이 아니다!
			
			// WAS 의 webapp 의 절대경로를 알아와야한다.
			HttpSession session = request.getSession(); // 파일용 세션
			String root = session.getServletContext().getRealPath("/");

			String path = root + "resources" + File.separator + "files" + File.separator + "apply";
			
			String newFileName = "";
			// WAS(톰캣)의 디스크에 저장될 파일명
			
			byte[] bytes_file = null;
			// 첨부파일의 내용물을 담는 것
			
			try {
				bytes_file = apply_resume_file.getBytes();
				// 첨부파일의 내용물을 읽어오는 것
				
				String originFilename = apply_resume_file.getOriginalFilename();
				// 첨부파일명의 파일명(예:fileName.pdf)을 읽어오는 것
				
				// 파일 확장자
				String fileExt = originFilename.substring(originFilename.lastIndexOf(".")); 
				// System.out.println("fileExt => "+fileExt);
				// 백엔드에서 한번 더 허용된 파일인지 확인
				if (!".doc".equals(fileExt) && !".docx".equals(fileExt) && !".pdf".equals(fileExt)) {

                    Map<String, Object> resultMap = new HashMap<>();
                    resultMap.put("result", "0");
					
					return resultMap;
				}//end of if...

				newFileName = fileManager.doFileUpload(bytes_file, originFilename, path); // 파일 저장
				applyVO.setApply_resume(newFileName); // applyVO 의 apply_resume 에 fileName 값을 넣어주기

			} catch (Exception e) {
				e.printStackTrace();
			} // end of try catch...
			
		} else { // 들어온 이력서가 없을 때
            Map<String, Object> resultMap = new HashMap<>();
            resultMap.put("result", "0");
            
            return resultMap;
		}//end of if (!apply_resume_file.isEmpty()) {}...
        
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
        applyVO.setFk_member_id(loginuser.getMember_id());

        String n = service.insertApply(applyVO);

        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("result", n);
        
        return resultMap;
    }

    @GetMapping("apply")
    public Map<String, Object> getApplyByRecruitNo(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> params) {

		// 평가 결과 배열
		if(params.get("searchApplyResultList") != null) {
			String[] searchApplyResultList = ((String) params.get("searchApplyResultList")).split("\\,");
			params.put("searchApplyResultList", searchApplyResultList);
		}
		else {
			params.put("searchApplyResultList", null);
		}

		// 지역 배열
		if(params.get("searchApplyRegionList") != null) {
			String[] searchApplyRegionList = ((String) params.get("searchApplyRegionList")).split("\\,");
			params.put("searchApplyRegionList", searchApplyRegionList);

            for (String string : searchApplyRegionList) {
                System.out.println(string);
            }
		}
		else {
			params.put("searchApplyRegionList", null);
		}

		// 경력 연차 배열
		if(params.get("searchApplyCareerYearList") != null) {
			String[] searchApplyCareerYearList = ((String) params.get("searchApplyCareerYearList")).split("\\,");
			params.put("searchApplyCareerYearList", searchApplyCareerYearList);

            for (String string : searchApplyCareerYearList) {
                System.out.println(string);
            }
		}
		else {
			params.put("searchApplyCareerYearList", null);
		}

		// 전문분야 배열
		if(params.get("searchApplySkillList") != null) {
			String[] searchApplySkillList = ((String) params.get("searchApplySkillList")).split("\\,");
			params.put("searchApplySkillList", searchApplySkillList);
		}
		else {
			params.put("searchApplySkillList", null);
		}

        int totalApplyCount = service.getTotalApplyCount((String) params.get("recruit_no"));
        int searchApplyCount = service.getSearchApplyCount(params);
        List<ApplyVO> applyList = service.getApplyByRecruitNo(params);

        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("totalApplyCount", totalApplyCount);
        resultMap.put("searchApplyCount", searchApplyCount);
        resultMap.put("applyList", applyList);

        return resultMap;
    }

    @PutMapping("apply/check/{apply_no}")
    public Map<String, Object> requiredLogin_checkApply(HttpServletRequest request, HttpServletResponse response, @PathVariable String apply_no) {
        int n = service.updateApplyChecked(apply_no);

        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("result", n);

        return resultMap;
    }
    
    @PutMapping("apply/update/{apply_no}")
    public Map<String, Object> requiredLogin_updateApply(HttpServletRequest request, HttpServletResponse response, @PathVariable String apply_no, @RequestParam String apply_result) {

        ApplyVO applyVO = new ApplyVO();
        applyVO.setApply_no(apply_no);
        applyVO.setApply_result(apply_result);

        int n = service.updateApplyResult(applyVO);

        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("result", n);

        return resultMap;
    }
}
