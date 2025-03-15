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

    <title>로그인 페이지</title>
    
	<script type="text/javascript" src="<%=ctx_Path%>/js/jquery-3.7.1.min.js"></script>

    <script>
        $(document).ready(function () {
            sessionStorage.setItem("contextpath", "${pageContext.request.contextPath}");
            if (${empty sessionScope.loginuser}) {
                const loginUserid = localStorage.getItem("saveid");
                if (loginUserid) {
                    $("#login_member_id").val(loginUserid);
                    $("#saveid").prop("checked", true);
                }
            }
        });
    </script>

    <script src="${pageContext.request.contextPath}/js/login/login.js"></script>
    
	<!-- TailWind Script -->
    <script src="${pageContext.request.contextPath}/js/tailwind.js"></script>
    
</head>
<body>

	<div class="flex items-center justify-center h-200 bg-gray-100">

		<div class="container flex mx-auto w-full max-w-5xl ">

			<!-- 왼쪽: 로고 및 글귀 -->
			<div class="w-1/2 flex flex-col justify-center items-start pr-8">
				<img src="${pageContext.request.contextPath}/images/logo/logo-horizontal.png" alt="로고" class="w-70 pb-4">
				<p class="text-2xl font-semibold text-gray-700">JOB Chae에서 전 세계 친구들과 함께<br>나만의 꿈을 찾아보세요.</p>
			</div>

			<!-- 오른쪽: 로그인 폼 -->
			<div class="w-1/2 flex flex-col bg-white rounded-lg p-6 shadow-md justify-center">
				<form name="memberloginFrm" action="${pageContext.request.contextPath}/member/login" method="post">
					<label class="block text-gray-600 text-sm">ID</label>
					<input class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-orange-300"
						type="text" name="member_id" id="login_member_id" placeholder="아이디" autocomplete="off" />

					<label class="block text-gray-600 text-sm mt-4">PASSWORD</label>
					<input class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-orange-300"
						type="password" name="member_passwd" id="login_member_passwd" placeholder="비밀번호" autocomplete="off" />

					<div class="flex items-center justify-between mt-4">
						<div>
							<input type="checkbox" id="saveid" class="mr-2">
							<label for="saveid" class="text-sm text-gray-600 cursor-pointer">아이디 저장하기</label>
						</div>
						<div class="text-sm text-orange-400">
							<a href="${pageContext.request.contextPath}/member/idFind" class="hover:underline">아이디 찾기</a> /
							<a href="${pageContext.request.contextPath}/member/passwdFind" class="hover:underline">비밀번호 찾기</a>
						</div>
					</div>

					<button type="button" id="btnuserSubmit"
						class="w-full mt-4 bg-orange-400 text-white py-2 rounded-lg hover:bg-orange-500 cursor-pointer duration-200"
						onclick="gomemberLogin()">LOGIN</button>

					<hr class="my-6 border-gray-300!">

					<button type="button" id="btnRegister"
						class="w-full bg-[#42b72a] text-white py-2 rounded-lg hover:bg-green-600 cursor-pointer duration-200"
						onclick="goRegister()">회원가입</button>
				</form>
			</div>
		</div>
	</div>
	
    <!-- 푸터 -->
	<jsp:include page="/WEB-INF/views/common/footerBeforeLogin.jsp" />
	
</body>
</html>