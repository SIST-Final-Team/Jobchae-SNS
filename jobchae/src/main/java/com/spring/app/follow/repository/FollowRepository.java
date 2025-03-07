package com.spring.app.follow.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.spring.app.follow.domain.FollowEntity;

public interface FollowRepository extends JpaRepository<FollowEntity, String> {
	
	    List<FollowEntity> findByFollowingId(String followingId);  // 팔로워 목록 조회
	    
	    List<FollowEntity> findByFollowerId(String followerId);  // 팔로잉 목록 조회
	    
	    void deleteByFollowerIdAndFollowingId(String followerId, String followingId);  // 팔로우 관계 삭제
	}


