package com.spring.app.recruit.service;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.common.AES256;
import com.spring.app.recruit.domain.QuestionVO;
import com.spring.app.recruit.domain.RecruitVO;
import com.spring.app.recruit.model.RecruitDAO;

@Service
public class RecruitService_imple implements RecruitService {

    @Autowired
    private RecruitDAO dao;

    @Autowired
    private AES256 aes256;

    @Override
    public String insertRecruit(RecruitVO recruitVO) {

        recruitVO.setRecruit_no(dao.getSeqRecruitNo()); // 채용공고 일련번호 채번

        // 이메일 암호화
        String email = recruitVO.getRecruit_email();
        try {
            recruitVO.setRecruit_email(aes256.encrypt(email));
        } catch (UnsupportedEncodingException | GeneralSecurityException e) {
            e.printStackTrace();
        }
        
        if(recruitVO.getRecruit_auto_fail() == null) {
            recruitVO.setRecruit_auto_fail("0");
        }

        System.out.println(recruitVO);

        dao.insertRecruit(recruitVO); // 채용공고 등록

        // 질문 목록이 존재한다면
        if(recruitVO.getQuestionVOList() != null) {
            for(QuestionVO questionVO: recruitVO.getQuestionVOList()) {
                questionVO.setFk_recruit_no(recruitVO.getRecruit_no());

                if(questionVO.getQuestion_required() == null) {
                    questionVO.setQuestion_required("0");
                }

                dao.insertQuestion(questionVO);
            }
        }

        return recruitVO.getRecruit_no();
    }

    @Override
    public RecruitVO getRecruit(String recruit_no) {
        return dao.getRecruit(recruit_no);
    }

    @Override
    public int updateRecruit(RecruitVO recruitVO) {
        return dao.updateRecruit(recruitVO);
    }
}
