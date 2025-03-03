package com.spring.app.company.controller;

import com.spring.app.company.domain.CompanyVO;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/company")
public class ApiCompanyController {

    @GetMapping("/dashboard/{company_no}")
    public ResponseEntity<CompanyVO> selectCompany(@PathVariable String company_no){
        return null;
    }

    @PostMapping("/registerCompany")
    public ResponseEntity<CompanyVO> registerCompany(@RequestBody CompanyVO companyVO){

        return  null;
    }



}
