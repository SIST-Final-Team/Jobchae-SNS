package com.spring.app.follow.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.spring.app.follow.domain.FollowEntity;
import com.spring.app.follow.repository.FollowRepository;

@Service
public class FollowService_imple implements FollowService{

	    private final FollowRepository followRepository;

	    public FollowService_imple(FollowRepository followRepository) {
	        this.followRepository = followRepository;
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
	}

