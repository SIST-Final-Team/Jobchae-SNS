<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String ctx_Path = request.getContextPath();
//    
%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!-- Optional JavaScript -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>

<%-- js 사용하기 위한 contextPath --%>
<script type="text/javascript"> 
	sessionStorage.setItem("contextpath", "${pageContext.request.contextPath}");

	// 비밀번호 변경일자가 3개월을 넘기는 것이 아닌 접근은 차단해야한다.
	const isRequirePasswdChange = "${(sessionScope.loginuser).requirePasswdChange}";
	if (isRequirePasswdChange != "true" && isRequirePasswdChange == "") { // 넣어준 값이 true 값이 아니면 후퇴
		alert("잘못된 접근입니다!");
		location.href = "javascript:history.back()";
	}
	
</script>

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login/passwdUpdate.css" />


<%-- 직접 만든 js 파일 --%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/login/passwdUpdate.js"></script>



<jsp:include page="/WEB-INF/views/common/bootstrap.jsp" />



<title>비밀번호 갱신 페이지</title>

</head>
<body>


<div class="container mt-5">

        <h4>비밀번호 수정</h4>

        <form name="passwdUpdateFrm">

            <div class="row justify-content-center">

                <%--  아이디 표시 --%>
                <div class="col-lg-5 col-md-7" style="margin: 3% 0 1% 0;">아이디&nbsp;<span class="star">*</span></div>
                <div class="w-100"></div>
                
                <%-- 로그인 중 3개월 지난 회원이면 비밀번호 변경이 이렇게 된다. --%>
                <c:if test="${not empty (sessionScope.loginuser).member_id}">
                	<div class="col-lg-5 col-md-7" style="position: relative; margin: 0px;">
                    	<input type="text" name="member_id" id="member_id" maxlength="16" class="requiredInfo underline input_background disabled" value="${(sessionScope.loginuser).member_id}" />  
                	</div>
                </c:if>
                
                <%-- 비밀번호 찾기 중 변경 순서에서 이렇게 된다. --%>
                <c:if test="${not empty requestScope.member_id}">
                	<div class="col-lg-5 col-md-7" style="position: relative; margin: 0px;">
                    	<input type="text" name="member_id" id="member_id" maxlength="16" class="requiredInfo underline input_background disabled" value="${requestScope.member_id}" />  
                	</div>
                </c:if>
                <div class="w-100"></div>
                
                <%-- 새 비밀번호 --%>
                <div class="col-lg-5 col-md-7" style="margin: 3% 0 1% 0;">비밀번호&nbsp;<span class="star">*</span></div>
                <div class="w-100"></div>
                <div class="col-lg-5 col-md-7">
                    <input type="password" name="new_member_passwd" id="new_member_passwd" maxlength="15" class="requiredInfo underline"
                        placeholder="영문자/숫자/특수기호 조합하여 8~16글자" />
                </div>
                <div class="w-100"></div>
                <div id="passwderror" class="col-lg-5 col-md-7 error"></div>
                <div class="w-100"></div>

                <%-- 새 비밀번호 확인 --%>
                <div class="col-lg-5 col-md-7" style="margin: 3% 0 1% 0;">비밀번호 확인&nbsp;<span class="star">*</span></div>
                <div class="w-100"></div>
                <div class="col-lg-5 col-md-7">
                    <input type="password" name="passwdcheck" id="passwdcheck" maxlength="15" class="requiredInfo underline" 
                        placeholder="비밀번호 확인" />
                </div>
                <div class="w-100"></div>
                <div id="passwdcheckerror" class="col-lg-5 col-md-7 error"></div>
                <div class="w-100"></div>


                <%-- 이메일로 인증 --%>
                <div class="col-lg-5 col-md-7" style="margin: 3% 0 1% 0;">이메일&nbsp;<span class="star">*</span></div>
                <div class="w-100"></div>
                
                <%-- 로그인 중 3개월 지난 회원이면 비밀번호 변경이 이렇게 된다. --%>
                <c:if test="${not empty (sessionScope.loginuser).member_email}">
                	<div class="col-lg-5 col-md-7" style="position: relative; margin: 0px;">
                    	<input type="email" name="member_email" id="member_email" maxlength="60" class="requiredInfo underline disabled" value="${(sessionScope.loginuser).member_email}" />
                    	<%-- 이메일 발송 --%>
                    	<button type="button" id="emailSend" class="checkbutton"
                        	style="position: absolute; right: 15px; display: inline-block;">이메일 인증</button>
                	</div>
                </c:if>
                
                <%-- 비밀번호 찾기 중 변경 순서에서 이렇게 된다. --%>
                <c:if test="${not empty requestScope.member_email}">
                	<div class="col-lg-5 col-md-7" style="position: relative; margin: 0px;">
                    	<input type="email" name="member_email" id="member_email" maxlength="60" class="requiredInfo underline disabled" value="${requestScope.member_email}" />
                    	<%-- 이메일 발송 --%>
                    	<button type="button" id="emailSend" class="checkbutton"
                        	style="position: absolute; right: 15px; display: inline-block;">이메일 인증</button>
                	</div>
                </c:if>
                <div class="w-100"></div>
                <div id="emailSendResult" class="error col-lg-5 col-md-7 hide_Result"></div>
                <div class="w-100"></div>

                <%--  이메일 인증 넣는 칸 --%>
                <div class="col-lg-5 col-md-7 hide_emailAuth" style="margin: 3% 0 1% 0;">인증번호&nbsp;<span class="star">*</span></div>
                <div class="w-100 hide_emailAuth"></div>
                <div class="col-lg-5 col-md-7 hide_emailAuth" style="position: relative; margin: 0px;">
                    <input type="text" name="email_auth" id="email_auth" maxlength="60" class="requiredInfo underline hide_emailAuth"
                        placeholder="발송된 인증번호를 입력하세요." />
                    <%-- 인증번호 체크버튼 --%>
                    <button type="button" id="btn_email_auth" class="checkbutton hide_emailAuth"
                        style="position: absolute; right: 15px; display: inline-block;">인증번호 확인</button>
                </div>
                <div class="w-100 hide_emailAuth"></div>
                <div id="email_authResult" class="error col-lg-5 col-md-7 hide_emailAuth"></div> <%--  인증번호 일치한지 아닌지 보여주는 칸 --%> 
                <div class="w-100 hide_emailAuth"></div>

                <div style="margin-bottom: 7%;"></div>


				<%-- 비밀번호 찾기에서 왔는지 구분해주는 값 --%>
                <input type="hidden" id="is_passwdFind" name="is_passwdFind" value="${requestScope.is_passwdFind}" />
				

                <%--  비밀번호 변경하기 버튼 --%>
                <div class="col-lg-5 col-md-7">
                    <input type="button" class="btnstyle" value="비밀번호 변경하기" onclick="goPasswdUpdate()" />
                </div>
                <div class="w-100"></div>
                <div style="margin-bottom: 10%;"></div>
                

            </div>

        </form>

    </div>




</body>
</html>




