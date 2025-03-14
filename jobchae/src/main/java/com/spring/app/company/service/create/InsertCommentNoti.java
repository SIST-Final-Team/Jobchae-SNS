package com.spring.app.company.service.create;

import com.spring.app.alarm.domain.AlarmVO;
import org.springframework.stereotype.Service;

@Service
public class InsertCommentNoti implements InsertNotification {
    @Override
    public AlarmVO insertNotification() {
        return null;
    }

    @Override
    public AlarmVO.NotificationType NotificationType() {
        return AlarmVO.NotificationType.COMMENT;
    }
}
