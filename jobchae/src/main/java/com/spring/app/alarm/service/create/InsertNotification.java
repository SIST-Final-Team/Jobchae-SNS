package com.spring.app.alarm.service.create;

import com.spring.app.alarm.domain.AlarmData;
import com.spring.app.alarm.domain.AlarmVO;
import com.spring.app.member.domain.MemberVO;
import org.springframework.stereotype.Service;

@Service
public interface InsertNotification {
    //COMMENT, CHAT, FOLLOW, FOLLOWER_POST, LIKE
    public AlarmVO insertNotification(MemberVO memberVO, String TargetId, AlarmData alarmData);
    public AlarmVO.NotificationType NotificationType();
}
