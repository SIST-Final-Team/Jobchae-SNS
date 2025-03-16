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


<%-- <jsp:include page="/WEB-INF/views/header/header.jsp" /> --%>
<jsp:include page="/WEB-INF/views/common/bootstrap.jsp" />


<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login/login.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/login/login.js"></script>

<script type="text/javascript">

$(document).ready(function () {
	sessionStorage.setItem("contextpath", "${pageContext.request.contextPath}");
	
	//로그인을 하지 않은 상태일 때 로컬스토리지에 저장된 key 값 saveid 인 userid 를
	// input 태그 userid 에 넣어주기
	if (${empty sessionScope.loginuser}) {
		
		const loginUserid = localStorage.getItem("saveid");
		
		if (loginUserid != null) {
			$("input#loginUserid").val(loginUserid);
			$("input:checkbox[id='saveid']").prop("checked", true);
		}
		
	}    
	
});//end of ready

</script>



<title>로그인 페이지</title>

</head>
<body>


<div class="container pt-5" style="border: solid 0px red; height: calc(100vh - 123px)">

        <h4>로그인</h4>

		<%-- 회원 로그인 --%>
		<form name="memberloginFrm" action="${pageContext.request.contextPath}/member/login" method="post">
			<div class="row justify-content-center">
        	
        		<div class="col-lg-5 col-md-7 col_mt" style="margin-bottom: -1%; font-size:14px; color: #999;">ID</div>
        		<div class="w-100"></div>
        		<div class="col-lg-5 col-md-7 col_mt">
        			<input class="underline" type="text" name="member_id" id="login_member_id" size="20" autocomplete="off"
        				placeholder="아이디" />
        		</div>
        		<div class="w-100"></div>
        		<div class="col-lg-5 col-md-7 col_mt" style="margin-bottom: -1%; font-size:14px; color: #999;">PASSWORD</div>
        		<div class="w-100"></div>
        		<div class="col-lg-5 col-md-7 col_mt">
        			<input class="underline" type="password" name="member_passwd" id="login_member_passwd" size="20"
        				autocomplete="off" placeholder="비밀번호" />
        		</div>
        		<div class="w-100"></div>
        	
        		<div class="col-lg-5 col-md-7 col_mt" style="display: flex; width: 100%;">
        			<div>
        				<input type="checkbox" id="saveid" /><label style="margin-left: 5px; cursor: pointer;"
        						for="saveid">아이디 저장하기</label>
                    </div>
                    <div style=" display: inline-block; margin-left: auto;">
                    	<a style="cursor: pointer; text-align: right; display: inline-block; color: black;"
                    		href="${pageContext.request.contextPath}/member/idFind">아이디찾기
                    	</a>
                    		/
                    	<a style="cursor: pointer; text-align: right; display: inline-block; color: black;"
                    		href="${pageContext.request.contextPath}/member/passwdFind">비밀번호찾기
                    	</a>
                    </div>
                </div>
                <div class="w-100"></div>
                <div class="col-lg-5 col-md-7 col_mt">
                    <button type="button" id="btnuserSubmit" class="btnstyle" onclick="gomemberLogin()">LOGIN</button>
                </div>
                <div class="w-100"></div>
                <!-- <div class="col-lg-5 col-md-7 col_mt">혹시 회원이 아니신가요?</div> -->
                <div class="w-100"></div>
                <div class="col-lg-5 col-md-7 col_mt">
                    <button type="button" id="btnRegister" class="btnstyle" style="border:none; background-color: #000; color: #fff;" 
                    	onclick="goRegister()">회원가입
                    </button>
                </div>
           </div>
      </form>  
</div>





</body>
</html>







