package com.spring.app.company.service;

import com.spring.app.company.domain.IndustryVO;

import java.util.List;

public interface IndustryService {

    //업종 번호로 업종 정보 조회
    public IndustryVO selectIndustryByNo(Long industry_no);

    public IndustryVO selectIndustryByName(String industryName);

    public List<IndustryVO> selectAllIndustry();
}
