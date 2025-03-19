package com.spring.app.follow.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.spring.app.alarm.domain.AlarmData;
import com.spring.app.alarm.domain.AlarmVO;
import com.spring.app.alarm.service.AlarmService;
import com.spring.app.member.domain.MemberVO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.spring.app.follow.domain.FollowEntity;
import com.spring.app.follow.service.FollowService;

@RestController
@RequestMapping("/api/follow") 
public class ApiFollowController {

    @Autowired
    private FollowService followService;
    @Autowired
    private AlarmService alarmService;
    @Autowired
    private SimpMessagingTemplate simpMessagingTemplate;

    // 팔로우 등록
    @PostMapping
    public ResponseEntity<FollowEntity> follow(@RequestParam String followerId, @RequestParam String followingId, HttpServletRequest request) {
        FollowEntity followEntity = followService.follow(followerId, followingId);
        //알림 등록

        HttpSession session = request.getSession();
        MemberVO member = (MemberVO) session.getAttribute("loginuser");
        AlarmData alarmData = new AlarmData();
        alarmService.insertAlarm(member, followingId, AlarmVO.NotificationType.FOLLOW, alarmData);
        simpMessagingTemplate.convertAndSendToUser(followingId, "/topic/alarm", alarmData);
        //알림 등록 끝

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
    public ResponseEntity<Map<String, String>> toggleFollow(@RequestParam String followerId, @RequestParam String followingId) {
        boolean isFollowed = followService.toggleFollow(followerId, followingId);

        Map<String, String> response = new HashMap<>();
        if (isFollowed) {
            response.put("status", "팔로우되었습니다.");
        } else {
            response.put("status", "언팔로우되었습니다.");
        }

        return ResponseEntity.ok(response);  // JSON 형태로 응답
    }
    
}
