package com.spring.app.follow.service;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import com.fasterxml.jackson.core.type.TypeReference;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.app.follow.domain.FollowEntity;
import com.spring.app.follow.repository.FollowRepository;

@Service
public class FollowService_imple implements FollowService{

		@Value("${api.recommendation.url}")
		private String recommendationApiUrl; // R 서버 URL

	    private final FollowRepository followRepository;
	    
	    // RestTemplate 필드 추가
	    private final RestTemplate restTemplate;

	    // 생성자에 RestTemplate 초기화 추가
	    public FollowService_imple(FollowRepository followRepository) {
	        this.followRepository = followRepository;
	        this.restTemplate = new RestTemplate();  
	    }
	    
	    @Override
	    public FollowEntity follow(String followerId, String followingId) {
	        // 팔로우 로직
	        FollowEntity followEntity = new FollowEntity(followerId, followingId);
	        return followRepository.save(followEntity);
	    }

	    @Override
	    public void unfollow(String followerId, String followingId) {
	        // 언팔로우 로직
	        followRepository.deleteByFollowerIdAndFollowingId(followerId, followingId);
	    }

	    @Override
	    public List<FollowEntity> getFollowers(String followingId) {
	        // 팔로워 목록 조회
	        return followRepository.findByFollowingId(followingId);
	    }

	    @Override
	    public List<FollowEntity> getFollowing(String followerId) {
	        // 팔로잉 목록 조회
	        return followRepository.findByFollowerId(followerId);
	    }

	    @Override
	    public boolean toggleFollow(String followerId, String followingId) {
	        // 팔로우 관계가 존재하는지 확인
	        FollowEntity followEntity = followRepository.findByFollowerIdAndFollowingId(followerId, followingId);
	        
	        if (followEntity != null) {
	            // 팔로우가 이미 존재하면 언팔로우 (삭제)
	            followRepository.delete(followEntity);
	            return false; // 언팔로우 되었다고 반환
	        } else {
	            // 팔로우가 존재하지 않으면 팔로우 등록
	            FollowEntity newFollow = new FollowEntity(followerId, followingId);
	            followRepository.save(newFollow);
	            return true; // 팔로우 되었다고 반환
	        }
	    }
	    
	    /**
	     * R 추천 시스템에서 추천받은 팔로우 대상자 리스트 받아
	     * followerId 사용자가 해당 대상자를 모두 팔로우하도록 등록한다.
	     */
	 
	    public void followRecommendedUsers(String followerId) {
	        // 여기서 먼저 URL 정의
	        String rServerUrl = recommendationApiUrl + "?userId=" + followerId;

	        try {
	            String rawJson = restTemplate.getForObject(rServerUrl, String.class);
	            
	            ObjectMapper mapper = new ObjectMapper();
	            JsonNode root = mapper.readTree(rawJson);

	            if (root.has("error")) {
	                String errorMessage = root.get("error").get(0).asText();
	                throw new RuntimeException("R 서버 에러 발생: " + errorMessage);
	            } else if (root.isArray()) {
	                List<String> recommendedUserIds = mapper.convertValue(root, new TypeReference<List<String>>() {});
	                for (String userId : recommendedUserIds) {
	                    System.out.println("추천된 사용자 ID: " + userId);
	                }
	            } else {
	                throw new RuntimeException("R 서버에서 예상치 못한 응답을 받음");
	            }
	        } catch (IOException e) {
	            throw new RuntimeException("JSON 파싱 오류 발생: " + e.getMessage(), e);
	        }
	    }

	   
}

