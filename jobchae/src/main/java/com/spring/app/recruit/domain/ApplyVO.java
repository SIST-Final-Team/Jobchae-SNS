package com.spring.app.recruit.domain;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.app.member.domain.MemberVO;

public class ApplyVO {

    private String apply_no; /* 채용지원 일련번호 */
    private String fk_recruit_no; /* 채용공고 일련번호 */
    private String fk_member_id; /* 회원 아이디 */
    private String apply_resume; /* 이력서 파일명 */
    private String apply_register_date; /* 등록일자 */
    private String apply_checked; /* 채용지원 확인여부 */
    private String apply_result; /* 채용지원 분류 */

    // select용
    private String required_score; /* 필수질문 점수 */
    private String advantage_score; /* 기타질문 점수 */

    public String getRequired_score() {
        return required_score;
    }

    public void setRequired_score(String required_score) {
        this.required_score = required_score;
    }

    public String getAdvantage_score() {
        return advantage_score;
    }

    public void setAdvantage_score(String advantage_score) {
        this.advantage_score = advantage_score;
    }

    public String getApply_checked() {
        return apply_checked;
    }

    public void setApply_checked(String apply_checked) {
        this.apply_checked = apply_checked;
    }

    public String getApply_result() {
        return apply_result;
    }

    public void setApply_result(String apply_result) {
        this.apply_result = apply_result;
    }

    public void setAnswerVOList(List<AnswerVO> answerVOList) {
        this.answerVOList = answerVOList;
    }

    private List<AnswerVO> answerVOList; // 선별질문 답변 목록

    private MemberVO memberVO; // 회원정보 조회를 위한 변수

	public MemberVO getMemberVO() {
        return memberVO;
    }

    public void setMemberVO(MemberVO memberVO) {
        this.memberVO = memberVO;
    }

    // 파일 첨부를 위한 변수
	private MultipartFile apply_resume_file;

    public MultipartFile getApply_resume_file() {
        return apply_resume_file;
    }

    public void setApply_resume_file(MultipartFile apply_resume_file) {
        this.apply_resume_file = apply_resume_file;
    }

    public List<AnswerVO> getAnswerVOList() {
        return answerVOList;
    }

    public void setAnswerList(List<AnswerVO> answerVOList) {
        this.answerVOList = answerVOList;
    }

    public String getApply_no() {
        return apply_no;
    }

    public void setApply_no(String apply_no) {
        this.apply_no = apply_no;
    }

    public String getFk_recruit_no() {
        return fk_recruit_no;
    }

    public void setFk_recruit_no(String fk_recruit_no) {
        this.fk_recruit_no = fk_recruit_no;
    }

    public String getFk_member_id() {
        return fk_member_id;
    }

    public void setFk_member_id(String fk_member_id) {
        this.fk_member_id = fk_member_id;
    }

    public String getApply_resume() {
        return apply_resume;
    }

    public void setApply_resume(String apply_resume) {
        this.apply_resume = apply_resume;
    }

    public String getApply_register_date() {
        return apply_register_date;
    }

    public void setApply_register_date(String apply_register_date) {
        this.apply_register_date = apply_register_date;
    }

    public String getTime_ago() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        LocalDateTime dateTime = LocalDateTime.parse(this.apply_register_date, formatter);
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

}
