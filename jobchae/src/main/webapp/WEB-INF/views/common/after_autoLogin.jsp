<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>




<%-- ${pageContext.request.contextPath} --%>

<html>
<head>
<meta charset="UTF-8">
<title>오토로그인</title>


<script type="text/javascript">
	window.onload = function () {
		
		const s_alert_choice = "${requestScope.alert_choice}"; 
		
		const alert_choice = Number(s_alert_choice);
		
		// 회원가입 자동로그인 시 
		if (alert_choice == 0) {
			alert("회원가입이 완료됐습니다.");
		} 
		
		// 휴면 복구 자동로그인 시
		if (alert_choice == 1) {
			alert("휴면 복구가 완료됐습니다.");
		}
		
		const frm = document.loginFrm;
		
		frm.action = "${pageContext.request.contextPath}/member/login";
		frm.method = "post";
		frm.submit();
		
		
	}//end of window.onload...

</script>

</head>
<body>
	<form name="loginFrm">
		<input type="hidden" name="member_id" value="${requestScope.member_id}" />
		<input type="hidden" name="member_passwd" value="${requestScope.member_passwd}" />
		<input type="hidden" name="alert_choice" value="${requestScope.alert_choice}" />
	</form>


</body>
</html>












