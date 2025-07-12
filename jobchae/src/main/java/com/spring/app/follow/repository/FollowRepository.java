package com.spring.app.follow.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import com.spring.app.follow.domain.FollowEntity;

@Transactional
public interface FollowRepository extends JpaRepository<FollowEntity, Long> {
	
	    List<FollowEntity> findByFollowingId(String followingId);  // 팔로워 목록 조회
	    
	    List<FollowEntity> findByFollowerId(String followerId);  // 팔로잉 목록 조회
	    
	    void deleteByFollowerIdAndFollowingId(String followerId, String followingId);  // 팔로우 관계 삭제

		FollowEntity findByFollowerIdAndFollowingId(String followerId, String followingId); // 팔로우 

		
		
		// 특정 팔로워가 팔로우한 모든 사용자 아이디 리스트 반환 메소드
		@Query("SELECT f.followingId FROM FollowEntity f WHERE f.followerId = :followerId")
		List<String> findFollowingIdsByFollowerId(@Param("followerId") String followerId);



	
}


