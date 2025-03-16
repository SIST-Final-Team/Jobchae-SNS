package com.spring.app.history.service;

import java.util.List;

import com.spring.app.history.domain.ProfileViewVO;
import com.spring.app.history.domain.SearchHistoryVO;

public interface HistoryService {

    // 검색 기록 저장 및 조회수 증가
    public void saveSearchHistory(SearchHistoryVO searchHistoryVO);

    // 한 회원의 검색 기록 조회
    public List<SearchHistoryVO> findSearchHistoryByMemberId(String MemberId);

    // 프로필 조회 시 기록 및 조회수 증가
    public void saveProfileView(ProfileViewVO profileViewVO);

    // 한 회원의 프로필 조회 기록 조회
    public List<ProfileViewVO> findProfileViewByMemberId(String MemberId);


}
