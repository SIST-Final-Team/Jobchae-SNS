<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String ctx_Path = request.getContextPath();
//    
%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>비밀번호 갱신 페이지</title>

    <!-- Optional JavaScript -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>

    <%-- js 사용하기 위한 contextPath --%>
    <script type="text/javascript"> 
        sessionStorage.setItem("contextpath", "${pageContext.request.contextPath}");

        // 비밀번호 변경일자가 3개월을 넘기는 것이 아닌 접근은 차단해야한다.
        <%-- const isRequirePasswdChange = "${(sessionScope.loginuser).requirePasswdChange}";
        if (isRequirePasswdChange != "true" && isRequirePasswdChange == "") { // 넣어준 값이 true 값이 아니면 후퇴
            alert("잘못된 접근입니다!");
            location.href = "javascript:history.back()";
        } --%>

        // 비밀번호 변경일자가 3개월을 넘기는 경우,
        // 로그인하지 않고 비밀번호 찾기를 통해 변경하는 경우를 허용해야 한다. - 김규빈
        if (${(sessionScope.loginuser).requirePasswdChange == 1 || requestScope.is_passwdFind != "is_passwdFind"}) { // 넣어준 값이 true 값이 아니면 후퇴
            alert("잘못된 접근입니다!");
            location.href = "javascript:history.back()";
        }
        
    </script>

    <%-- 직접 만든 js 파일 --%>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/login/passwdUpdate.js"></script>

    <!-- TailWind Script -->
    <script src="${pageContext.request.contextPath}/js/tailwind.js"></script>

</head>
<body>


<body>

    <!-- 헤더 -->
	<jsp:include page="/WEB-INF/views/common/headerBeforeLogin.jsp" />

    <div class="flex items-center justify-center h-200 bg-gray-100 pt-24">

        <div class="mx-auto w-md bg-white rounded-lg p-6 shadow-md">

            <h4 class="text-2xl mt-0 font-semibold mb-4">비밀번호 수정</h4>

            <form name="passwdUpdateFrm">

                <!-- 아이디 -->
                <div class="w-full max-w-md mb-4">
                    <label for="member_id" class="block text-sm font-medium text-gray-700">아이디<span class="text-red-500">*</span></label>

                    <c:if test="${not empty (sessionScope.loginuser).member_id}">
                        <input type="text" name="member_id" id="member_id" maxlength="16" class="mt-1 py-2 text-gray-700 rounded-md w-full focus:outline-none" 
                            value="${(sessionScope.loginuser).member_id}" />
                    </c:if>
                    
                    <c:if test="${not empty requestScope.member_id}">
                        <input type="text" name="member_id" id="member_id" maxlength="16" class="mt-1 py-2 text-gray-700 rounded-md w-full focus:outline-none" 
                            value="${requestScope.member_id}" />
                    </c:if>
                </div>

                <!-- 새 비밀번호 -->
                <div class="w-full max-w-md mb-4">
                    <label for="new_member_passwd" class="block text-sm font-medium text-gray-700">새 비밀번호<span class="text-red-500">*</span></label>
                    <input type="password" name="new_member_passwd" id="new_member_passwd" maxlength="15" class="mt-1 p-2 border border-gray-300 rounded-md w-full" 
                        placeholder="영문자/숫자/특수기호 조합하여 8~16글자" />
                    <div id="passwderror" class="text-red-500 text-sm mt-1"></div>
                </div>

                <!-- 새 비밀번호 확인 -->
                <div class="w-full max-w-md mb-4">
                    <label for="passwdcheck" class="block text-sm font-medium text-gray-700">비밀번호 확인<span class="text-red-500">*</span></label>
                    <input type="password" name="passwdcheck" id="passwdcheck" maxlength="15" class="mt-1 p-2 border border-gray-300 rounded-md w-full" 
                        placeholder="비밀번호 확인" />
                    <div id="passwdcheckerror" class="text-red-500 text-sm mt-1"></div>
                </div>

                <!-- 이메일 -->
                <div class="w-full max-w-md mb-4">
                    <label for="member_email" class="block text-sm font-medium text-gray-700">이메일<span class="text-red-500">*</span></label>
                    <div class="relative">

                        <c:if test="${not empty (sessionScope.loginuser).member_email}">
                            <input type="email" name="member_email" id="member_email" maxlength="60" class="mt-1 py-2 rounded-md w-full focus:outline-none" value="${(sessionScope.loginuser).member_email}" placeholder="이메일" />
                        </c:if>

                        <c:if test="${not empty requestScope.member_email}">
                            <input type="email" name="member_email" id="member_email" maxlength="60" class="mt-1 py-2 rounded-md w-full focus:outline-none" value="${requestScope.member_email}" placeholder="이메일" />
                        </c:if>
                        <button type="button" id="emailSend" class="absolute right-4 top-1/2 transform -translate-y-1/2 text-sm text-orange-400 hover:underline hover:cursor-pointer">이메일 인증</button>
                    </div>
                    <div id="emailSendResult" class="text-red-500 text-sm mt-1"></div>
                </div>

                <!-- 이메일 인증 -->
                <div class="w-full max-w-md mb-4 hide_emailAuth hidden">
                    <label for="email_auth" class="block text-sm font-medium text-gray-700">인증번호<span class="text-red-500">*</span></label>
                    <div class="relative">
                        <input type="text" name="email_auth" id="email_auth" maxlength="60" class="mt-1 p-2 border border-gray-300 rounded-md w-full" placeholder="발송된 인증번호를 입력하세요." />
                        <button type="button" id="btn_email_auth" class="absolute right-4 top-1/2 transform -translate-y-1/2 text-sm text-orange-400 hover:underline hover:cursor-pointer">인증번호 확인</button>
                    </div>
                    <div id="email_authResult" class="text-red-500 text-sm mt-1"></div>
                </div>

                <!-- 숨겨진 필드 -->
                <input type="hidden" id="is_passwdFind" name="is_passwdFind" value="${requestScope.is_passwdFind}" />

                <!-- 비밀번호 변경 버튼 -->
                <div class="w-full max-w-md flex justify-between mt-6 space-x-2">
                    <button type="button" class="w-1/2 py-2 px-4 bg-gray-200 text-gray-800 font-semibold rounded-md hover:bg-gray-300 duration-200 hover:cursor-pointer" onclick="location.href='${pageContext.request.contextPath}/';">취소</button>
                    <button type="button" class="w-1/2 py-2 px-4 bg-orange-400 text-white font-semibold rounded-md hover:bg-orange-500 duration-200 hover:cursor-pointer" onclick="goPasswdUpdate()">비밀번호 변경하기</button>
                </div>

            </form>

        </div>
    </div>

    <!-- 푸터 -->
	<jsp:include page="/WEB-INF/views/common/footerBeforeLogin.jsp" />

</body>
</html>




