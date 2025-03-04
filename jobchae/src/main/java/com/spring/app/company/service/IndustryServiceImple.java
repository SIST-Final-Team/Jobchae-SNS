package com.spring.app.company.service;

import com.spring.app.company.domain.IndustryVO;
import com.spring.app.company.model.IndustryDAO;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class IndustryServiceImple implements IndustryService{

    IndustryDAO industryDAO;

    // 생성자 주입
    public IndustryServiceImple(IndustryDAO industryDAO) {
        this.industryDAO = industryDAO;
    }

    // 업종 번호로 업종 정보 조회
    public IndustryVO selectIndustryByNo(Long industry_no) {

        IndustryVO industryVO = industryDAO.findById(industry_no).orElse(null);

        // 업종 정보가 없을 경우
        if(industryVO == null){
            throw new RuntimeException("업종 정보가 없습니다.");
        }

        return industryVO;
    }

    // 업종 이름으로 업종 정보 조회
    @Override
    public IndustryVO selectIndustryByName(String industryName) {

        IndustryVO industryVO = industryDAO.findByIndustryName(industryName).orElse(null);

        // 업종 정보가 없을 경우
        if(industryVO == null){
            throw new RuntimeException("업종 정보가 없습니다.");
        }

        return industryVO;
    }

    @Override
    public List<IndustryVO> selectAllIndustry() {

        List<IndustryVO> industryVOList = industryDAO.findAll();
        return industryVOList;
    }

}
