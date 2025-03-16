<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String ctx_Path = request.getContextPath();
%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>아이디 찾기 결과</title>

    <!-- Optional JavaScript -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>

    <!-- TailWind Script -->
    <script src="${pageContext.request.contextPath}/js/tailwind.js"></script>

    <script type="text/javascript">

        // 로그인 페이지로
        function goLoginPage() {

            // alert("로그인 페이지로 이동합니다."); // 메세지 출력해주기
            location.href = "${pageContext.request.contextPath}/member/login"; // 페이지 이동

        }//end of function goLoginPage() {}...

        // 비밀번호 찾기 페이지로
        function gopasswdFindPage() {
            // alert("비밀번호 페이지로 이동합니다.");
            location.href = "${pageContext.request.contextPath}/member/passwdFind"; // 페이지 이동

        }//end of function goLoginPage() {}...
    </script>

</head>
<body>

    <!-- 헤더 -->
	<jsp:include page="/WEB-INF/views/common/headerBeforeLogin.jsp" />

    <div class="flex items-center justify-center h-200 bg-gray-100">

        <div class="mx-auto w-md bg-white rounded-lg p-6 shadow-md">

            <h4 class="text-2xl mt-0 font-semibold mb-4">아이디 찾기</h4>

            <div class="text-center text-lg mb-6">
                <span>${requestScope.member_name}님의 아이디는 <strong>${requestScope.member_id}</strong> 입니다.</span>
            </div>

            <!-- 바로 로그인, 비밀번호 찾기 버튼 -->
            <div class="w-full max-w-md">
                <div class="text-center mb-8">
                    <span class="text-md text-gray-700">바로 로그인 하시겠습니까?</span>
                </div>
                <div class="flex justify-between space-x-2">
                    <button type="button" class="w-1/2 py-2 px-4 bg-gray-200 text-gray-800 font-semibold rounded-md hover:bg-gray-300 duration-200 hover:cursor-pointer" onclick="goLoginPage()">로그인</button>
                    <button type="button" class="w-1/2 py-2 px-4 bg-orange-400 text-white font-semibold rounded-md hover:bg-orange-500 duration-200 hover:cursor-pointer" onclick="gopasswdFindPage()">비밀번호 찾기</button>
                </div>
            </div>

        </div>
    </div>

    <!-- 푸터 -->
	<jsp:include page="/WEB-INF/views/common/footerBeforeLogin.jsp" />

</body>
</html>