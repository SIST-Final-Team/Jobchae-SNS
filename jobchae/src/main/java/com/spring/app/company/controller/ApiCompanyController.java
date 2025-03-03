package com.spring.app.company.controller;

import com.spring.app.company.domain.CompanyVO;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/company")
public class ApiCompanyController {

    @GetMapping("/selectCompany/{company_no}")
    public ResponseEntity<CompanyVO> selectCompany(@PathVariable String company_no){
        return null;
    }

    @PostMapping("/insertCompany")
    public ResponseEntity<CompanyVO> insertCompany(@RequestBody CompanyVO companyVO){

        return  null;
    }

}
