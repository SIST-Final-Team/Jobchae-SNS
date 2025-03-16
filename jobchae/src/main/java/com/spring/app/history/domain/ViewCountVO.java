package com.spring.app.history.domain;

import org.springframework.data.mongodb.core.mapping.Document;

import jakarta.persistence.Id;
import jakarta.validation.constraints.NotBlank;

@Document(collection = "view_count")
public class ViewCountVO {

    @Id
    private String viewCountNo;           // 조회수 일련번호

    @NotBlank
    private String viewCountTargetId;     // 타겟 일련번호(또는 회원 아이디)
    
    @NotBlank
    private String viewCountTargetType;   // 타겟 유형 // 게시물: board, 채용공고: recruit, 프로필: profile
    
    @NotBlank
    private String viewCountType;         // 유형 // 조회수: 1, 클릭: 2
    
    @NotBlank
    private long viewCount;             // 조회수
    
    @NotBlank
    private String viewCountRegisterDate; // 등록일자

    public String getViewCountNo() {
        return viewCountNo;
    }

    public void setViewCountNo(String viewCountNo) {
        this.viewCountNo = viewCountNo;
    }

    public String getViewCountTargetId() {
        return viewCountTargetId;
    }

    public void setViewCountTargetId(String viewCountTargetId) {
        this.viewCountTargetId = viewCountTargetId;
    }

    public String getViewCountTargetType() {
        return viewCountTargetType;
    }

    public void setViewCountTargetType(String viewCountTargetType) {
        this.viewCountTargetType = viewCountTargetType;
    }

    public String getViewCountType() {
        return viewCountType;
    }

    public void setViewCountType(String viewCountType) {
        this.viewCountType = viewCountType;
    }

    public long getViewCount() {
        return viewCount;
    }

    public void setViewCount(long viewCount) {
        this.viewCount = viewCount;
    }

    public String getViewCountRegisterDate() {
        return viewCountRegisterDate;
    }

    public void setViewCountRegisterDate(String viewCountRegisterDate) {
        this.viewCountRegisterDate = viewCountRegisterDate;
    }

}
