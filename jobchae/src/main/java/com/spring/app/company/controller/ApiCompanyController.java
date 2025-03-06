package com.spring.app.company.controller;

import com.spring.app.company.domain.CompanyVO;
import com.spring.app.company.service.CompanyService;
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

        CompanyVO companyVO = companyService.selectCompany(company_no);

        return ResponseEntity.ok(companyVO);
    }





}
