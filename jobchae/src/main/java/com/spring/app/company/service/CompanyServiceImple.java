package com.spring.app.company.service;

import com.spring.app.company.domain.CompanyVO;
import com.spring.app.company.domain.IndustryVO;
import com.spring.app.company.model.CompanyDAO;
import com.spring.app.company.model.IndustryDAO;
import com.spring.app.member.domain.MemberVO;
import com.spring.app.member.model.MemberDAO;
import org.slf4j.ILoggerFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.actuate.logging.LoggersEndpoint;
import org.springframework.stereotype.Service;

@Service
public class CompanyServiceImple implements CompanyService{

    private final LoggersEndpoint loggersEndpoint;
    CompanyDAO companyDAO;
    IndustryService industryService;
    MemberDAO memberDAO;

    private static final Logger logger = LoggerFactory.getLogger(CompanyServiceImple.class);

    //생성자 주입
    public CompanyServiceImple(CompanyDAO companyDAO, IndustryService industryService, LoggersEndpoint loggersEndpoint, MemberDAO memberDAO) {
        this.companyDAO = companyDAO;
        this.industryService = industryService;
        this.loggersEndpoint = loggersEndpoint;
        this.memberDAO = memberDAO;
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

        logger.info(industryName);
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
    public CompanyVO deleteCompany(String companyNo, String memberId) {

        //회사 번호로 회사 정보 조회
        CompanyVO companyVO = selectCompany(companyNo);
        if(!companyVO.getFkMemberId().equals(memberId)) {
            //회사의 소유자가 아닌 경우
            throw new RuntimeException("회사의 소유자가 아닙니다.");
        }


        //TODO : 회사가 없는 경우 예외 처리
        //회사의 상태를 중단으로 변경
        companyVO.setCompanyStatus(2);

        // 회사 정보 업데이트
        CompanyVO deletedCompany = companyDAO.save(companyVO);

        logger.info(deletedCompany.toString());


        return deletedCompany;
    }

    //회사 정보 업데이트
    @Override
    public CompanyVO updateCompany(CompanyVO companyVO, String industryName) {
        IndustryVO industryVO = industryService.selectIndustryByName(industryName);
        companyVO.setIndustry(industryVO);
        logger.info(companyVO.toString());
        CompanyVO company = companyDAO.save(companyVO);
        return company;
    }

}
