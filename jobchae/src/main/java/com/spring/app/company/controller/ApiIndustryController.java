package com.spring.app.company.controller;

import com.spring.app.company.domain.IndustryVO;
import com.spring.app.company.service.IndustryService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/industry")
public class ApiIndustryController {

    IndustryService industryService;

    public ApiIndustryController(IndustryService industryService) {
        this.industryService = industryService;
    }

    //업종 리스트 조회
    @GetMapping("/list")
    public ResponseEntity<List<IndustryVO>> selectIndustryList(){
        List<IndustryVO> industryVOList = industryService.selectAllIndustry();

        return ResponseEntity.ok(industryVOList);
    }

}
