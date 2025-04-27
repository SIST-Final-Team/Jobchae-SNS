package com.spring.app.recruit.domain;

public class QuestionVO {
    private String question_no; /* 선별질문 일련번호 */
    private String fk_recruit_no; /* 채용공고 일련번호 */
    private String question_query; /* 질문 */
    private String question_type; /* 답변유형 */
    private String question_correct; /* 모범답안 */
    private String question_required; /* 필수여부 */

    public String getQuestion_no() {
        return question_no;
    }

    public void setQuestion_no(String question_no) {
        this.question_no = question_no;
    }

    public String getFk_recruit_no() {
        return fk_recruit_no;
    }

    public void setFk_recruit_no(String fk_recruit_no) {
        this.fk_recruit_no = fk_recruit_no;
    }

    public String getQuestion_query() {
        return question_query;
    }

    public void setQuestion_query(String question_query) {
        this.question_query = question_query;
    }

    public String getQuestion_type() {
        return question_type;
    }

    public void setQuestion_type(String question_type) {
        this.question_type = question_type;
    }

    public String getQuestion_correct() {
        return question_correct;
    }

    public void setQuestion_correct(String question_correct) {
        this.question_correct = question_correct;
    }

    public String getQuestion_required() {
        return question_required;
    }

    public void setQuestion_required(String question_required) {
        this.question_required = question_required;
    }

    @Override
    public String toString() {
        return "QuestionVO {" +
                "question_no='" + question_no + '\'' +
                ", fk_recruit_no='" + fk_recruit_no + '\'' +
                ", question_query='" + question_query + '\'' +
                ", question_type='" + question_type + '\'' +
                ", question_correct='" + question_correct + '\'' +
                ", question_required='" + question_required + '\'' +
                '}';
    }
}
