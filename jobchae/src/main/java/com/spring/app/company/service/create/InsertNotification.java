package com.spring.app.company.service.create;

import com.spring.app.alarm.domain.AlarmVO;

public interface InsertNotification {
    //COMMENT, CHAT, FOLLOW, FOLLOWER_POST, LIKE
    public AlarmVO insertNotification();
    public AlarmVO.NotificationType NotificationType();
}
