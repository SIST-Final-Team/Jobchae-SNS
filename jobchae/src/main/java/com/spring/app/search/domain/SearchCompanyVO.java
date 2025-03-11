package com.spring.app.search.domain;

public class SearchCompanyVO {

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

    private String company_no;            /* 기업 페이지 일련번호 */
    private String fk_member_id;          /* 회원 아이디 */
    private String fk_industry_no;        /* 업종 일련번호 */
    private String fk_region_no;          /* 지역 일련번호 */
    private String company_name;          /* 기업명 */
    private String company_website;       /* 기업웹사이트 */
    private String company_size;          /* 단체 규모 */
    private String company_type;          /* 단체 종류 */
    private String company_logo;          /* 로고 이미지 */
    private String company_explain;       /* 슬로건(설명) */
    private String company_register_date; /* 등록일자 */
    private String company_status;        /* 등록 상태 1:등록됨, 2:삭제됨*/

    private String industry_name;         /* 업종명 */
    private String region_name;           /* 지역명 */

	public String getCompany_no() {
		return company_no;
	}

	public void setCompany_no(String company_no) {
		this.company_no = company_no;
	}

	public String getFk_member_id() {
		return fk_member_id;
	}

	public void setFk_member_id(String fk_member_id) {
		this.fk_member_id = fk_member_id;
	}

	public String getFk_industry_no() {
		return fk_industry_no;
	}

	public void setFk_industry_no(String fk_industry_no) {
		this.fk_industry_no = fk_industry_no;
	}

	public String getFk_region_no() {
		return fk_region_no;
	}

	public void setFk_region_no(String fk_region_no) {
		this.fk_region_no = fk_region_no;
	}

	public String getCompany_name() {
		return company_name;
	}

	public void setCompany_name(String company_name) {
		this.company_name = company_name;
	}

	public String getCompany_website() {
		return company_website;
	}

	public void setCompany_website(String company_website) {
		this.company_website = company_website;
	}

	public String getCompany_size() {
		return company_size;
	}

	public void setCompany_size(String company_size) {
		this.company_size = company_size;
	}

	public String getCompany_type() {
		return company_type;
	}

	public void setCompany_type(String company_type) {
		this.company_type = company_type;
	}

	public String getCompany_logo() {
		return company_logo;
	}

	public void setCompany_logo(String company_logo) {
		this.company_logo = company_logo;
	}

	public String getCompany_explain() {
		return company_explain;
	}

	public void setCompany_explain(String company_explain) {
		this.company_explain = company_explain;
	}

	public String getCompany_register_date() {
		return company_register_date;
	}

	public void setCompany_register_date(String company_register_date) {
		this.company_register_date = company_register_date;
	}

	public String getCompany_status() {
		return company_status;
	}

	public void setCompany_status(String company_status) {
		this.company_status = company_status;
	}

	public String getIndustry_name() {
		return industry_name;
	}

	public void setIndustry_name(String industry_name) {
		this.industry_name = industry_name;
	}

	public String getRegion_name() {
		return region_name;
	}

	public void setRegion_name(String region_name) {
		this.region_name = region_name;
	}
    

}
