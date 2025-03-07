package com.spring.app.follow.service;

import com.spring.app.follow.domain.FollowEntity;
import java.util.List;

public interface FollowService {
    // 팔로우 등록
    FollowEntity follow(String followerId, String followingId);

    // 언팔로우
    void unfollow(String followerId, String followingId);

    // 팔로워 목록 조회
    List<FollowEntity> getFollowers(String followingId);

    // 팔로잉 목록 조회
    List<FollowEntity> getFollowing(String followerId);
}
