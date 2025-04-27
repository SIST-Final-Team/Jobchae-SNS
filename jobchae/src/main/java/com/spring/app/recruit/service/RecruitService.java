package com.spring.app.recruit.service;

import com.spring.app.recruit.domain.RecruitVO;

public interface RecruitService {

    /**
     * 채용공고 등록
     * @param recruitVO
     * @return
     */
    public String insertRecruit(RecruitVO recruitVO);

    /**
     * 채용공고 조회
     * @param recruit_no
     * @return 
     */
    public RecruitVO getRecruit(String recruit_no);

    /**
     * 채용공고 수정
     * @param recruitVO
     */
    public int updateRecruit(RecruitVO recruitVO);
}
