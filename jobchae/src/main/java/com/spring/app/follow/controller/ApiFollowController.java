package com.spring.app.follow.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.spring.app.follow.domain.FollowEntity;
import com.spring.app.follow.service.FollowService;

@RestController
@RequestMapping("/follow") 
public class ApiFollowController {

    @Autowired
    private FollowService followService;

    // 팔로우 등록
    @PostMapping
    public ResponseEntity<FollowEntity> follow(@RequestParam String followerId, @RequestParam String followingId) {
        FollowEntity followEntity = followService.follow(followerId, followingId);
        return ResponseEntity.status(HttpStatus.CREATED).body(followEntity);
    }

    // 언팔로우
    @DeleteMapping
    public ResponseEntity<Void> unfollow(@RequestParam String followerId, @RequestParam String followingId) {
        followService.unfollow(followerId, followingId);
        return ResponseEntity.noContent().build();
    }


    // 팔로워 목록 조회
    @GetMapping("/followers")
    public List<FollowEntity> getFollowers(@RequestParam String followingId) {
        return followService.getFollowers(followingId);
    }

    // 팔로잉 목록 조회
    @GetMapping("/following")
    public List<FollowEntity> getFollowing(@RequestParam String followerId) {
        return followService.getFollowing(followerId);
    }
    
	 // 팔로우/언팔로우 상태 토글
	    @PostMapping("/toggle")
	    public ResponseEntity<String> toggleFollow(@RequestParam String followerId, @RequestParam String followingId) {
        boolean isFollowed = followService.toggleFollow(followerId, followingId);

        // 상태에 따른 응답
        if (isFollowed) {
            return ResponseEntity.ok("팔로우되었습니다.");
        } else {
            return ResponseEntity.ok("언팔로우되었습니다.");
        }
    }
    
}
