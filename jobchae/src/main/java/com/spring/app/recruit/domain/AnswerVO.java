package com.spring.app.recruit.domain;

public class AnswerVO {

    private String answer_no; /* 선별질문 답변 */
    private String fk_question_no; /* 선별질문 일련번호 */
    private String fk_apply_no; /* 채용지원 일련번호 */
    private String answer_query; /* 답변 */

    public String getAnswer_no() {
        return answer_no;
    }

    public void setAnswer_no(String answer_no) {
        this.answer_no = answer_no;
    }

    public String getFk_question_no() {
        return fk_question_no;
    }

    public void setFk_question_no(String fk_question_no) {
        this.fk_question_no = fk_question_no;
    }

    public String getFk_apply_no() {
        return fk_apply_no;
    }

    public void setFk_apply_no(String fk_apply_no) {
        this.fk_apply_no = fk_apply_no;
    }

    public String getAnswer_query() {
        return answer_query;
    }

    public void setAnswer_query(String answer_query) {
        this.answer_query = answer_query;
    }
}
