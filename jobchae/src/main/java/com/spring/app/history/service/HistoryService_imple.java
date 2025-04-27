package com.spring.app.history.service;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.aggregation.Aggregation;
import org.springframework.data.mongodb.core.aggregation.AggregationResults;
import org.springframework.data.mongodb.core.aggregation.GroupOperation;
import org.springframework.data.mongodb.core.aggregation.MatchOperation;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Service;
import com.spring.app.config.AES256_Configuration;
import com.spring.app.history.domain.ProfileViewVO;
import com.spring.app.history.domain.SearchHistoryVO;
import com.spring.app.history.domain.ViewCountVO;
import com.spring.app.search.model.SearchDAO;

@Service
public class HistoryService_imple implements HistoryService {

    @Autowired
    MongoTemplate mongoTemplate;

    @Autowired
    SearchDAO searchDAO;

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
    public List<SearchHistoryVO> findSearchHistoryByMemberId(String memberId) {
        Query query = new Query(Criteria.where("memberId").is(memberId))
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

        // 조회수 증가
        increaseViewCount(profileViewVO.getProfileViewMemberId(), "profile", "2");
    }

    // 프로필 방문 기록 조회
    @Override
    public List<ProfileViewVO> findProfileViewByMemberId(String memberId) {
        Query query = new Query(Criteria.where("memberId").is(memberId))
            .with(Sort.by(Sort.Order.desc("profileViewRegisterDate")));

        return mongoTemplate.find(query, ProfileViewVO.class);
    }

    // 한 회원의 조회수 통계 조회
    @Override
    public List<ViewCountVO> findViewCountByMemberId(String memberId, String viewCountTargetType, String viewCountType) {
        // 현재 날짜
        LocalDate currentDate = LocalDate.now();
        // 6일 전 날짜
        LocalDate sixDaysAgo = currentDate.minusDays(6);

        // 날짜 형식 설정 (yyyy-MM-dd)
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        
        // 6일 전부터 현재까지의 날짜 범위 설정
        String sixDaysAgoFormatted = sixDaysAgo.format(formatter);
        String currentDateFormatted = currentDate.format(formatter);

        if("board".equals(viewCountTargetType)) {
            List<String> boardNoList = searchDAO.getBoardNoByMemberId(memberId);
            
            Query query = new Query(Criteria.where("viewCountTargetId").in(boardNoList)
            .and("viewCountTargetType").is(viewCountTargetType)
            .and("viewCountType").is(viewCountType)
            .and("viewCountRegisterDate").gte(sixDaysAgoFormatted).lte(currentDateFormatted));

            return mongoTemplate.find(query, ViewCountVO.class);
        }
        else {
            Query query = new Query(Criteria.where("viewCountTargetId").is(memberId)
                .and("viewCountTargetType").is(viewCountTargetType)
                .and("viewCountType").is(viewCountType)
                .and("viewCountRegisterDate").gte(sixDaysAgoFormatted).lte(currentDateFormatted));
            
            return mongoTemplate.find(query, ViewCountVO.class);
        }

    }

    // 조회수 증가
    @Override
    public void increaseViewCount(String targetId, String targetType, String viewType) {
        SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
        
        String today = DATE_FORMAT.format(new Date());

        // 기존 조회 데이터 있는지 확인
        Query query = new Query(Criteria.where("viewCountTargetId").is(targetId)
                .and("viewCountTargetType").is(targetType)
                .and("viewCountType").is(viewType)
                .and("viewCountRegisterDate").is(today));

        ViewCountVO existingRecord = mongoTemplate.findOne(query, ViewCountVO.class);

        if (existingRecord != null) {
            // 기존 조회수 증가
            long updatedCount = existingRecord.getViewCount() + 1;
            Update update = new Update().set("viewCount", updatedCount);
            mongoTemplate.updateFirst(query, update, ViewCountVO.class);
        } else {
            // 새로운 조회 데이터 삽입
            ViewCountVO newRecord = new ViewCountVO();
            newRecord.setViewCountNo(null); // @Id 필드는 MongoDB에서 자동 생성
            newRecord.setViewCountTargetId(targetId);
            newRecord.setViewCountTargetType(targetType);
            newRecord.setViewCountType(viewType);
            newRecord.setViewCount(1L); // 최초 조회
            newRecord.setViewCountRegisterDate(today);

            mongoTemplate.insert(newRecord);
        }
    }

