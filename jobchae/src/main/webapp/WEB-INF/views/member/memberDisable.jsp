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
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/member/memberDisable.css" />

<%-- 직접 만든 JS --%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/member/memberDisable.js"></script>





<jsp:include page="/WEB-INF/views/common/bootstrap.jsp" />






<title>회원탈퇴 페이지</title>

</head>
<body>


<div class="container mt-5" style="border: solid 0px red;">

	<div class="row">
		
		<%-- <div class="col-lg-12 col-md-12" style="margin: 3% 0 1% 0; font-size: 30pt; font-weight: bold;">
			회원 탈퇴
		</div> --%>
		<div class="w-100"></div>
		
		<div class="col-lg-12 col-md-12" style="margin: 3% 0 1% 0; font-size: 30pt; font-weight: bold; text-align: center;">
			지금까지 JobChae를 이용해주셔서 정말 감사드립니다.
		</div>
	
		<div class="w-100" style="margin-bottom: 50px"></div>
		
	</div>
	
	<div class="row" style="border: solid 1px gray; margin: 0 10px">
		<div class="col-lg-12 col-md-12">
			<p style="margin-top: 20px; font-size: 15pt; font-weight: bold;">
				회원탈퇴 전, 유의사항을 확인해 주시기 바랍니다.
			</p>
			<p>
				JobChae를 탈퇴하면 탈퇴 계정은 즉시 비활성화되며, 비활성화된 정보는 한달의 유예기간 후 자동 삭제됩니다. 
			</p>
			<p style="margin-top: 5%">
				&lt;삭제대상&gt;<br>
				작성한 개시물 전체 / 내프로필정보(프로필 사진 및 배경사진 정보 등) / 친구 및 개시물 소식 받기 정보 등
			</p>
		</div>
		<%-- 약관동의 체크박스 --%>
		<div class="col-lg-12 col-md-12 box" style="background-color: #f2f2f2">
			<input type="checkbox" id="agreeCheck" />&nbsp;&nbsp;<label for="agreeCheck">상기 JobChae 회원탈퇴 시 유의사항 안내를 확인하였음에 동의합니다.</label> 
		</div>
	</div>
			
	<div class="row" style="border: solid 1px #ccc; margin: 25px 10px;">
		<div class="col-lg-12 col-md-12" style="margin-bottom: 15px">
			보안을 위해 회원님의 이름과 계정 이메일 및 비밀번호를 확인합니다.
		</div>
	
		<%-- 데이터 전송용 form --%>
		<form name="memberDisableFrm">
	
			<div class="col-lg-12 col-md-12">
				<input type="hidden" id="member_id" name="member_id" value="${(sessionScope.loginuser).member_id}" /> <%-- 아이디 저장용 input --%>
				<label class="labelMr" for="member_name">이름 : <input type="text" name="member_name" id="member_name" readonly class="underline disabled" value="${(sessionScope.loginuser).member_name}" /></label>
				<label class="labelMr" for="member_email">이메일 : <input type="email" name="member_email" id="email" readonly class="underline disabled" value="${(sessionScope.loginuser).member_email}" /></label>
				<label class="labelMr" for="member_passwd">비밀번호 : <input type="password" name="member_passwd" id="member_passwd" class="underline" /></label>
				<input type="button" id="btnSubmit" class="btnstyle" value="본인확인" onclick="isExistMember()" />
				<span id="isExist" style="margin-left: 5px"></span>
			</div>
			
		</form>
			
	</div>
	
	<div class="row" style="margin: 0 10px 100px 10px">
		
		<div id="btnOutDisable" class="col-lg-12 col-md-12" >
			<%-- <input type="button" id="btnOut" class="btnstyle" value="취소 후 복귀" onclick="goOut()" /> --%>
			<input type="button" id="btnDisable" class="btnstyle" value="회원탈퇴 하러가기" onclick="gomemberDisable()" />
		</div>
		
	</div>
		
		
		
		
		
		
</div>
	


</body>
</html>
	
	