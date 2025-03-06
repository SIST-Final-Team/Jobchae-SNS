<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String ctx_Path = request.getContextPath();
//    /MyMVC
%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>



<!-- Optional JavaScript -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>

<%-- js 사용하기 위한 contextPath --%>
<script type="text/javascript"> 
	sessionStorage.setItem("contextpath", "${pageContext.request.contextPath}");
</script>

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login/idFind.css" />


<%-- 직접 만든 js 파일 --%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/login/idFind.js"></script>




<jsp:include page="/WEB-INF/views/common/bootstrap.jsp" />






<title>아이디찾기 페이지</title>

</head>
<body>



<div class="container mt-5" style="border: solid 0px red;">

        <h4>아이디 찾기</h4>


        <form name="idFindFrm" action="${pageContext.request.contextPath}/member/idFind" method="post">

            <div class="row justify-content-center">

                <%-- 성명 --%>
                <div class="col-lg-5 col-md-7" style="margin: 3% 0 1% 0;">성명&nbsp;<span class="star">*</span></div>
                <div class="w-100"></div>
                <div class="col-lg-5 col-md-7">
                    <input type="text" name="member_name" id="member_name" maxlength="15" class="requiredInfo underline"
                        placeholder="성명" />
                </div>
                <div class="w-100"></div>
                <div id="nameerror" class="col-lg-5 col-md-7 error"></div>
                <div class="w-100"></div>


                <%-- 이메일로 인증 --%>
                <div class="col-lg-5 col-md-7" style="margin: 3% 0 1% 0;">이메일&nbsp;<span class="star">*</span></div>
                <div class="w-100"></div>
                <div class="col-lg-5 col-md-7" style="position: relative; margin: 0px;">
                    <input type="email" name="member_email" id="member_email" maxlength="60" class="requiredInfo underline"
                        placeholder="이메일" />
                    <%-- 이메일 발송 --%>
                    <button type="button" id="emailSend" class="checkbutton"
                        style="position: absolute; right: 15px; display: inline-block;">이메일 인증</button>
                </div>
                <div class="w-100"></div>
                <div id="emailSendResult" class="error col-lg-5 col-md-7 hide_Result"></div>
                <div id="emailerror" class="error col-lg-5 col-md-7"></div>
                <div class="w-100"></div>

                <%-- 이메일 인증 넣는 칸 --%>
                <div class="col-lg-5 col-md-7 hide_emailAuth" style="margin: 3% 0 1% 0;">인증번호&nbsp;<span
                        class="star">*</span></div>
                <div class="w-100 hide_emailAuth"></div>
                <div class="col-lg-5 col-md-7 hide_emailAuth" style="position: relative; margin: 0px;">
                    <input type="text" name="email_auth" id="email_auth" maxlength="60"
                        class="requiredInfo underline hide_emailAuth" placeholder="발송된 인증번호를 입력하세요." />
                    <%-- 인증번호 체크버튼 --%>
                    <button type="button" id="btn_email_auth" class="checkbutton hide_emailAuth"
                        style="position: absolute; right: 15px; display: inline-block;">인증번호 확인</button>
                </div>
                <div class="w-100 hide_emailAuth"></div>
                <div id="email_authResult" class="error col-lg-5 col-md-7 hide_emailAuth"></div>
                <%-- 인증번호 일치한지 아닌지 보여주는 칸 --%>
                <div class="w-100 hide_emailAuth"></div>

                <div style="margin-bottom: 7%;"></div>


                <%--  아이디 찾기 버튼 --%>
                <div class="col-lg-5 col-md-7">
                    <input type="button" class="btnstyle" value="아이디 찾기" onclick="goidFind()" />
                </div>
                <div class="w-100"></div>
                <div style="margin-bottom: 10%;"></div>


            </div>

        </form>

    </div>



</body>
</html>





