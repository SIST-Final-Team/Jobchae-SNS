<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- === JSTL( Java Standard Tag Library) 사용하기 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
   String ctxPath = request.getContextPath();
   //      /MyMVC
%>


<!-- Optional JavaScript -->
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.7.1.min.js"></script>

<%-- js 사용하기 위한 contextPath --%>
<script type="text/javascript"> 
	sessionStorage.setItem("contextpath", "${pageContext.request.contextPath}");
</script>


<%-- jQueryUI CSS 및 JS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script>


<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/member/register_career_student.css" />


<%-- 다음 우편번호 찾기 js 파일 --%>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/member/register_career_student.js"></script>




<jsp:include page="/WEB-INF/views/common/bootstrap.jsp" />






<title>회원가입페이지</title>

</head>
<body>

	<div class="container mt-5">
	
		<form action="">
			
			
			<%-- 회원 경력, 학력 입력 --%>
            <div class="row justify-content-center" id="career_menu" style="display: none;">
            
<!-- 			member_career_no NUMBER NOT NULL, /* 회원 경력 일련번호 */ -->
<!-- 		    fk_member_id VARCHAR2(20) NOT NULL, /* 회원 아이디 */ -->
<!-- 	    	fk_region_no NUMBER NOT NULL, /* 지역 일련번호 */ -->
<!-- 	    	fk_job_no NUMBER NOT NULL, /* 직종 일련번호 */ -->
<!-- 	    	member_career_is_current NUMBER(1) DEFAULT 0 NOT NULL, /* 현재 재직여부 */ -->
<!-- 	    	member_career_company NVARCHAR2(50) NOT NULL, /* 회사/단체 */ -->
<!-- 	    	member_career_type NUMBER(1), /* 고용형태 */ -->
<!-- 	    	member_career_startdate DATE, /* 시작일 */ -->
<!-- 	    	member_career_enddate DATE, /* 종료일 */ -->
<!-- 	    	member_career_explain NVARCHAR2(2000), /* 설명 */ -->

<!-- 			    CONSTRAINT PK_tbl_m_career_no PRIMARY KEY(member_career_no), -->
<!-- 			    CONSTRAINT FK_tbl_m_career_fk_member_id FOREIGN KEY(fk_member_id) REFERENCES tbl_member(member_id), -->
<!-- 			    CONSTRAINT FK_tbl_m_career_fk_region_no FOREIGN KEY(fk_region_no) REFERENCES tbl_region(region_no), -->
<!-- 			    CONSTRAINT FK_tbl_m_career_fk_job_no FOREIGN KEY(fk_job_no) REFERENCES tbl_job(job_no), -->
<!-- 			    CONSTRAINT CK_tbl_m_career_type CHECK(member_career_type BETWEEN 1 AND 8) -->
<!-- 			    1:정규직, 2:시간제, 3:자영업/개인사업, 4:프리랜서, 5:계약직, 6:인턴, 7:수습생, 8:시즌 -->
            
            	<h4 id="h4_2">현재 재직 정보</h4>
            	<div class="w-100"></div>
            	<div style="margin-bottom: 3%;"></div>
            	
            	<%-- 학생 여부 확인 버튼 --%>
                <div class="col-lg-3 col-md-7">
                    <input type="button" id="btn_student" class="btnstyle" value="학생이신가요?" />
                </div>
                <div class="w-100"></div>
                <div style="margin-bottom: 5%;"></div>
            
            
            	<%-- 직종 --%>
                <div class="col-lg-5 col-md-7" style="margin: 0 0 1% 0;">직종</div>
                <div class="w-100"></div>
                <div class="col-lg-5 col-md-7">  
                	<input type="text" name="career_job" id="career_job" size="40" maxlength="100" class="requiredInfo underline"
                        placeholder="직종" />
                    <input type="hidden" name="fk_job_no" id="fk_job_no" />
                </div>
                <div class="w-100"></div>
                <div class="col-lg-5 col-md-7" style="margin: 0 0 1% 0;">
                	<%-- === 검색어 입력시 자동글 완성하기 1 --%>
					<div id="displayList3" style="border:solid 1px gray; border-top:0px; height:100px; 
						margin-top:-1px; margin-bottom:5px; overflow:auto;">
  					</div>
                </div>
                <div class="w-100"></div>
                <div id="joberror" class="col-lg-5 col-md-7 error"></div>
                <div class="w-100"></div>
            
            
				<%-- 고용형태 --%>
				<!-- member_career_type NUMBER(1), 
                     1:정규직, 2:시간제, 3:자영업/개인사업, 4:프리랜서, 5:계약직, 6:인턴, 7:수습생, 8:시즌 -->
                <div class="col-lg-5 col-md-7" style="margin: 0 0 1% 0;">고용형태</div>
                <div class="w-100"></div>
                <div class="col-lg-5 col-md-7" style="margin: 0 0 1% 0;">
                	<select name="member_career_type" style="height: 26px;">
						<option value="">고용형태 선택</option>
						<option value="1">정규직</option>
						<option value="2">시간제</option>
						<option value="3">자영업/개인사업</option>
						<option value="4">프리랜서</option>
						<option value="5">계약직</option>
						<option value="6">인턴</option>
						<option value="7">수습생</option>
						<option value="8">시즌</option>
					</select> 
                </div>
                <div class="w-100"></div>
                
                
                <%-- 회사 --%>
