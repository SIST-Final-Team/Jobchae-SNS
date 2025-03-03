package com.spring.app.company.controller;

import com.spring.app.company.domain.CompanyVO;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/company")
public class CompanyController {

    @GetMapping("/dashboard")
    public String selectCompany(){
        return "company/CompanySelectTest";
    }

    @GetMapping("/registerCompany")
    public String registerCompany(){
        return "company/formtest";
    }

}
