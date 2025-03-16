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
</script>

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login/idFind.css" />


<%-- 직접 만든 js 파일 --%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/login/passwdFind.js"></script>




<jsp:include page="/WEB-INF/views/common/bootstrap.jsp" />






<title>비밀번호 찾기 페이지</title>

</head>
<body>


<div class="container mt-5" style="border: solid 0px red;">

        <h4>비밀번호 찾기</h4>


        <form name="passwdFindFrm" action="${pageContext.request.contextPath}/member/passwdFind" method="post">

            <div class="row justify-content-center">

                <%-- 아이디 --%>
                <div class="col-lg-5 col-md-7" style="margin: 3% 0 1% 0;">아이디&nbsp;<span class="star">*</span></div>
                <div class="w-100"></div>
                <div class="col-lg-5 col-md-7" style="position: relative; margin: 0px;">
                    <input type="text" name="member_id" id="member_id" maxlength="16" class="requiredInfo underline"
                        placeholder="영문소문자/숫자 4~16 자" />
                </div>
                <div class="w-100"></div>
                <div id="iderror" class="error col-lg-5 col-md-7"></div>
                <div class="w-100"></div>
                

                <%-- 이메일로 인증하기 위해 넘겨주는 역할 --%>
                <div class="col-lg-5 col-md-7" style="margin: 3% 0 1% 0;">이메일&nbsp;<span class="star">*</span></div>
                <div class="w-100"></div>
                <div class="col-lg-5 col-md-7" style="position: relative; margin: 0px;">
                    <input type="email" name="member_email" id="member_email" maxlength="60" class="requiredInfo underline"
                        placeholder="이메일" />
                </div>
                <div class="w-100"></div>
                <div id="emailerror" class="error col-lg-5 col-md-7"></div>
                <div class="w-100"></div>

                <div style="margin-bottom: 7%;"></div> 
                
                <%-- 비밀번호 찾기에서 왔는지 구분해주는 값, 전달을 받아야 존재한다. --%>
                <input type="hidden" id="is_passwdFind" name="is_passwdFind" value="is_passwdFind" />


                <%--  비밀번호 찾기 버튼 --%>
                <div class="col-lg-5 col-md-7">
                    <input type="button" class="btnstyle" value="비밀번호 찾기" onclick="gopasswdFind()" />
                </div>
                <div class="w-100"></div>
                <div style="margin-bottom: 10%;"></div>


            </div>

        </form>

</div>



</body>
</html>




