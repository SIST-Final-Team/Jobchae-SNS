package com.spring.app.history.domain;

import org.springframework.data.mongodb.core.mapping.Document;

import jakarta.persistence.Id;
import jakarta.validation.constraints.NotBlank;

@Document(collection = "profile_view")
public class ProfileViewVO {

    @Id
    private String profileViewNo;

    @NotBlank
    private String memberId;

    @NotBlank
    private String profileViewMemberId;

    @NotBlank
    private String profileViewRegisterDate;

    public String getProfileViewNo() {
        return profileViewNo;
    }

    public void setProfileViewNo(String profileViewNo) {
        this.profileViewNo = profileViewNo;
    }

    public String getMemberId() {
        return memberId;
    }

    public void setMemberId(String memberId) {
        this.memberId = memberId;
    }

    public String getProfileViewMemberId() {
        return profileViewMemberId;
    }

    public void setProfileViewMemberId(String profileViewMemberId) {
        this.profileViewMemberId = profileViewMemberId;
    }

    public String getProfileViewRegisterDate() {
        return profileViewRegisterDate;
    }

    public void setProfileViewRegisterDate(String profileViewRegisterDate) {
        this.profileViewRegisterDate = profileViewRegisterDate;
    }

}
