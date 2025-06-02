package com.spring.app.recruit.controller;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.member.domain.MemberVO;
import com.spring.app.recruit.domain.RecruitVO;
import com.spring.app.recruit.service.RecruitService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.RequestBody;



@Controller
@RequestMapping(value = "/recruit/*")
public class RecruitController {

    @Autowired
    private RecruitService service;

    @GetMapping("add/step1")
    public ModelAndView requiredLogin_recruitAddStep1(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {

        mav.setViewName("recruit/recruitAddStep1");

        return mav;
    }

    @PostMapping("add/step2")
    public ModelAndView requiredLogin_recruitAddStep2(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, RecruitVO recruitVO) {

        mav.addObject("recruitVO", recruitVO);

        mav.setViewName("recruit/recruitAddStep2");

        return mav;
    }

    @PostMapping("add/step3")
    public ModelAndView requiredLogin_recruitAddStep3(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, RecruitVO recruitVO) {

        mav.addObject("recruitVO", recruitVO);
        
        mav.setViewName("recruit/recruitAddStep3");

        return mav;
    }

    @PostMapping("add/complete")
    public ModelAndView requiredLogin_recruitAddComplete(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, RecruitVO recruitVO) {

        HttpSession session = request.getSession();

        MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
        recruitVO.setFk_member_id(loginuser.getMember_id());

        // === html 파일 저장 시작 === //
        String uploadHtmlName = "recruit";
        uploadHtmlName += "_" + String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", Calendar.getInstance());
        uploadHtmlName += System.nanoTime();
        uploadHtmlName += ".html";

        // html 업로드 경로 설정
        String root = session.getServletContext().getRealPath("/");
        String path = root + "resources" + File.separator + "files" + File.separator + "recruit";

        // 업로드할 경로가 존재하지 않는 경우 폴더를 생성한다.
        File dir = new File(path);
        if(!dir.exists()) {
            dir.mkdirs();
        }

        try {
            BufferedWriter bw = new BufferedWriter(new FileWriter(path+File.separator+uploadHtmlName));
            bw.write(recruitVO.getRecruit_explain());
            bw.flush();
            bw.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        // === html 파일 저장 끝 === //

        recruitVO.setRecruit_explain_html(uploadHtmlName);

        System.out.println(recruitVO);

        service.insertRecruit(recruitVO); // 채용공고 등록

        mav.addObject("recruitVO", recruitVO);

        mav.setViewName("redirect:/recruit/detail/"+recruitVO.getRecruit_no());

        return mav;
    }

    @GetMapping("detail/{recruit_no}")
    public ModelAndView requiredLogin_getRecruitDetail(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, @PathVariable String recruit_no) {

        RecruitVO recruitVO = service.getRecruit(recruit_no);
        mav.addObject("recruitVO", recruitVO);

        mav.setViewName("recruit/recruitDetail");

        return mav;
    }

    @GetMapping("detail/{recruit_no}/applicant")
    public ModelAndView requiredLogin_getRecruitApplicant(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, @PathVariable String recruit_no) {

        RecruitVO recruitVO = service.getRecruit(recruit_no);
        mav.addObject("recruitVO", recruitVO);

        // 지원자들의 지역 목록
        List<Map<String, String>> regionList = service.getApplyRegionList(recruit_no);
        mav.addObject("regionList", regionList);

        // 지원자들의 보유기술(전문 분야) 목록
        List<Map<String, String>> skillList = service.getApplySkillList(recruit_no);
        mav.addObject("skillList", skillList);

        mav.setViewName("recruit/recruitApplicant");

        return mav;
    }

    @GetMapping("main/save")
    public ModelAndView requiredLogin_getRecruitMainSave(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {

        mav.setViewName("recruit/recruitMainSave");

        return mav;
    }

    @GetMapping("main/upload")
    public ModelAndView requiredLogin_getRecruitMainUpload(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {

        mav.setViewName("recruit/recruitMainUpload");

        return mav;
    }

    @GetMapping("view/{recruit_no}")
    public ModelAndView requiredLogin_getRecruitView(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, @PathVariable String recruit_no) {

        mav.addObject("recruit_no", recruit_no);

        mav.setViewName("recruit/recruitView");

        return mav;
    }
    

}
