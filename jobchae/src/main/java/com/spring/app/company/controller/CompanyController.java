package com.spring.app.company.controller;

import com.spring.app.company.domain.CompanyVO;
import com.spring.app.company.service.CompanyService;
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

    //회사 등록
    @PostMapping("/registerCompany")
    public ModelAndView registerCompany(CompanyVO companyVO, HttpServletRequest request) {

        //파라미터 확인
//        Enumeration<String> parameterNames = request.getParameterNames();
//        while(parameterNames.hasMoreElements()) {
//            String name = parameterNames.nextElement();
//            System.out.println(name +" : "+ request.getParameter(name));
//        }

        //멤버 등록
        companyVO.setFkMemberId("user001");
        String industryName = (String)request.getParameter("industryName");

        //회사 등록
        CompanyVO company = companyService.insertCompany(companyVO, industryName);
        //회사 대시보드로 이동
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("redirect:/company/dashboard/"+company.getCompanyNo());
        modelAndView.addObject("company", company);
        return  modelAndView;
    }

}
