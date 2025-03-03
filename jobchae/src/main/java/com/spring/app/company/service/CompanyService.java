package com.spring.app.company.service;

import com.spring.app.company.domain.CompanyVO;

public interface CompanyService {

    //회사 번호로 회사 정보 조회
    CompanyVO selectCompany(String company_no);

    //회사 입력
    CompanyVO insertCompany(CompanyVO companyVO);

    //회사페이지 중단
    CompanyVO deleteCompany(CompanyVO companyVO);

    //회사 정보 업데이트
    CompanyVO updateCompany(CompanyVO companyVO);


}
