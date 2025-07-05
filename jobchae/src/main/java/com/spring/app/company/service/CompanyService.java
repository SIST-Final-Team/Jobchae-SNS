package com.spring.app.company.service;

import com.spring.app.company.domain.CompanyVO;

import java.util.List;

public interface CompanyService {

    //회사 번호로 회사 정보 조회
    CompanyVO selectCompany(String company_no);

    //회사 입력
    CompanyVO insertCompany(CompanyVO companyVO, String industryName);

    //회사페이지 중단
    CompanyVO deleteCompany(String companyNo, String memberId);

    //회사 정보 업데이트
    CompanyVO updateCompany(CompanyVO companyVO, String industryName);

    //회사 통계 조회

    //멤버 아이디로 회사 정보 조회
    List<CompanyVO> selectCompanyByMemberId(String memberId);


}
