package com.spring.app.company.domain;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;


//CREATE TABLE tbl_industry (
//        industry_no NUMBER NOT NULL, /* 업종 일련번호 */
//        industry_name NVARCHAR2(50) NOT NULL, /* 업종명 */
//
//constraint PK_tbl_industry_no primary key(industry_no)
//);
//
//create sequence seq_industry_no;

@Entity
@Table(name = "tbl_industry")
@SequenceGenerator(name = "seq_industry_no", sequenceName = "seq_industry_no", allocationSize = 1)
public class IndustryVO {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_industry_no")
    private Long industryNo;

    @NotBlank
    @Column(name = "industry_name", nullable = false, length = 50)
    private String industryName;
}
