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


<jsp:include page="/WEB-INF/views/common/bootstrap.jsp" />






<title>회원탈퇴 최종페이지</title>

</head>
<body>
    
<div class="container mt-5 justify-content-center" style="border: solid 0px red; height: 100vh">    
    
    	<div class="row" style="text-align: center;">
    		<div class="col-lg-12 col-md-12" style="margin-top: 1%; text-align:center; font-size:50pt";>
    			지금까지 JobChae를 이용해주셔서 정말 감사합니다. 더욱 발전된 모습으로 성장하도록 하겠습니다. 
    		</div>
    		<div class="w-100"></div>
    		<div class="col-lg-12 col-md-12" style="text-align:center; font-size:30pt;">
    			만약 탈퇴 철회를 원하신다면 JobChae 관리자에게 문의해주시기 바랍니다.
    		</div>
    	</div>
    	
</div>   



</body>
</html>
    
    
    
    
    
    
    
    
    