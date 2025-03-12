package com.spring.app.company.domain;

import com.spring.app.member.domain.MemberVO;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import org.hibernate.validator.constraints.Range;

import java.util.Date;

@Entity
@SequenceGenerator(name= "seq_company_no" , sequenceName = "seq_company_no", allocationSize = 1)
@Table(name = "tbl_company")
public class CompanyVO {

//    company_no NUMBER NOT NULL, /* 기업 페이지 일련번호 */
//    fk_member_id VARCHAR2(20) NOT NULL, /* 회원 아이디 */
//    fk_industry_no NUMBER NOT NULL, /* 업종 일련번호 */
//    company_name NVARCHAR2(50) NOT NULL, /* 기업명 */
//    company_website VARCHAR2(2083), /* 기업웹사이트 */
//    company_size NUMBER(1) NOT NULL, /* 단체 규모 */
//    company_type NUMBER(1) NOT NULL, /* 단체 종류 */
//    company_logo NVARCHAR2(200), /* 로고 이미지 */
//    company_explain NVARCHAR2(2000), /* 슬로건(설명) */
//    company_register_date DATE DEFAULT SYSDATE NOT NULL, /* 등록일자 */
//
//    CONSTRAINT PK_tbl_company_no PRIMARY KEY(company_no),
//    CONSTRAINT FK_tbl_company_fk_member_id FOREIGN KEY(fk_member_id) REFERENCES tbl_member(member_id),
//    CONSTRAINT FK_tbl_company_fk_industry_no FOREIGN KEY(fk_industry_no) REFERENCES tbl_industry(industry_no),
//    CONSTRAINT CK_tbl_company_size CHECK(company_size BETWEEN 1 AND 9),

//
//    CONSTRAINT CK_tbl_company_type CHECK(company_type BETWEEN 1 AND 7)
//   -- 1:상장기업, 2:프리랜서/자영업, 3:정부기관, 4:비영리, 5:개인사업, 6:비상장기업, 7:동업

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_company_no")
    Long companyNo;

    @NotNull
    @Transient
    private MemberVO member;

    @NotBlank
    @Column(name = "fk_member_id", unique = true, nullable = false)
    private String fkMemberId;
    @NotNull
    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name="fk_industry_no")
    private IndustryVO industry;

    @NotBlank
    @Column(name = "company_name", nullable = false, length = 50)
    String companyName;

    @Column(name = "company_website", length = 2083)
    String companyWebsite;

    @NotNull
    @Column(name = "company_size", nullable = false)
    int companySize;

    @NotNull
    @Column(name = "company_type", nullable = false)
    int companyType;

    @Column(name = "company_logo", length = 200)
    String companyLogo;

    @Column(name = "company_explain", length = 2000)
    String companyExplain;

    @NotNull
    @Column(name = "company_register_date", nullable = false)
    Date companyRegisterDate = new Date();

    @NotNull
    @Range(min =1, max = 2)
    @Column(name = "company_status", nullable = false, length = 1)
    int companyStatus = 1;

    public CompanyVO(){};

    public Long getCompanyNo() {
        return companyNo;
    }

    public void setCompanyNo(Long companyNo) {
        this.companyNo = companyNo;
    }

    public MemberVO getMember() {
        return member;
    }

    public void setMember(MemberVO member) {
        this.member = member;
    }

    public IndustryVO getIndustry() {
        return industry;
    }

    public void setIndustry(IndustryVO industry) {
        this.industry = industry;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getCompanyWebsite() {
        return companyWebsite;
    }

    public void setCompanyWebsite(String companyWebsite) {
        this.companyWebsite = companyWebsite;
    }

    public int getCompanySize() {
        return companySize;
    }

    public void setCompanySize(int companySize) {
        this.companySize = companySize;
    }

    public int getCompanyType() {
        return companyType;
    }

    public void setCompanyType(int companyType) {
        this.companyType = companyType;
    }

    public String getCompanyLogo() {
        return companyLogo;
    }

    public void setCompanyLogo(String companyLogo) {
        this.companyLogo = companyLogo;
    }

    public String getCompanyExplain() {
        return companyExplain;
    }

    public int getCompanyStatus() {
        return companyStatus;
    }

    public void setCompanyStatus(int companyStatus) {
        this.companyStatus = companyStatus;
    }

    public void setCompanyExplain(String companyExplain) {
        this.companyExplain = companyExplain;
    }

    public Date getCompanyRegisterDate() {
        return companyRegisterDate;
    }

    public void setCompanyRegisterDate(Date companyRegisterDate) {
        this.companyRegisterDate = companyRegisterDate;
    }

    public String getFkMemberId() {
        return fkMemberId;
    }

    public void setFkMemberId(String fkMemberId) {
        this.fkMemberId = fkMemberId;
    }
}
