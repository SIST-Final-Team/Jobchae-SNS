package com.spring.app.recruit.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.spring.app.recruit.domain.AnswerVO;
import com.spring.app.recruit.domain.ApplyVO;
import com.spring.app.recruit.domain.QuestionVO;
import com.spring.app.recruit.domain.RecruitVO;

@Mapper
public interface RecruitDAO {

    // 채용공고 일련번호 채번
    String getSeqRecruitNo();

    // 채용공고 등록
    void insertRecruit(RecruitVO recruitVO);

    // 채용공고 질문 등록
    void insertQuestion(QuestionVO questionVO);

    // 채용공고 조회
    RecruitVO getRecruit(String recruit_no);

    // 채용공고 수정
    int updateRecruit(RecruitVO recruitVO);

    // 회원 아이디로 작성한 채용공고 목록 조회
    List<RecruitVO> getRecruitListByMemberId(Map<String, String> params);

    // 채용공고 마감
    int closeRecruit(Map<String, String> paraMap);

    // 채용지원 일련번호 채번
    String getSeqApplyNo();

    // 채용지원 등록
    void insertApply(ApplyVO applyVO);

    // 선별질문 답변 등록
    void insertAnswer(AnswerVO answerVO);

    // 채용공고 번호로 채용지원 목록 조회
    List<ApplyVO> getApplyByRecruitNo(Map<String, Object> params);

    // 채용공고 일련번호로 채용지원의 지역 목록 조회
    List<Map<String, String>> getApplyRegionList(String recruit_no);

    // 채용공고 일련번호로 채용지원의 전문분야 목록 조회
    List<Map<String, String>> getApplySkillList(String recruit_no);

    // 채용공고의 총 지원자 수
    int getTotalApplyCount(String recruit_no);

    // 채용공고의 필터링 된 지원자 수
    int getSearchApplyCount(Map<String, Object> params);

    // 채용지원 결과 분류 수정
    int updateApplyResult(ApplyVO applyVO);

    // 채용지원 최초 확인
    int updateApplyChecked(String apply_no);

    // 회원 아이디로 지원 또는 저장한 채용공고 목록 조회
    List<RecruitVO> getRecruitSaveListByMemberId(Map<String, String> params);

}
