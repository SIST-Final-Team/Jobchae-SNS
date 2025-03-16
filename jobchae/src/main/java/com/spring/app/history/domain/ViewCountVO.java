package com.spring.app.history.domain;

import org.springframework.data.mongodb.core.mapping.Document;

import jakarta.persistence.Id;
import jakarta.validation.constraints.NotBlank;

@Document(collection = "view_count")
public class ViewCountVO {

    @Id
    private String countNo;           // 조회수 일련번호

    @NotBlank
    private String countTargetId;     // 타겟 일련번호(또는 회원 아이디)
    
    @NotBlank
    private String countTargetType;   // 타겟 유형 // 게시물: board, 채용공고: recruit, 프로필: profile
    
    @NotBlank
    private String countType;         // 유형 // 조회수: 1, 클릭: 2
    
    @NotBlank
    private String countRegisterDate; // 등록일자

    public String getCountNo() {
        return countNo;
    }

    public void setCountNo(String countNo) {
        this.countNo = countNo;
    }

    public String getCountTargetId() {
        return countTargetId;
    }

    public void setCountTargetId(String countTargetId) {
        this.countTargetId = countTargetId;
    }

    public String getCountTargetType() {
        return countTargetType;
    }

    public void setCountTargetType(String countTargetType) {
        this.countTargetType = countTargetType;
    }

    public String getCountType() {
        return countType;
    }

    public void setCountType(String countType) {
        this.countType = countType;
    }

    public String getCountRegisterDate() {
        return countRegisterDate;
    }

    public void setCountRegisterDate(String countRegisterDate) {
        this.countRegisterDate = countRegisterDate;
    }
}