<!-- 	    	member_career_company NVARCHAR2(50) NOT NULL, /* 회사/단체 */ -->
                <div class="col-lg-5 col-md-7" style="margin: 0 0 1% 0;">회사&nbsp;<span class="star">*</span></div>
                <div class="w-100"></div>
                <div class="col-lg-5 col-md-7">  
                	<input type="text" name="member_career_company" id="member_career_company" size="40" maxlength="50" class="requiredInfo underline"
                        placeholder="회사" />
                </div>
                <div class="w-100"></div>
                
                
                <!--  -->
                <!-- member_career_startdate DATE, /* 시작일 */ -->
                <div id="startday" class="col-lg-5 col-md-7" style="margin: 0 0 1% 0;">시작일</div>
                <div class="w-100"></div>
                <div class="col-lg-5 col-md-7" style="margin: 0 0 1% 0;">
                	<input type="hidden" name="member_career_startdate"/>
                		<div style="display: flex;">
                			<select id="member_career_year_start" class="selectWidth member_caree_year">
                                <option value="0">연도</option>
                                <option value="2025">2025</option>
                                <option value="2024">2024</option>
                                <option value="2023">2023</option>
                            </select>
                            <select id="member_career_month_start" class="selectWidth member_career_month">
                                <option value="0">월</option>
                                <option value="1">1월</option>
                                <option value="2">2월</option>
                                <option value="3">3월</option>
                                <option value="4">4월</option>
                                <option value="5">5월</option>
                                <option value="6">6월</option>
                                <option value="7">7월</option>
                                <option value="8">8월</option>
                                <option value="9">9월</option>
                                <option value="10">10월</option>
                                <option value="11">11월</option>
                                <option value="12">12월</option>
                            </select>
                        </div>
                </div>
                <div class="w-100"></div>
                
                
                <div class="col-lg-5 col-md-7" style="margin: 0 0 1% 0;">종료일</div>
                <div class="w-100"></div>
                <div class="col-lg-5 col-md-7" style="margin: 0 0 1% 0;">
                	<input type="hidden" name="member_career_enddate"/>
                		<div style="display: flex;">
                			<select id="member_caree_year_end" class="selectWidth member_caree_year" disabled>
                                <option value="0">연도</option>
                                <option value="2025">2025</option>
                                <option value="2024">2024</option>
                                <option value="2023">2023</option>
                            </select>
                            <select id="member_career_month_end" class="selectWidth member_career_month" disabled>
                                <option value="0">월</option>
                                <option value="1">1월</option>
                                <option value="2">2월</option>
                                <option value="3">3월</option>
                                <option value="4">4월</option>
                                <option value="5">5월</option>
                                <option value="6">6월</option>
                                <option value="7">7월</option>
                                <option value="8">8월</option>
                                <option value="9">9월</option>
                                <option value="10">10월</option>
                                <option value="11">11월</option>
                                <option value="12">12월</option>
                            </select>
                        </div>
                </div>
                <div class="w-100"></div>
                
                
            	<%-- 근무지 지역 --%>
                <div class="col-lg-5 col-md-7" style="margin: 0 0 1% 0;">근무지 지역</div>
                <div class="w-100"></div>
                <div class="col-lg-5 col-md-7">  
                	<input type="text" name="career_region" id="career_region" size="40" maxlength="200" class="requiredInfo career_job_line"
                        placeholder="근무지 지역" />
                    <input type="hidden" name="career_fk_region_no" id="career_fk_region_no" />
                    <%-- 백엔드에서 fk_region_no 로 제대로 넣어주자 --%>
                </div>
                <div class="w-100"></div>
                <div class="col-lg-5 col-md-7" style="margin: 0 0 1% 0;">
                	<%-- === 검색어 입력시 자동글 완성하기 1 --%>
					<div id="displayList2" style="border:solid 1px gray; border-top:0px; height:100px; 
						margin-top:-1px; margin-bottom:5px; overflow:auto;">
  					</div>
                </div>
                <div class="w-100"></div>
                <div id="career_regionerror" class="col-lg-5 col-md-7 error"></div>
                <div class="w-100"></div>
                
               
                
                <div style="margin: 0 0 3% 0;"></div>
                
                
                
                


