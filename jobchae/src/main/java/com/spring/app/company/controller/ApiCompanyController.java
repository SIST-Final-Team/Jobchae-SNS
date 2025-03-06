package com.spring.app.company.controller;

import com.spring.app.company.domain.CompanyVO;
import com.spring.app.company.service.CompanyService;
import com.spring.app.member.domain.MemberVO;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.HttpRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

@RestController
@RequestMapping("/api/company")
public class ApiCompanyController {

    CompanyService companyService;

    public ApiCompanyController(CompanyService companyService) {
        this.companyService = companyService;
    }

    @GetMapping("/dashboard/{company_no}")
    public ResponseEntity<CompanyVO> selectCompany(@PathVariable String company_no){

        //멤버 정보 조회
        MemberVO member = new MemberVO();
        member.setMember_id("user001");
        member.setMember_birth("1996-02-27");


        //회사 정보 조회
        CompanyVO companyVO = companyService.selectCompany(company_no);

        //회사 정보에 멤버 정보 추가
        companyVO.setMember(member);

        return ResponseEntity.ok(companyVO);
    }





}
