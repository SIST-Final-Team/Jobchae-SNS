package com.spring.app.recruit.domain;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

public class RecruitVO {
    private String recruit_no; /* 채용공고 일련번호 */
    private String fk_member_id; /* 회원 아이디 */
    private String fk_region_no; /* 지역 일련번호 */
    private String fk_company_no; /* 회사 일련번호 */
    private String recruit_job_name; /* 직종명 */
    private String recruit_work_type; /* 근무유형  대면근무:1, 대면재택혼합근무:2, 재택근무:3 */
    private String recruit_job_type; /* 고용형태  풀타임:1, 파트타임:2, 계약직:3, 임시직:4, 기타:5, 자원봉사:6, 인턴:7 */
    private String recruit_explain_html; /* 역할설명 */
    private String recruit_auto_fail; /* 자동불합격여부 */
    private String recruit_auto_fail_message; /* 불합격이메일메시지 */
    private String recruit_email; /* 기업 이메일 */
    private String recruit_register_date; /* 등록일자 */
    private String recruit_end_date; /* 마감일자 */

    private List<QuestionVO> questionVOList; // 질문 목록

    // 단순 읽어오기/파일쓰기 용도
    private String recruit_explain; /* 역할 설명 html 내용 */
    private String region_name; /* 지역명 */
    private String company_name; /* 기업명 */
    private String company_logo; /* 기업로고 */
    private String apply_cnt; /* 지원자 수 */

    public List<QuestionVO> getQuestionVOList() {
        return questionVOList;
    }

    public void setQuestionVOList(List<QuestionVO> questionVOList) {
        this.questionVOList = questionVOList;
    }
    
    public String getRecruit_explain() {
        return recruit_explain;
    }

    public void setRecruit_explain(String recruit_explain) {
        this.recruit_explain = recruit_explain;
    }

    public String getRecruit_no() {
        return recruit_no;
    }

    public void setRecruit_no(String recruit_no) {
        this.recruit_no = recruit_no;
    }

    public String getFk_member_id() {
        return fk_member_id;
    }

    public void setFk_member_id(String fk_member_id) {
        this.fk_member_id = fk_member_id;
    }

    public String getFk_region_no() {
        return fk_region_no;
    }

    public void setFk_region_no(String fk_region_no) {
        this.fk_region_no = fk_region_no;
    }

    public String getRecruit_job_name() {
        return recruit_job_name;
    }

    public void setRecruit_job_name(String recruit_job_name) {
        this.recruit_job_name = recruit_job_name;
    }

    public String getCompany_name() {
        return company_name;
    }

    public void setCompany_name(String company_name) {
        this.company_name = company_name;
    }

    public String getRecruit_work_type() {
        return recruit_work_type;
    }

    public void setRecruit_work_type(String recruit_work_type) {
        this.recruit_work_type = recruit_work_type;
    }

    public String getRecruit_job_type() {
        return recruit_job_type;
    }

    public void setRecruit_job_type(String recruit_job_type) {
        this.recruit_job_type = recruit_job_type;
    }

    public String getRecruit_explain_html() {
        return recruit_explain_html;
    }

    public void setRecruit_explain_html(String recruit_explain_html) {
        this.recruit_explain_html = recruit_explain_html;
    }

    public String getRecruit_auto_fail() {
        return recruit_auto_fail;
    }

    public void setRecruit_auto_fail(String recruit_auto_fail) {
        this.recruit_auto_fail = recruit_auto_fail;
    }

    public String getRecruit_auto_fail_message() {
        return recruit_auto_fail_message;
    }

    public void setRecruit_auto_fail_message(String recruit_auto_fail_message) {
        this.recruit_auto_fail_message = recruit_auto_fail_message;
    }

    public String getRecruit_email() {
        return recruit_email;
    }

    public void setRecruit_email(String recruit_email) {
        this.recruit_email = recruit_email;
    }

    public String getRecruit_register_date() {
        return recruit_register_date;
    }

    public void setRecruit_register_date(String recruit_register_date) {
        this.recruit_register_date = recruit_register_date;
    }

    public String getRecruit_end_date() {
        return recruit_end_date;
    }

    public void setRecruit_end_date(String recruit_end_date) {
        this.recruit_end_date = recruit_end_date;
    }

    public String getRegion_name() {
        return region_name;
    }

    public void setRegion_name(String region_name) {
        this.region_name = region_name;
    }

    public String getTime_ago() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        LocalDateTime dateTime = LocalDateTime.parse(this.recruit_register_date, formatter);
        LocalDateTime now = LocalDateTime.now();

        Duration duration = Duration.between(dateTime, now);

        long seconds = duration.getSeconds();

        if (seconds < 60) {
            return "방금 전";
        } else if (seconds < 3600) {
            long minutes = seconds / 60;
            return minutes + "분 전";
        } else if (seconds < 86400) {
            long hours = seconds / 3600;
            return hours + "시간 전";
        } else if (seconds < 2592000) {
            long days = seconds / 86400;
            return days + "일 전";
        } else if (seconds < 31104000) {
            long months = seconds / 2592000;
            return months + "달 전";
        } else {
            long years = seconds / 31104000;
            return years + "년 전";
        }
    }
    
    public String getRecruit_closed() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        LocalDateTime dateTime = LocalDateTime.parse(this.recruit_end_date, formatter);
        LocalDateTime now = LocalDateTime.now();

        return dateTime.isAfter(now) ? "0" : "1";
    }
    
    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("RecruitVO {").append("\n")
                .append("  recruit_no='").append(recruit_no).append("',\n")
                .append("  fk_member_id='").append(fk_member_id).append("',\n")
                .append("  fk_region_no='").append(fk_region_no).append("',\n")
                .append("  region_name='").append(region_name).append("',\n")
                .append("  fk_company_no='").append(fk_company_no).append("',\n")
                .append("  company_name='").append(company_name).append("',\n")
                .append("  recruit_job_name='").append(recruit_job_name).append("',\n")
                .append("  recruit_work_type='").append(recruit_work_type).append("',\n")
                .append("  recruit_job_type='").append(recruit_job_type).append("',\n")
                .append("  recruit_explain_html='").append(recruit_explain_html).append("',\n")
                .append("  recruit_auto_fail='").append(recruit_auto_fail).append("',\n")
                .append("  recruit_auto_fail_message='").append(recruit_auto_fail_message).append("',\n")
                .append("  recruit_email='").append(recruit_email).append("',\n")
                .append("  recruit_register_date='").append(recruit_register_date).append("',\n")
                .append("  recruit_end_date='").append(recruit_end_date).append("',\n")
                .append("  recruit_explain='").append(recruit_explain).append("',\n")
                .append("  questionList=");

        if (questionVOList != null && !questionVOList.isEmpty()) {
            sb.append("[\n");
            for (QuestionVO q : questionVOList) {
                sb.append("    ").append(q.toString()).append(",\n");
            }
            sb.append("  ]");
        } else {
            sb.append("[]");
        }

        sb.append("\n}");
        return sb.toString();
    }

    public String getFk_company_no() {
        return fk_company_no;
    }

    public void setFk_company_no(String fk_company_no) {
        this.fk_company_no = fk_company_no;
    }

    public String getCompany_logo() {
        return company_logo;
    }

    public void setCompany_logo(String company_logo) {
        this.company_logo = company_logo;
    }

    public String getApply_cnt() {
        return apply_cnt;
    }

    public void setApply_cnt(String apply_cnt) {
        this.apply_cnt = apply_cnt;
    }
}
