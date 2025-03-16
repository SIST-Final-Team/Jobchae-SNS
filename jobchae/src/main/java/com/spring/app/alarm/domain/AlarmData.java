package com.spring.app.alarm.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
//알림에 들어갈 데이터
public class AlarmData {
    private String BoardId;
    private String BoardTitle;
    private String BoardContent;
    private String CommentId;
    private String CommentContent;
    private String TargetURL;
    
}
