package com.spring.app.company.controller;

import com.spring.app.company.domain.CompanyVO;
import com.spring.app.company.service.CompanyService;
import com.spring.app.member.domain.MemberVO;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.Enumeration;

@Controller
@RequestMapping("/company")
public class CompanyController {

    CompanyService companyService;

    //생성자 주입
    public CompanyController(CompanyService companyService) {
        this.companyService = companyService;
    }

    //회사 대시보드 페이지 이동
    @GetMapping("/dashboard/{company_no}")
    public String selectCompany(@PathVariable String company_no){
        return "company/CompanySelectTest";
    }

    //회사 등록 페이지 이동
    @GetMapping("/registerCompany")
    public String registerCompany(){
        return "company/formtest";
    }



    //회사 삭제
    @GetMapping("/deleteCompany/{company_no}")
    public String deleteCompany(@PathVariable String company_no){
        return "company/CompanyDeleteTest";
    }

}