    // 한 회원의 조회수 통계 요약 조회
    @Override
    public Map<String, String> findViewCountSummaryByMemberId(String memberId) {

        Map<String, String> resultMap = new HashMap<>();

        List<String> boardNoList = searchDAO.getBoardNoByMemberId(memberId);

        // 프로필 방문 횟수
        System.out.print(memberId + " profile"+" 2 : ");
        long viewCount = getTotalViewCount(memberId, "profile", "2");
        resultMap.put("profileViewCount", String.valueOf(viewCount));

        // 게시글 노출 횟수
        System.out.print(boardNoList + " board"+" 1 : ");
        viewCount = getTotalViewCount(boardNoList, "board", "1");
        resultMap.put("boardViewCount", String.valueOf(viewCount));

        // 프로필 검색 노출 횟수
        System.out.print(memberId + " profile"+" 1 : ");
        viewCount = getTotalViewCount(memberId, "profile", "1");
        resultMap.put("searchProfileViewCount", String.valueOf(viewCount));

        return resultMap;
    }

    
    // 특정 대상(targetId, targetType, viewType)의 조회수 합산
    public long getTotalViewCount(String targetId, String targetType, String viewType) {
        // 1. 조건 (해당 targetId와 targetType에 해당하는 문서)
        MatchOperation matchOperation = Aggregation.match(
                Criteria.where("viewCountTargetId").is(targetId)
                        .and("viewCountTargetType").is(targetType)
                        .and("viewCountType").is(viewType)
        );

        // 2. 합산
        GroupOperation groupOperation = Aggregation.group()
                .sum("viewCount").as("totalViews");

        // 3. Aggregation 실행
        Aggregation aggregation = Aggregation.newAggregation(matchOperation, groupOperation);
        AggregationResults<TotalViewResult> result = mongoTemplate.aggregate(aggregation, "view_count", TotalViewResult.class);

        // 결과 반환 (totalViews 값이 없으면 0)
        return result.getUniqueMappedResult() != null ? Objects.requireNonNullElse(result.getUniqueMappedResult().getTotalViews(), 0L) : 0L;
    }

    // 특정 대상 목록(targetIdList, targetType, viewType)의 조회수 합산
    public long getTotalViewCount(List<String> targetIdList, String targetType, String viewType) {
        // 1. 조건 (해당 targetId와 targetType에 해당하는 문서)
        MatchOperation matchOperation = Aggregation.match(
                Criteria.where("viewCountTargetId").in(targetIdList)
                        .and("viewCountTargetType").is(targetType)
                        .and("viewCountType").is(viewType)
        );

        // 2. viewCount 필드 합산
        GroupOperation groupOperation = Aggregation.group()
                .sum("viewCount").as("totalViews");

        // 3. Aggregation 실행
        Aggregation aggregation = Aggregation.newAggregation(matchOperation, groupOperation);
        AggregationResults<TotalViewResult> result = mongoTemplate.aggregate(aggregation, "view_count", TotalViewResult.class);

        // 결과 반환 (totalViews 값이 없으면 0)
        return result.getUniqueMappedResult() != null ? Objects.requireNonNullElse(result.getUniqueMappedResult().getTotalViews(), 0L) : 0L;
    }

    // 결과를 담을 내부 클래스
    private static class TotalViewResult {
        private long totalViews;

        public long getTotalViews() {
            return totalViews;
        }

        public void setTotalViews(long totalViews) {
            this.totalViews = totalViews;
        }
    }

}
