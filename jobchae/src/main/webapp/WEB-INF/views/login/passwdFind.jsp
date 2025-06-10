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
    <title>비밀번호 찾기 페이지</title>

    <!-- Optional JavaScript -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>

    <%-- js 사용하기 위한 contextPath --%>
    <script type="text/javascript"> 
        sessionStorage.setItem("contextpath", "${pageContext.request.contextPath}");
    </script>

    <%-- 직접 만든 js 파일 --%>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/login/passwdFind.js"></script>

    <!-- TailWind Script -->
    <script src="${pageContext.request.contextPath}/js/tailwind.js"></script>

</head>
<body>

    <!-- 헤더 -->
	<jsp:include page="/WEB-INF/views/common/headerBeforeLogin.jsp" />

	<div class="flex items-center justify-center h-200 bg-gray-100">
        <div class="mx-auto w-md bg-white rounded-lg p-6 shadow-md">

            <h4 class="text-2xl mt-0 font-semibold mb-4">비밀번호 찾기</h4>

            <form name="passwdFindFrm" action="${pageContext.request.contextPath}/member/passwdFind" method="post">
                <div class="flex flex-col items-center">

                    <!-- 아이디 -->
                    <div class="w-full max-w-md mb-4">
                        <label for="member_id" class="block text-sm font-medium text-gray-700">아이디<span class="text-red-500">*</span></label>
                        <input type="text" name="member_id" id="member_id" maxlength="16" class="mt-1 p-2 border border-gray-300 rounded-md w-full" placeholder="영문소문자/숫자 4~16 자" />
                        <div id="iderror" class="text-red-500 text-sm mt-1"></div>
                    </div>

                    <!-- 이메일 -->
                    <div class="w-full max-w-md mb-4">
                        <label for="member_email" class="block text-sm font-medium text-gray-700">이메일<span class="text-red-500">*</span></label>
                        <input type="email" name="member_email" id="member_email" maxlength="60" class="mt-1 p-2 border border-gray-300 rounded-md w-full" placeholder="이메일" />
                        <div id="emailerror" class="text-red-500 text-sm mt-1"></div>
                    </div>

                    <!-- 숨겨진 필드 -->
<%--                    <c:if var="">--%>
<%--                        --%>
<%--                    </c:if>--%>
                    <input type="hidden" id="is_passwdFind" name="is_passwdFind" value="is_passwdFind" />

                    <!-- 비밀번호 찾기 버튼 -->
                    <div class="w-full max-w-md flex justify-between mt-6 space-x-2">
                        <button type="button" class="w-1/2 py-2 px-4 bg-gray-200 text-gray-800 font-semibold rounded-md hover:bg-gray-300 duration-200 hover:cursor-pointer" onclick="location.href=${pageContext.request.contextPath}/;">취소</button>
                        <button type="button" class="w-1/2 py-2 px-4 bg-orange-400 text-white font-semibold rounded-md hover:bg-orange-500 duration-200 hover:cursor-pointer" onclick="gopasswdFind()">비밀번호 찾기</button>
                    </div>

                </div>
            </form>

        </div>
	</div>
    
    <!-- 푸터 -->
	<jsp:include page="/WEB-INF/views/common/footerBeforeLogin.jsp" />

</body>
</html>