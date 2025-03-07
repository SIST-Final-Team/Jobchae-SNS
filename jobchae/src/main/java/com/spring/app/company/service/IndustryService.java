package com.spring.app.company.service;

import com.spring.app.company.domain.IndustryVO;

import java.util.List;

public interface IndustryService {

    //업종 번호로 업종 정보 조회
    public IndustryVO selectIndustryByNo(Long industry_no);

    //업종 이름으로 업종 정보 조회
    public IndustryVO selectIndustryByName(String industryName);

    //모든 업종 조회
    public List<IndustryVO> selectAllIndustry();

    //검식할 때 나오는 업종 리스트
    public List<IndustryVO> selectIndustryList(String industryName);
}