<!-- 	    	member_career_explain NVARCHAR2(2000), /* 설명 */ -->
                <div class="col-lg-5 col-md-7" style="margin: 0 0 1% 0;">설명</div>
                <div class="w-100"></div>
                <div class="col-lg-5 col-md-7" style="margin: 0 0 1% 0;">
                
                	<textarea class="textarea"></textarea>
                	
                </div>
                
              	<div class="w-100"></div>
                

                <div style="margin: 5% 0 5% 0;"></div>

                <%-- 경력, 학력 입력 창 열기 버튼 --%>
                <div class="col-lg-5 col-md-7">
                    <input type="button" id="btn_before1" class="btnstyle" value="이전" />
                </div>
                <div class="w-100"></div>
                <div style="margin-bottom: 10%;"></div>  
                
                
                
                
            
   			</div>
            <%-- 회원 경력 끝 --%>
            
            
            
            
            <%-- 회원 학력 입력 --%>
            <div class="row justify-content-center" id="student_menu" style="display: none;">
            
<!-- 				/* 회원 학력 */
				CREATE TABLE tbl_member_education (
    			member_education_no NUMBER NOT NULL, /* 회원 학력 일련번호 */
    			fk_member_id VARCHAR2(20) NOT NULL, /* 회원 아이디 */
    			fk_school_no NUMBER NOT NULL, /* 학교 일련번호 */
    			fk_major_no NUMBER NOT NULL, /* 전공 일련번호 */
    			member_education_is_current NUMBER(1) DEFAULT 0 NOT NULL, /* 현재 재학여부 */
    			member_education_degree NUMBER, /* 학위 */
    			member_education_startdate DATE, /* 입학일 */
    			member_education_endate DATE, /* 졸업일 */
    			member_education_grade NUMBER(3,2), /* 학점 */
    			member_education_explain NVARCHAR2(2000), /* 설명 */
    
    			constraint PK_tbl_m_edu_no primary key(member_education_no),
    			constraint FK_tbl_m_edu_fk_member_id foreign key(fk_member_id) references tbl_member(member_id),
    			constraint FK_tbl_m_edu_fk_school_no foreign key(fk_school_no) references tbl_school(school_no),
    			constraint FK_tbl_m_edu_fk_major_no foreign key(fk_major_no) references tbl_major(major_no),
    			constraint CK_tbl_m_edu_degree CHECK (member_education_degree IN (1, 2, 3, 4, 5, 6)), /* 중졸:1, 고졸:2, 초대졸:3, 학사:4, 석사:5, 박사:6 */
    			constraint CK_tbl_m_edu_grade CHECK (member_education_grade >= 2.0 AND member_education_grade <= 4.5) /* 학점은 2.0 ~ 4.5 */
); -->
				
				
            
            	<h4 id="h4_3">현재 재학 정보</h4>
            	<div class="w-100"></div>
            	<div style="margin-bottom: 3%;"></div>
            	
            	<%-- 학생 여부 확인 버튼 --%>
                <div class="col-lg-3 col-md-7">
                    <input type="button" id="btn_career" class="btnstyle" value="직장인이신가요?" />
                </div>
                <div class="w-100"></div>
                <div style="margin-bottom: 5%;"></div>
            
            	<%-- 여기부터 변수 바꿔야함 --%>
            	<%-- 직종 --%>
                <div class="col-lg-5 col-md-7" style="margin: 0 0 1% 0;">직종</div>
                <div class="w-100"></div>
                <div class="col-lg-5 col-md-7">  
                	<input type="text" name="career_job" id="career_job" size="40" maxlength="100" class="requiredInfo underline"
                        placeholder="직종" />
                    <input type="hidden" name="fk_job_no" id="fk_job_no" />
                </div>
                <div class="w-100"></div>
                <div class="col-lg-5 col-md-7" style="margin: 0 0 1% 0;">
                	<%-- === 검색어 입력시 자동글 완성하기 1 --%>
					<div id="displayList3" style="border:solid 1px gray; border-top:0px; height:100px; 
						margin-top:-1px; margin-bottom:5px; overflow:auto;">
  					</div>
                </div>
                <div class="w-100"></div>
                <div id="joberror" class="col-lg-5 col-md-7 error"></div>
                <div class="w-100"></div>
            
            
				<%-- 고용형태 --%>
				<!-- member_career_type NUMBER(1), 
                     1:정규직, 2:시간제, 3:자영업/개인사업, 4:프리랜서, 5:계약직, 6:인턴, 7:수습생, 8:시즌 -->
                <div class="col-lg-5 col-md-7" style="margin: 0 0 1% 0;">고용형태</div>
                <div class="w-100"></div>
                <div class="col-lg-5 col-md-7" style="margin: 0 0 1% 0;">
                	<select name="member_career_type" style="height: 26px;">
						<option value="">고용형태 선택</option>
						<option value="1">정규직</option>
						<option value="2">시간제</option>
						<option value="3">자영업/개인사업</option>
						<option value="4">프리랜서</option>
						<option value="5">계약직</option>
						<option value="6">인턴</option>
						<option value="7">수습생</option>
						<option value="8">시즌</option>
					</select> 
                </div>
                <div class="w-100"></div>
                
                
                <%-- 회사 --%>
