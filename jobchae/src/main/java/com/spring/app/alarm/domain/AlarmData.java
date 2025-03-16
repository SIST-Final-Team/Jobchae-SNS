package com.spring.app.alarm.domain;

import lombok.Getter;
import lombok.Setter;


//알림에 들어갈 데이터
public class AlarmData {
    private String BoardId;
    private String BoardTitle;
    private String BoardContent;
    private String CommentId;
    private String CommentContent;
    private String TargetURL;

    public String getBoardId() {
        return BoardId;
    }

    public void setBoardId(String boardId) {
        BoardId = boardId;
    }

    public String getBoardTitle() {
        return BoardTitle;
    }

    public void setBoardTitle(String boardTitle) {
        BoardTitle = boardTitle;
    }

    public String getBoardContent() {
        return BoardContent;
    }

    public void setBoardContent(String boardContent) {
        BoardContent = boardContent;
    }

    public String getCommentId() {
        return CommentId;
    }

    public void setCommentId(String commentId) {
        CommentId = commentId;
    }

    public String getCommentContent() {
        return CommentContent;
    }

    public void setCommentContent(String commentContent) {
        CommentContent = commentContent;
    }

    public String getTargetURL() {
        return TargetURL;
    }

    public void setTargetURL(String targetURL) {
        TargetURL = targetURL;
    }
}
