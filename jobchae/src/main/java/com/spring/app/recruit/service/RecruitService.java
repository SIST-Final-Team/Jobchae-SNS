package com.spring.app.recruit.service;

import java.util.List;
import java.util.Map;

import com.spring.app.recruit.domain.ApplyVO;
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

    /**
     * 회원 아이디로 작성한 채용공고 목록 조회
     * @param params
     * login_member_id: 로그인한 회원 아이디,
     * recruit_closed: 채용공고 마감 여부,
	 * start: 시작 번호, end: 끝 번호
     * @return
     */
    public List<RecruitVO> getRecruitListByMemberId(Map<String, String> params);

    /**
     * 채용공고 마감
     * @param paraMap
     * login_member_id: 로그인한 회원 아이디,
     * recruit_no: 채용공고 일련번호
     * @return
     */
    public int closeRecruit(Map<String, String> paraMap);

    /**
     * 채용지원 등록
     * @param applyVO
     * @return
     */
    public String insertApply(ApplyVO applyVO);

    /**
     * 채용공고 번호로 채용지원 목록 조회
     * @param params
     * recruit_no: 채용공고 일련번호,
     * searchApplyOrderBy : 정렬 기준(registerdate, member_name)
     * searchApplyResultList : 평가 결과(적임자, 부적임자 등)
     * searchApplyRegionList : 지역 선택 목록
     * searchApplyCareerYear : 경력 연차(N년차)
     * searchApplySkillList : 전문분야 선택 목록
	 * start: 시작 번호, end: 끝 번호
     * @return
     */
    public List<ApplyVO> getApplyByRecruitNo(Map<String, Object> params);

    /**
     * 채용공고 일련번호로 채용지원의 지역 목록 조회
     * @param recruit_no
     * @return
     */
    public List<Map<String, String>> getApplyRegionList(String recruit_no);

    /**
     * 채용공고 일련번호로 채용지원의 전문분야 목록 조회
     * @param recruit_no
     * @return
     */
    public List<Map<String, String>> getApplySkillList(String recruit_no);

    /**
     * 채용공고의 총 지원자 수
     * @param recruit_no
     * @return
     */
    public int getTotalApplyCount(String recruit_no);

    /**
     * 채용공고의 필터링 된 지원자 수
     * @param params
     * @return
     */
    public int getSearchApplyCount(Map<String, Object> params);

    /**
     * 채용지원 결과 분류 수정
     * @param applyVO 채용지원 VO
     * @return
     */
    public int updateApplyResult(ApplyVO applyVO);

    /**
     * 채용지원 최초 확인
     *
     * @param apply_no 채용지원 일련번호
     * @return
     */
    int updateApplyChecked(String apply_no);

    /**
     * 회원 아이디로 작성한 채용공고 목록 조회
     * @param params
     * login_member_id: 로그인한 회원 아이디,
     * recruit_closed: 채용공고 마감 여부,
     * start: 시작 번호, end: 끝 번호
     */
    List<RecruitVO> getRecruitSaveListByMemberId(Map<String, String> params);
}
