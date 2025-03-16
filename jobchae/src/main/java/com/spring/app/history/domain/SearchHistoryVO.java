package com.spring.app.history.domain;

import org.springframework.data.mongodb.core.mapping.Document;
import jakarta.persistence.Id;
import jakarta.validation.constraints.NotBlank;

@Document(collection = "search_history")
public class SearchHistoryVO {

    @Id
    private String searchHistoryNo;           // 검색기록 일련번호
    
    @NotBlank
    private String memberId;                  // 회원 아이디

    @NotBlank
    private String searchHistoryWord;         // 검색어

    @NotBlank
    private String searchHistoryRegisterDate; // 등록일자

    public String getSearchHistoryNo() {
        return searchHistoryNo;
    }

    public void setSearchHistoryNo(String searchHistoryNo) {
        this.searchHistoryNo = searchHistoryNo;
    }

    public String getMemberId() {
        return memberId;
    }

    public void setMemberId(String memberId) {
        this.memberId = memberId;
    }

    public String getSearchHistoryWord() {
        return searchHistoryWord;
    }

    public void setSearchHistoryWord(String searchHistoryWord) {
        this.searchHistoryWord = searchHistoryWord;
    }

    public String getSearchHistoryRegisterDate() {
        return searchHistoryRegisterDate;
    }

    public void setSearchHistoryRegisterDate(String searchHistoryRegisterDate) {
        this.searchHistoryRegisterDate = searchHistoryRegisterDate;
    }

}
