package com.spring.app.history.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Service;

import com.spring.app.history.domain.ProfileViewVO;
import com.spring.app.history.domain.SearchHistoryVO;

@Service
public class HistoryService_imple implements HistoryService {

    @Autowired
    MongoTemplate mongoTemplate;

    // 검색 기록 저장 및 조회수 증가
    @Override
    public void saveSearchHistory(SearchHistoryVO searchHistoryVO) {
        
        // 검색어가 중복이면 업데이트하기 위한 쿼리
        Query query = new Query(
            Criteria.where("memberId").is(searchHistoryVO.getMemberId())
                    .and("searchHistoryWord").is(searchHistoryVO.getSearchHistoryWord())
        );

        Update update = new Update()
            .set("searchHistoryRegisterDate", searchHistoryVO.getSearchHistoryRegisterDate());

        // 검색어가 중복이면 업데이트, 없으면 추가
        mongoTemplate.upsert(query, update, SearchHistoryVO.class);
        
    	// 회원의 검색 기록 개수를 확인
        Query countQuery = new Query(Criteria.where("memberId").is(searchHistoryVO.getMemberId()));
        long count = mongoTemplate.count(countQuery, SearchHistoryVO.class);

        // 기록이 10개를 초과할 경우 가장 오래된 검색 기록을 삭제
        if (count > 10) {
            Query deleteQuery = new Query(Criteria.where("memberId").is(searchHistoryVO.getMemberId()))
                    .with(Sort.by(Sort.Order.asc("searchHistoryRegisterDate")))  // 오래된 순서대로 정렬
                    .limit(1);  // 가장 오래된 기록 하나만 삭제
            mongoTemplate.remove(deleteQuery, SearchHistoryVO.class);
        }
        
        // TODO : 검색 횟수 저장하기
    }

    // 한 회원의 검색 기록 조회
    @Override
    public List<SearchHistoryVO> findSearchHistoryByMemberId(String MemberId) {
        Query query = new Query(Criteria.where("memberId").is(MemberId))
            .with(Sort.by(Sort.Order.desc("searchHistoryRegisterDate")));

        return mongoTemplate.find(query, SearchHistoryVO.class);
    }

    // 프로필 조회 시 기록 및 조회수 증가
    @Override
    public void saveProfileView(ProfileViewVO profileViewVO) {
        
        // 프로필 조회 기록이 중복이면 업데이트하기 위한 쿼리
        Query query = new Query(
            Criteria.where("memberId").is(profileViewVO.getMemberId())
                    .and("profileViewMemberId").is(profileViewVO.getProfileViewMemberId())
        );

        Update update = new Update()
            .set("profileViewRegisterDate", profileViewVO.getProfileViewRegisterDate());

        // 프로필 조회 기록이 중복이면 업데이트, 없으면 추가
        mongoTemplate.upsert(query, update, ProfileViewVO.class);

    	// 회원의 프로필 조회 기록 개수를 확인
        Query countQuery = new Query(Criteria.where("memberId").is(profileViewVO.getMemberId()));
        long count = mongoTemplate.count(countQuery, ProfileViewVO.class);

        // 기록이 5개를 초과할 경우 가장 오래된 프로필 조회 기록을 삭제
        if (count > 5) {
            Query deleteQuery = new Query(Criteria.where("memberId").is(profileViewVO.getMemberId()))
                    .with(Sort.by(Sort.Order.asc("profileViewRegisterDate")))  // 오래된 순서대로 정렬
                    .limit(1);  // 가장 오래된 기록 하나만 삭제
            mongoTemplate.remove(deleteQuery, ProfileViewVO.class);
        }
    }

    @Override
    public List<ProfileViewVO> findProfileViewByMemberId(String MemberId) {
        Query query = new Query(Criteria.where("memberId").is(MemberId))
            .with(Sort.by(Sort.Order.desc("profileViewRegisterDate")));

        return mongoTemplate.find(query, ProfileViewVO.class);
    }

}
