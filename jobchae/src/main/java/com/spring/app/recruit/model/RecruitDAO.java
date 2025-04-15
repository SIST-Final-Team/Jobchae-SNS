package com.spring.app.recruit.model;

import org.apache.ibatis.annotations.Mapper;

import com.spring.app.recruit.domain.QuestionVO;
import com.spring.app.recruit.domain.RecruitVO;

@Mapper
public interface RecruitDAO {

    // 채용공고 일련번호 채번
    String getSeqRecruitNo();

    // 채용공고 등록
    void insertRecruit(RecruitVO recruitVO);

    // 채용공고 질문 목록 등록
    void insertQuestion(QuestionVO questionVO);

    // 채용공고 조회
    RecruitVO getRecruit(String recruit_no);

    // 채용공고 수정
    int updateRecruit(RecruitVO recruitVO);

}
