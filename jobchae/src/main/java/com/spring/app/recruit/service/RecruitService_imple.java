package com.spring.app.recruit.service;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.common.AES256;
import com.spring.app.recruit.domain.AnswerVO;
import com.spring.app.recruit.domain.ApplyVO;
import com.spring.app.recruit.domain.QuestionVO;
import com.spring.app.recruit.domain.RecruitVO;
import com.spring.app.recruit.model.RecruitDAO;

@Service
public class RecruitService_imple implements RecruitService {

    @Autowired
    private RecruitDAO dao;

    @Autowired
    private AES256 aes256;
    @Autowired
    private RecruitDAO recruitDAO;

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

        // System.out.println(recruitVO);

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

    @Override
    public List<RecruitVO> getRecruitListByMemberId(Map<String, String> params) {
        return dao.getRecruitListByMemberId(params);
    }

    @Override
    public int closeRecruit(Map<String, String> paraMap) {
        return dao.closeRecruit(paraMap);
    }

    @Override
    public String insertApply(ApplyVO applyVO) {
        applyVO.setApply_no(dao.getSeqApplyNo()); // 채용지원 일련번호 채번

        dao.insertApply(applyVO);

        // 선별질문 답변이 존재한다면
        if(applyVO.getAnswerVOList() != null) {
            for(AnswerVO answerVO: applyVO.getAnswerVOList()) {
                answerVO.setFk_apply_no(applyVO.getApply_no());

                dao.insertAnswer(answerVO);
            }
        }

        return applyVO.getApply_no();
    }

    @Override
    public List<ApplyVO> getApplyByRecruitNo(Map<String, Object> params) {

        List<ApplyVO> ApplyVOList = dao.getApplyByRecruitNo(params);

        // 이메일 복호화
        for(ApplyVO applyVO : ApplyVOList) {
            try {
                String member_email = aes256.decrypt(applyVO.getMemberVO().getMember_email());
                applyVO.getMemberVO().setMember_email(member_email);
            } catch (GeneralSecurityException | UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }

        return ApplyVOList;
    }

    @Override
    public List<Map<String, String>> getApplyRegionList(String recruit_no) {
        return dao.getApplyRegionList(recruit_no);
    }

    @Override
    public List<Map<String, String>> getApplySkillList(String recruit_no) {
        return dao.getApplySkillList(recruit_no);
    }

    @Override
    public int getTotalApplyCount(String recruit_no) {
        return dao.getTotalApplyCount(recruit_no);
    }

    @Override
    public int getSearchApplyCount(Map<String, Object> params) {
        return dao.getSearchApplyCount(params);
    }

    @Override
    public int updateApplyResult(ApplyVO applyVO) {
        return dao.updateApplyResult(applyVO);
    }

    @Override
    public int updateApplyChecked(String apply_no) {
        return dao.updateApplyChecked(apply_no);
    }

    @Override
    public List<RecruitVO> getRecruitSaveListByMemberId(Map<String, String> params) {
        return dao.getRecruitSaveListByMemberId(params);
    }

    // 연규영의 메서드
    @Override
    public List<RecruitVO> getRecruitListByCompanyNo(int company_no){
        List<RecruitVO> recruitList = dao.getRecruitListByCompanyNo(company_no);

        return recruitList;
    }
}
