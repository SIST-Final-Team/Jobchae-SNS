package com.spring.app.history.service;

import java.util.List;
import java.util.Map;

import com.spring.app.history.domain.ProfileViewVO;
import com.spring.app.history.domain.SearchHistoryVO;
import com.spring.app.history.domain.ViewCountVO;

public interface HistoryService {

    // 검색 기록 저장 및 조회수 증가
    public void saveSearchHistory(SearchHistoryVO searchHistoryVO);

    // 한 회원의 검색 기록 조회
    public List<SearchHistoryVO> findSearchHistoryByMemberId(String memberId);

    // 프로필 조회 시 기록 및 조회수 증가
    public void saveProfileView(ProfileViewVO profileViewVO);

    // 한 회원의 프로필 조회 기록 조회
    public List<ProfileViewVO> findProfileViewByMemberId(String memberId);

    // 조회수 증가
    public void increaseViewCount(String targetId, String targetType, String viewType);

    // 한 회원의 조회수 통계 조회
    public List<ViewCountVO> findViewCountByMemberId(String memberId, String viewCountTargetType, String viewCountType);

    /**
     * 한 회원의 조회수 통계 요약 조회
     * @param memberId
     * @return profileViewCount, boardViewCount, searchProfileViewCount
     */
    public Map<String, String> findViewCountSummaryByMemberId(String memberId);
}
