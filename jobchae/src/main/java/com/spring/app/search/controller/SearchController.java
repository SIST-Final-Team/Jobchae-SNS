package com.spring.app.search.controller;

import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.history.domain.SearchHistoryVO;
import com.spring.app.history.service.HistoryService;
import com.spring.app.member.domain.MemberVO;
import com.spring.app.search.service.SearchService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;


@Controller
@RequestMapping(value="/search/*")
public class SearchController {

	@Autowired
	SearchService service;

    @Autowired
    HistoryService historyService;
	
    // 전체 검색
    @GetMapping("all")
    public ModelAndView searchAll(HttpServletRequest request, ModelAndView mav, @RequestParam String searchWord) {

        // TODO: 검색 결과 수 가져오기

        // === 검색 기록 추가 시작 === //
        SearchHistoryVO searchHistoryVO = new SearchHistoryVO();

        HttpSession session = request.getSession();
        MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

        if(loginuser != null) {
            searchHistoryVO.setMemberId(loginuser.getMember_id());
            searchHistoryVO.setSearchHistoryWord(searchWord);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            searchHistoryVO.setSearchHistoryRegisterDate(sdf.format(new Date()));
    
            historyService.saveSearchHistory(searchHistoryVO);
        }
        // === 검색 기록 추가 끝 === //

        mav.addObject("searchWord", searchWord);

        mav.setViewName("search/searchAll");

        return mav;
    }

    // 글 검색
    @GetMapping("board")
    public ModelAndView searchBoard(HttpServletRequest request, ModelAndView mav, @RequestParam Map<String, String> params) {

        // TODO: 검색 결과 수 가져오기

        // === 검색 기록 추가 시작 === //
        SearchHistoryVO searchHistoryVO = new SearchHistoryVO();

        HttpSession session = request.getSession();
        MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

        if(loginuser != null) {
            searchHistoryVO.setMemberId(loginuser.getMember_id());
            searchHistoryVO.setSearchHistoryWord(params.get("searchWord"));
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            searchHistoryVO.setSearchHistoryRegisterDate(sdf.format(new Date()));
    
            historyService.saveSearchHistory(searchHistoryVO);
        }
        // === 검색 기록 추가 끝 === //

        if(params.get("searchDate") != null) {
            mav.addObject("searchDate", params.get("searchDate"));
        }

        if(params.get("searchContentType") != null) {
            mav.addObject("searchContentType", params.get("searchContentType"));
        }

        mav.addObject("searchWord", params.get("searchWord"));
        
        mav.setViewName("search/searchBoard");

        return mav;
    }

    // 회원 검색
    @GetMapping("member")
    public ModelAndView searchMember(HttpServletRequest request, ModelAndView mav, @RequestParam Map<String, String> params) {

        // TODO: 검색 결과 수 가져오기

        // === 검색 기록 추가 시작 === //
        SearchHistoryVO searchHistoryVO = new SearchHistoryVO();

        HttpSession session = request.getSession();
        MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

        if(loginuser != null) {
            searchHistoryVO.setMemberId(loginuser.getMember_id());
            searchHistoryVO.setSearchHistoryWord(params.get("searchWord"));
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            searchHistoryVO.setSearchHistoryRegisterDate(sdf.format(new Date()));
    
            historyService.saveSearchHistory(searchHistoryVO);
        }
        // === 검색 기록 추가 끝 === //

        if(params.get("arr_fk_skill_no") != null) {
            mav.addObject("arr_fk_skill_no", params.get("arr_fk_skill_no"));

            // 보유기술 목록 가져오기
            List<String> skill_noList =  Arrays.asList((String[])params.get("arr_fk_skill_no").split("\\,"));
            mav.addObject("skillList", service.getSkillListBySkillNo(skill_noList));
        }

        if(params.get("arr_fk_company_no") != null) {
            mav.addObject("arr_fk_company_no", params.get("arr_fk_company_no"));
            
            // 회사 목록 가져오기
            List<String> company_noList =  Arrays.asList((String[])params.get("arr_fk_company_no").split("\\,"));
            mav.addObject("companyList", service.getCompanyListByCompanyNo(company_noList));
        }

        if(params.get("arr_fk_region_no") != null) {
            mav.addObject("arr_fk_region_no", params.get("arr_fk_region_no"));
            
            // 지역 목록 가져오기
            List<String> region_noList =  Arrays.asList((String[])params.get("arr_fk_region_no").split("\\,"));
            mav.addObject("regionList", service.getRegionListByRegionNo(region_noList));
        }

        mav.addObject("searchWord", params.get("searchWord"));
        
        mav.setViewName("search/searchMember");

        return mav;
    }

    // 회사 검색
    @GetMapping("company")
    public ModelAndView searchCompany(HttpServletRequest request, ModelAndView mav, @RequestParam Map<String, String> params) {

        // TODO: 검색 결과 수 가져오기

        // === 검색 기록 추가 시작 === //
        SearchHistoryVO searchHistoryVO = new SearchHistoryVO();

        HttpSession session = request.getSession();
        MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

        if(loginuser != null) {
            searchHistoryVO.setMemberId(loginuser.getMember_id());
            searchHistoryVO.setSearchHistoryWord(params.get("searchWord"));
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            searchHistoryVO.setSearchHistoryRegisterDate(sdf.format(new Date()));
    
            historyService.saveSearchHistory(searchHistoryVO);
        }
        // === 검색 기록 추가 끝 === //

        if(params.get("arr_fk_industry_no") != null) {
            mav.addObject("arr_fk_industry_no", params.get("arr_fk_industry_no"));
            
            // 업종 목록 가져오기
            List<String> industry_noList =  Arrays.asList((String[])params.get("arr_fk_industry_no").split("\\,"));
            mav.addObject("industryList", service.getIndustryListByIndustryNo(industry_noList));
        }

        if(params.get("arr_fk_region_no") != null) {
            mav.addObject("arr_fk_region_no", params.get("arr_fk_region_no"));
            
            // 지역 목록 가져오기
            List<String> region_noList =  Arrays.asList((String[])params.get("arr_fk_region_no").split("\\,"));
            mav.addObject("regionList", service.getRegionListByRegionNo(region_noList));
        }

        if(params.get("arr_company_size") != null) {
            mav.addObject("arr_company_size", params.get("arr_company_size"));
        }

        mav.addObject("searchWord", params.get("searchWord"));
        
        mav.setViewName("search/searchCompany");

        return mav;
    }
    
    // 글 1개 정보 가져오기
    @GetMapping("board/{board_no}")
    public ModelAndView getBoardOne(HttpServletRequest request, ModelAndView mav, @PathVariable String board_no) {

        // TODO: 검색 결과 수 가져오기

        mav.addObject("board_no", board_no);
        
        mav.setViewName("search/getBoardOne");

        return mav;
    }
    
    // 한 회원의 글 정보 가져오기
    @GetMapping("board/member/{member_id}")
    public ModelAndView getBoardByMemberId(HttpServletRequest request, ModelAndView mav, @PathVariable String member_id) {

        // TODO: 검색 결과 수 가져오기

        mav.addObject("member_id", member_id);
        
        mav.setViewName("search/getBoardByMemberId");

        return mav;
    }
}