<!-- 	    	member_career_company NVARCHAR2(50) NOT NULL, /* 회사/단체 */ -->
                <div class="col-lg-5 col-md-7" style="margin: 0 0 1% 0;">회사&nbsp;<span class="star">*</span></div>
                <div class="w-100"></div>
                <div class="col-lg-5 col-md-7">  
                	<input type="text" name="member_career_company" id="member_career_company" size="40" maxlength="50" class="requiredInfo underline"
                        placeholder="회사" />
                </div>
                <div class="w-100"></div>
                
                
                <!--  -->
                <!-- member_career_startdate DATE, /* 시작일 */ -->
                <div id="startday" class="col-lg-5 col-md-7" style="margin: 0 0 1% 0;">시작일</div>
                <div class="w-100"></div>
                <div class="col-lg-5 col-md-7" style="margin: 0 0 1% 0;">
                	<input type="hidden" name="member_career_startdate"/>
                		<div style="display: flex;">
                			<select id="member_career_year_start" class="selectWidth member_caree_year">
                                <option value="0">연도</option>
                                <option value="2025">2025</option>
                                <option value="2024">2024</option>
                                <option value="2023">2023</option>
                            </select>
                            <select id="member_career_month_start" class="selectWidth member_career_month">
                                <option value="0">월</option>
                                <option value="1">1월</option>
                                <option value="2">2월</option>
                                <option value="3">3월</option>
                                <option value="4">4월</option>
                                <option value="5">5월</option>
                                <option value="6">6월</option>
                                <option value="7">7월</option>
                                <option value="8">8월</option>
                                <option value="9">9월</option>
                                <option value="10">10월</option>
                                <option value="11">11월</option>
                                <option value="12">12월</option>
                            </select>
                        </div>
                </div>
                <div class="w-100"></div>
                
                
                <div class="col-lg-5 col-md-7" style="margin: 0 0 1% 0;">종료일</div>
                <div class="w-100"></div>
                <div class="col-lg-5 col-md-7" style="margin: 0 0 1% 0;">
                	<input type="hidden" name="member_career_enddate"/>
                		<div style="display: flex;">
                			<select id="member_caree_year_end" class="selectWidth member_caree_year" disabled>
                                <option value="0">연도</option>
                                <option value="2025">2025</option>
                                <option value="2024">2024</option>
                                <option value="2023">2023</option>
                            </select>
                            <select id="member_career_month_end" class="selectWidth member_career_month" disabled>
                                <option value="0">월</option>
                                <option value="1">1월</option>
                                <option value="2">2월</option>
                                <option value="3">3월</option>
                                <option value="4">4월</option>
                                <option value="5">5월</option>
                                <option value="6">6월</option>
                                <option value="7">7월</option>
                                <option value="8">8월</option>
                                <option value="9">9월</option>
                                <option value="10">10월</option>
                                <option value="11">11월</option>
                                <option value="12">12월</option>
                            </select>
                        </div>
                </div>
                <div class="w-100"></div>
                
                
            	<%-- 근무지 지역 --%>
                <div class="col-lg-5 col-md-7" style="margin: 0 0 1% 0;">근무지 지역</div>
                <div class="w-100"></div>
                <div class="col-lg-5 col-md-7">  
                	<input type="text" name="career_region" id="career_region" size="40" maxlength="200" class="requiredInfo career_job_line"
                        placeholder="근무지 지역" />
                    <input type="hidden" name="career_fk_region_no" id="career_fk_region_no" />
                    <%-- 백엔드에서 fk_region_no 로 제대로 넣어주자 --%>
                </div>
                <div class="w-100"></div>
                <div class="col-lg-5 col-md-7" style="margin: 0 0 1% 0;">
                	<%-- === 검색어 입력시 자동글 완성하기 1 --%>
					<div id="displayList2" style="border:solid 1px gray; border-top:0px; height:100px; 
						margin-top:-1px; margin-bottom:5px; overflow:auto;">
  					</div>
                </div>
                <div class="w-100"></div>
                <div id="career_regionerror" class="col-lg-5 col-md-7 error"></div>
                <div class="w-100"></div>
                
               
                
                <div style="margin: 0 0 3% 0;"></div>
                
                
                
                


<!-- 	    	member_career_explain NVARCHAR2(2000), /* 설명 */ -->
                <div class="col-lg-5 col-md-7" style="margin: 0 0 1% 0;">설명</div>
                <div class="w-100"></div>
                <div class="col-lg-5 col-md-7" style="margin: 0 0 1% 0;">
                
                	<textarea class="textarea"></textarea>
                	
                </div>
                
              	<div class="w-100"></div>
                

                <div style="margin: 5% 0 5% 0;"></div>

                <%-- 경력, 학력 입력 창 열기 버튼 --%>
                <div class="col-lg-5 col-md-7">
                    <input type="button" id="btn_before1" class="btnstyle" value="이전" />
                </div>
                <div class="w-100"></div>
                <div style="margin-bottom: 10%;"></div>  
                
                
                
                
            
   			</div>
   			<%-- 회원 학력 끝 --%>
		
		</form>
	
	</div>



</body>
</html>