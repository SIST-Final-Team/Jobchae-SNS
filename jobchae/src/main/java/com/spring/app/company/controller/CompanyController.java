package com.spring.app.company.controller;

import com.spring.app.company.domain.CompanyVO;
import com.spring.app.company.service.CompanyService;
import com.spring.app.member.domain.MemberVO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
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
    @GetMapping({"/dashboard/{company_no}/", "/dashboard/{company_no}/{menu}"})
    public String requiredLogin_selectCompany(HttpServletRequest request, HttpServletResponse response, @PathVariable String company_no, @PathVariable(required = false) String menu){
        return "company/companyDashboard";
    }

    //회사 등록 페이지 이동
    @GetMapping("/registerCompany")
    public String requiredLogin_registerCompany(HttpServletRequest request, HttpServletResponse response){
        return "company/companyForm";
    }



    //회사 삭제
    @GetMapping("/deleteCompany/{company_no}")
    public String requiredLogin_deleteCompany(HttpServletRequest request, HttpServletResponse response, @PathVariable String company_no){
        return "company/CompanyDeleteTest";
    }

    @GetMapping("/updateCompany/{company_no}")
    public String requiredLogin_updateCompany(HttpServletRequest request, HttpServletResponse response, @PathVariable String company_no){
        return "company/CompanyUpdateTest";
    }

    @GetMapping("/{company_no}/admin/{menu}")
    public String requiredLogin_companyAdmin(HttpServletRequest request, HttpServletResponse response, @PathVariable String company_no, @PathVariable String menu ){
        return "company/companyHome";
    }

}
