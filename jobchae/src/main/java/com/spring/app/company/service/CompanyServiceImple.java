package com.spring.app.company.service;

import com.spring.app.company.domain.CompanyVO;
import com.spring.app.company.domain.IndustryVO;
import com.spring.app.company.model.CompanyDAO;
import com.spring.app.company.model.IndustryDAO;
import org.springframework.stereotype.Service;

@Service
public class CompanyServiceImple implements CompanyService{

    CompanyDAO companyDAO;
    IndustryService industryService;

    //생성자 주입
    public CompanyServiceImple(CompanyDAO companyDAO, IndustryService industryService) {
        this.companyDAO = companyDAO;
        this.industryService = industryService;
    }

    //회사 번호로 회사 정보 조회
    @Override
    public CompanyVO selectCompany(String company_no) {
        Long companyNo = 0L;
        try {
            companyNo = Long.parseLong(company_no);
        }
        catch (NumberFormatException e) {
            throw new RuntimeException("회사 번호가 올바르지 않습니다.");
        }
        CompanyVO companyInfo = companyDAO.findById(companyNo).orElse(null);

        return companyInfo;
    }

    //회사 입력
    @Override
    public CompanyVO insertCompany(CompanyVO companyVO, String industryName) {


        //업종이름으로 업종 정보 조회
        IndustryVO industryVO = industryService.selectIndustryByName(industryName);
        //TODO : 업종이 없는 값 예외 처리
        

        //회사 생성
        companyVO.setIndustry(industryVO);
        CompanyVO company = companyDAO.save(companyVO);

        return company;
    }

    //회사페이지 중단
    @Override
    public CompanyVO deleteCompany(CompanyVO companyVO) {

        //TODO : 회사가 없는 경우 예외 처리
        //회사의 상태를 중단으로 변경
        companyVO.setCompanyStatus(2);

        // 회사 정보 업데이트
        CompanyVO deletedCompany = companyDAO.save(companyVO);


        return deletedCompany;
    }

    //회사 정보 업데이트
    @Override
    public CompanyVO updateCompany(CompanyVO companyVO) {
        return null;
    }

}
