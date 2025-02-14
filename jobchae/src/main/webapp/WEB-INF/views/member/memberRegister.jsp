<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- === JSTL( Java Standard Tag Library) 사용하기 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
   String ctxPath = request.getContextPath();
   //      /MyMVC
%>

<%--  
.jsp 파일에서 사용되어지는 것들 
console.log('${pageContext.request.contextPath}');  // 컨텍스트패스   /MyMVC
console.log('${pageContext.request.requestURL}');   // 전체 URL     http://localhost:9090/MyMVC/WEB-INF/member/admin/memberList.jsp
console.log('${pageContext.request.scheme}');       // http        http
console.log('${pageContext.request.serverName}');   // localhost   localhost
console.log('${pageContext.request.serverPort}');   // 포트번호      9090
console.log('${pageContext.request.requestURI}');   // 요청 URI     /MyMVC/WEB-INF/member/admin/memberList.jsp 
console.log('${pageContext.request.servletPath}');  // 파일명       /WEB-INF/member/admin/memberList.jsp 
--%>


<!-- Optional JavaScript -->
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.7.1.min.js"></script>

<%-- js 사용하기 위한 contextPath --%>
<script type="text/javascript"> 
	sessionStorage.setItem("contextpath", "${pageContext.request.contextPath}");
</script>


<%-- jQueryUI CSS 및 JS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script>


<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/member/memberRegister.css" />


<%-- 다음 우편번호 찾기 js 파일 --%>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/member/memberRegister.js"></script>




<jsp:include page="/WEB-INF/views/common/bootstrap.jsp" />






<title>회원가입페이지</title>

</head>
<body>



<div class="container mt-5">

        <h4>회원가입</h4>

        <form name="registerFrm">

            <div class="row justify-content-center">

                <div class="col-lg-5 col-md-7" style="margin: 3% 0 1% 0;">아이디&nbsp;<span class="star">*</span></div>
                <div class="w-100"></div>
                <div class="col-lg-5 col-md-7" style="position: relative; margin: 0px;">
                    <input type="text" name="member_id" id="member_id" maxlength="16" class="requiredInfo underline"
                        placeholder="영문소문자/숫자 4~16 자" />
                    <%-- 아이디중복체크 --%>
                    <button type="button" id="idcheck" class="checkbutton"
                        style="position: absolute; right: 15px; display: inline-block;">아이디 중복검사</button>
                </div>
                <div class="w-100"></div>
                <div id="idcheckResult" class="error col-lg-5 col-md-7 hide_Result"></div>
                <div class="w-100"></div> <%-- 이거 한줄씩 추가하자 --%>
                <div id="member_id_error" class="error col-lg-5 col-md-7"></div>
                <div class="w-100"></div>

                <%-- 비밀번호 --%>
                <div class="col-lg-5 col-md-7" style="margin: 3% 0 1% 0;">비밀번호&nbsp;<span class="star">*</span></div>
                <div class="w-100"></div>
                <div class="col-lg-5 col-md-7">
                    <input type="password" name="member_passwd" id="member_passwd" maxlength="15" class="requiredInfo underline"
                        placeholder="영문자/숫자/특수기호 조합하여 8~16글자" />
                </div>
                <div class="w-100"></div>
                <div id="member_passwd_error" class="col-lg-5 col-md-7 error"></div>
                <div class="w-100"></div>
                <%-- 비밀번호 확인 --%>
                <div class="col-lg-5 col-md-7" style="margin: 3% 0 1% 0;">비밀번호 확인&nbsp;<span class="star">*</span></div>
                <div class="w-100"></div>
                <div class="col-lg-5 col-md-7">
                    <input type="password" name="passwdcheck" id="passwdcheck" maxlength="15"
                        class="requiredInfo underline" placeholder="비밀번호 확인" />
                </div>
                <div class="w-100"></div>
                <div id="passwdcheckerror" class="col-lg-5 col-md-7 error"></div>
                <div class="w-100"></div>

                <%-- 이름 --%>
                <div class="col-lg-5 col-md-7" style="margin: 3% 0 1% 0;">이름&nbsp;<span class="star">*</span></div>
                <div class="w-100"></div>
                <div class="col-lg-5 col-md-7">
                    <input type="text" name="member_name" id="member_name" maxlength="20" class="requiredInfo underline"
                        placeholder="이름을 입력하세요." />
                </div>
                <div class="w-100"></div>
                <div id="member_name_error" class="col-lg-5 col-md-7 error"></div>
                <div class="w-100"></div>

                <%-- 생년월일 --%>
                <div class="col-lg-5 col-md-7" style="margin: 3% 0 1% 0;">생년월일&nbsp;<span class="star">*</span></div>
                <div class="w-100"></div>
                <div class="col-lg-5 col-md-7">
                    <input type="text" name="member_birth" id="datepicker" maxlength="10" class="underline" />
                </div>
                <div class="w-100"></div>
                <div id="birtherror" class="col-lg-5 col-md-7 error"></div>
                <div class="w-100"></div>

                <%-- 이메일 --%>
                <div class="col-lg-5 col-md-7" style="margin: 3% 0 1% 0;">이메일&nbsp;<span class="star">*</span></div>
                <div class="w-100"></div>
                <div class="col-lg-5 col-md-7" style="position: relative; margin: 0px;">
                    <input type="email" name="member_email" id="member_email" maxlength="60" class="requiredInfo underline"
                        placeholder="이메일을 입력하세요." />
                    <%-- 이메일 중복체크 및 이메일 인증번호 발송 버튼 --%>
                    <button type="button" id="emailcheck" class="checkbutton"
                        style="position: absolute; right: 15px; display: inline-block;">인증번호 발송</button>
                </div>
                <div class="w-100"></div>
                <div id="emailCheckResult" class="error col-lg-5 col-md-7 hide_Result"></div>
                <div class="w-100"></div>
                <div id="member_email_error" class="error col-lg-5 col-md-7"></div>
                <div class="w-100"></div>
            
                <%-- 이메일 인증 넣는 칸 --%>
                <div class="col-lg-5 col-md-7 hide_emailAuth" style="margin: 3% 0 1% 0;">인증번호&nbsp;<span class="star">*</span></div>
                <div class="w-100 hide_emailAuth"></div>
                <div class="col-lg-5 col-md-7 hide_emailAuth" style="position: relative; margin: 0px;">
                    <input type="text" name="email_auth" id="email_auth" maxlength="60" class="requiredInfo underline hide_emailAuth"
                        placeholder="발송된 인증번호를 입력하세요." />
                    <%-- 인증번호 체크버튼 --%>
                    <button type="button" id="btn_email_auth" class="checkbutton hide_emailAuth"
                        style="position: absolute; right: 15px; display: inline-block;">인증번호 확인</button>
                </div>
                <div class="w-100 hide_emailAuth"></div>
                <div id="email_authResult" class="error col-lg-5 col-md-7 hide_emailAuth"></div> <%-- 인증번호 일치한지 아닌지 보여주는 칸 --%> 
                <div class="w-100 hide_emailAuth"></div>

                <%-- 연락처 (전화번호 다채우면 다음 칸으로 focus 되도록 설정하자!) --%>
                <div class="col-lg-5 col-md-7" style="margin: 3% 0 1% 0;">연락처&nbsp;<span class="star">*</span></div>
                <div class="w-100"></div>
                <div class="col-lg-5 col-md-7">
                    <input type="text" id="hp1" size="6" maxlength="3" value="010" readonly
                        class="telunderline" />&nbsp;-&nbsp;
                    <input type="text" id="hp2" size="6" maxlength="4" class="telunderline requiredInfo" />&nbsp;-&nbsp;
                    <input type="text" id="hp3" size="6" maxlength="4" class="telunderline requiredInfo" />
                	
                	<input type="hidden" name="member_tel" id="member_tel" size="6" maxlength="11" class="requiredInfo" />
                </div>
                <div class="w-100"></div>
                <div id="telerror" class="col-lg-5 col-md-7 error"></div>
                <div class="w-100" style="margin-bottom: 3%"></div>

                <%-- 우편번호 input 없애자, 우리가 설정한 데이터베이스에서만 검색되도록 설정하자 --%>
                <%-- 지역 --%>
                <div class="col-lg-5 col-md-7" style="margin: 0 0 1% 0;">지역&nbsp;<span class="star">*</span></div>
                <div class="w-100"></div>
                <div class="col-lg-5 col-md-7">
                    <input type="text" name="member_region" id="member_region" size="40" maxlength="200" placeholder="지역"
                        class="underline requiredInfo" /><br>
                </div>
                <div class="w-100"></div>
                <div id="regionerror" class="col-lg-5 col-md-7 error"></div>
                <div class="w-100"></div>


                <div style="margin: 1% 0 5% 0;"></div>

                <div class="w-100"></div>
                
                <%-- 약관동의 체크박스 --%>
                <div class="col-lg-5 col-md-7">
                    <!-- Button trigger modal -->
<!-- 				<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal_scrolling_2"> -->
<!-- 		  			이용약관 -->
<!-- 				</button> -->
				<label for="agree_checkbox">이용약관&nbsp;<span class="star">*</span>&nbsp;&nbsp;
					<input type="checkbox" id="agree_checkbox" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal_scrolling_2" />
				</label>
				
				<!-- Modal -->
				<!-- Modal 구성 요소는 현재 페이지 상단에 표시되는 대화 상자/팝업 창입니다. -->
				<div class="modal fade" id="exampleModal_scrolling_2">
		  			<div class="modal-dialog modal-dialog-scrollable modal-lg">
		  			<!-- .modal-dialog-scrollable을 .modal-dialog에 추가하여 페이지 자체가 아닌 모달 내부에서만 스크롤할 수 있습니다. -->
		    			<div class="modal-content">
		      
		      				<!-- Modal header -->
		      				<div class="modal-header">
		        				<h5 class="modal-title">Modal title</h5>
		        				<button type="button" class="close" data-dismiss="modal">&times;</button>
		      				</div>
		      
		      				<!-- Modal body -->
		      				<div class="modal-body">
		        				<h3>제 1 조 (목적)</h3>
                				<p>
                					이 약관은 쌍용강북교육센터(이하 "회사")가 제공하는 "자바프로그래밍과정" 관련 제반 서비스의 이용과 관련해 회사와 회원가족과의 권리, 의무 및 책임사항, 기타 필요한 사항을 규정함을 목적으로 합니다.
                				</p>
                				
                				<h3>제 2 조 (정의)</h3>
                				<p>이 약관에서 사용하는 용어의 정의는 다음과 같습니다.</p>
                				<p>1. "서비스"라 함은 "회원가족"이 이용할 수 있는 "오라클기반 자바프로그래밍" 및 관련 제반 서비스를 의미합니다.</p>
                				<p>2. "회원가족"이라 함은 회사의 "서비스"에 접속해 이 약관에 따라 "회사"가 제공하는 "서비스"를 이용하는 고객을 말합니다.</p>
                				<p>3. "아이디(ID)"라 함은 "회원가족"의 식별과 "서비스" 이용을 위해 "회원가족"이 정하고 "회사"가 승인하는 문자와 숫자의 조합을 의미합니다.</p>
                				<p>4. "비밀번호"라 함은 "회원가족"이 부여 받은 "아이디"와 일치하는 "회원가족"임을 확인하기 위해 회원가족 본인이 선정해 등록한 문자와 숫자의 조합을 의미합니다.</p>
                				<p>5. "게시물"이라 함은 "회원가족"이 "서비스"를 이용하면서 게시한 부호ㆍ문자ㆍ음성ㆍ음향ㆍ화상ㆍ동영상 등의 정보 형태의 글, 사진, 동영상 및 각종 파일과 링크 등을 의미합니다.</p>
                				
                				<h3>제 3 조 (약관의 게시와 개정)</h3>
                				<p>1. "회사"는 이 약관의 내용을 "회원가족"이 쉽게 알 수 있도록 서비스 초기 화면에 게시합니다.</p>
                				<p>2. "회사"는 합리적인 사유가 있는 경우 이 약관을 개정할 수 있습니다. 이 경우 서비스 초기 화면에 적용일자 7일 전부터 적용일자 전일까지 그 내용을 공지합니다.</p>
                				<p>3. "회원가족"이 개정약관의 내용에 동의하지 않는 경우 이용계약을 해지할 수 있습니다. 해지의사를 표하지 아니하고 약관의 효력발생일로부터 15일이 경과될 경우 동의한 것으로 간주됩니다.</p>
                				
                				<h3>제 4 조 (이용계약 체결)</h3>
                				<p>1. 이용계약은 "회원가족"이 되고자 하는 자(이하 "가입신청자")가 약관의 내용에 대하여 동의한후 회원가입신청을 하고 "회사"가 이러한 신청에 대하여 승낙함으로써 체결됩니다.</p>
                				<p>2. "회사"는 "가입신청자"의 신청에 대하여 "서비스" 이용을 원칙적으로 승낙합니다. 다만, "회사"는 다음 각 호에 해당하는 신청에 대하여는 승낙을 하지 않거나 사후에 이용계약을 해지할 수 있습니다.</p>
                				<ul>
                					<li>가입신청자가 이 약관에 의하여 이전에 회원자격을 상실한 적이 있는 경우</li>
                					<li>실명이 아니거나 타인의 명의를 이용한 경우</li>
                					<li>허위의 정보를 기재한 경우</li>
                					<li>불법부정한 용도나 "회사"의 허락을 받지 않은 영업 홍보행위에 이용할 목적으로 서비스를 신청한 경우</li>
                					<li>서비스 관련 설비의 여유가 없거나 기술상 또는 업무상 문제가 있는 경우</li>
                					<li>이용자의 귀책사유로 인해 승인이 불가능하거나 법령 및 기타 규정한 제반 사항을 위반하며 신청하는 경우</li>
                				</ul>
                				<p>3. "회사"는 "회원가족"에 대해 회사정책에 따라 등급별로 구분해 이용시간, 이용횟수, 서비스 메뉴 등을 세분하여 이용에 차등을 둘 수 있습니다.</p>
                				
                				<h3>제 5 조 (개인정보보호 의무)</h3>
                				<p>
                					"회사"는 "정보통신망법" 등 관계 법령이 정하는 바에 따라 "회원가족"의 개인정보를 보호하기 위해 노력합니다. 개인정보의 보호 및 사용에 대해서는 관련법 및 "회사"의 개인정보취급방침이 적용됩니다. 다만, "회사"의 공식 사이트 이외의 링크된 사이트에서는 "회사"의 개인정보취급방침이 적용되지 않습니다.
                				</p>
                				
                				<h3>제 6 조 ("회원가족"의 "아이디" 및 "비밀번호"의 관리에 대한 의무)</h3>
                				<p>1. "회원가족"의 "아이디"와 "비밀번호"에 관한 관리책임은 "회원가족"에게 있으며, 이를 제3자가 이용하도록 하여서는 안 됩니다.</p>
                				<p>2. "회사"는 "회원가족"의 "아이디"가 개인정보 유출 우려가 있거나, 반사회적 또는 미풍양속에 어긋나거나 "회사" 및 "회사"의 운영자로 오인할 우려가 있는 경우, 2개 이상의 "아이디"를 사용하고 있는 경우, 해당 "아이디"의 이용을 제한할 수 있습니다.</p>
                				<p>3. "회원가족"은 "아이디" 및 "비밀번호"가 도용되거나 제3자가 사용하고 있음을 인지한 경우에는 이를 즉시 "회사"에 통지하고 "회사"의 안내에 따라야 합니다.</p>

								<h3>제 7 조 ("회원가족"에 대한 통지)</h3>
                				<p>1. "회사"는 "회원가족"에게 통지를 하는 경우 서비스 내 전자쪽지 등으로 할 수 있습니다.</p>
                				<p>2. "회사"는 "회원가족" 전체에 대한 통지의 경우 7일 이상 "회사"의 게시판에 게시함으로써 제1항의 통지에 갈음할 수 있습니다.</p>
                				
                				<h3>제 8 조 ("회사"의 의무)</h3>
                				<p>1. "회사"는 계속적이고 안정적으로 "서비스"를 제공하기 위하여 최선을 다하여 노력합니다. 서비스의 장애가 발생한 경우 빠른 시일내에 복구하도록 최선을 다합니다.</p>
                				<p>2. "회사"는 "회원가족"의 개인정보 보호를 위해 보안시스템을 구축하며, 개인정보취급방침을 공시하고 준수합니다.</p>
                				<p>3. "회사"는 서비스이용과 관련하여 "회원가족"이 제기한 의견이나 불만이 정당하다고 인정될 경우 이를 성실히 처리하여야 합니다.</p>
                				
                				<h3>제 9 조 ("회원가족"의 의무)</h3>
								<p>"회원가족"은 다음 행위를 하여서는 안 됩니다. 아래의 의무를 위반한 경우 사이트 사용의 제한이나 회원자격 박탈조치가 취해질 수 있습니다.</p>
								<p>1. 저작권 등 지적재산권에 대한 침해</p>
								<p>2. 회원신청 또는 변경 시 허위 또는 과장된 내용의 등록</p>
								<p>3. 타인의 정보도용</p>
								<p>4. "회사" 및 기타 제3자의 명예를 손상시키거나 업무를 방해하는 행위</p>
								<p>5. 외설 또는 폭력적인 내용의 정보를 "서비스"에 공개 또는 게시하는 행위</p>
								<p>6. 회사의 동의 없이 영리나 홍보를 목적으로 "서비스"를 사용하는 행위</p>
								<p>7. "서비스" 이용권의 양도, 판매, 담보제공 등의 처분행위</p>
								<p>8. 기타 불법적이거나 부당한 행위</p>
								
								<h3>제 10 조 ("서비스"의 제공 등)</h3>
								<p>1. 회사는 "회원가족"에게 아래와 같은 서비스를 제공합니다.</p>
								<ul>
									<li>노트(블로그) 서비스</li>
									<li>모임(카페) 서비스</li>
									<li>기타 "회사"가 추가 개발하거나 다른 회사와의 제휴계약 등을 통해 제공하는 서비스</li>
								</ul>
								<p>2."회사"는 "회원가족"이 "서비스" 이용 중 필요하다고 인정되는 다양한 정보를 공지사항이나 전자우편 등의 방법으로 "회원가족"들에게 제공할 수 있으며, "회원가족"은 언제든지 전자우편 등에 대해서 수신 거절을 할 수 있습니다.</p>
								<p>3. "서비스"는 연중무휴, 1일 24시간 제공함을 원칙으로 합니다. 다만 설비의 보수점검 등 운영상 상당한 이유가 있는 경우 서비스의 제공을 일시적으로 중단할 수 있습니다.</p>
								<p>4. "회사"는 상당한 이유가 있는 경우 운영상, 기술상의 필요에 따라 제공하고 있는 전부 또는 일부 "서비스"를 사전에 공지하고 변경할 수 있습니다. 무료로 제공되는 서비스의 일부 또는 전부를 회사의 정책 및 운영의 필요상 수정, 중단, 변경한 경우 관련법에 특별한 규정이 없는 한 별도의 보상을 하지 않습니다.</p>
								
								<h3>제 11 조 ("게시물"등의 저작권 및 관리)</h3>
								<p>1. "회원가족"이 "서비스" 내에 게시한 "게시물", 등에 대한 권리와 책임은 "회원가족"에게 있습니다. 따라서 저작권은 해당 "게시물"의 저작자에게 귀속되며, "게시물"로 인해 발생하는 저작권법위반,명예훼손 등 법적 책임도 "회원가족"에게 있습니다. 게시물이 저작권 등 법률을 위반하거나 영리,홍보를 위한 것으로 판단될 경우 삭제될 수 있습니다.</p>
								<p>2. "회원가족"의 "게시물"이 "정보통신망법" 및 "저작권법"등 관련법에 위반되는 내용을 포함하는 경우, 권리자는 관련법이 정한 절차에 따라 해당 "게시물"의 게시중단 및 삭제 등을 이메일 등으로 요청(econote@plutomedia.co.kr)할 수 있으며, "회사"는 관련법에 따라 조치를 취하여야 합니다. 권리자의 요청이 없는 경우라도 "회사"는 관련법에 따라 해당 "게시물"에 대해 삭제 등의 조치를 취할 수 있습니다.</p>
								
								<h3>제12조 (모임)</h3>
								<p>1. "회원가족"은 회원간 커뮤니티를 만들 수 있는 모임(카페) 기능을 이용할 수 있습니다. 모임의 운영자는 모임 개설 등 모임관리를 할 수 있으며, 회사가 허가한 경우를 제외하고는 "회원가족" 간 교류를 위한 비영리 목적으로만 모임을 운영할 수 있습니다.</p>
								<p>2. 모임 "회원가족"들이 회원가입시 허위 사실을 기재한 경우, 모임이 지적재산권이나 초상권 등 현행 법령이나 미풍양속을 침해하거나 침해할 목적으로 운영되는 경우, 모임이 영리나 홍보목적으로 운영되는 경우, "회사"는 모임의 이용을 제한하거나 폐쇄할 수 있습니다.</p>
								<p>3. "회사"는 모임 운영자가 "회원가족"자격을 상실했거나 모임"회원가족"들로부터 불신을 받는 등 모임이 정상운영되지 못하는 경우 운영자 교체를 다른 "회원가족"들에게 요청할 수 있습니다. 이 경우 15일 이내에 운영자가 새로 선임되지 않으면 해당 모임을 제한 또는 폐쇄할 수 있습니다.</p>
								<p>4. 3개월 이상 모임의 활동이 없거나, 운영자가 연락이 닿지 않는 경우 "회사"는 해당 모임을 제한 또는 폐쇄할 수 있습니다.</p>
								
								<h3>제 13 조 (계약해제, 해지 등)</h3>
								<p>1. "회원가족"은 언제든지 이용계약 해지 신청을 할 수 있으며, "회사"는 관련법 등이 정하는 바에 따라 이를 즉시 처리하여야 합니다.</p>
								<p>2. "회원가족"이 이용계약을 해지하면 "가입정보", "게시물" 등은 자동으로 모두 삭제됩니다. 단, "게시물" 중 덧글과 다른 "회원가족"에 의해 스크랩 등으로 재게시되었거나 모임 등 공용 게시판에 등록된 "게시물"은 그러하지 않으니 사전에 삭제후 탈퇴하시기 바랍니다.</p>
								
								<h3>제 14 조 (책임제한)</h3>
								<p>1. "회사"는 천재지변 또는 이에 준하는 불가항력으로 인해 "서비스"를 제공할 수 없는 경우에는 "서비스" 제공에 관한 책임이 면제됩니다.</p>
								<p>2. "회사"는 "회원가족"의 귀책사유로 인한 "서비스" 이용의 장애에 대해서는 책임을 지지 않습니다.</p>
								<p>3. "회사"는 "회원가족"이 게재한 정보, 자료, 사실의 신뢰도, 정확성 등의 내용에 관하여는 책임을 지지 않습니다.</p>
								<p>4. "회사"는 "회원가족" 간 또는 "회원가족"과 제3자 상호간에 "서비스"를 매개로 거래 등을 한 경우 책임이 면제됩니다.</p>
								<p>5. 제11조1항에 의한 게시물 삭제나 제12조 2~4항에 의한 모임 제한이나 폐쇄의 경우 "회사"는 "게시물" 등에 대한 손해배상의 책임을 지지 않습니다.</p>
								<p>6. "회사"는 무료로 제공되는 서비스 이용과 관련해 관련법에 특별한 규정이 없는 한 책임을 지지 않습니다.</p>
									
								<h3>제 15 조 (준거법 및 재판관할)</h3>
								<p>1. "회사"와 "회원가족" 간 제기된 소송은 대한민국법을 준거법으로 합니다.</p>
								<p>2. "회사"와 "회원가족"간 발생한 분쟁에 관한 소송은 민사소송법 상의 관할법원에 제소합니다.</p>
								
								<h3>부칙</h3>
								<p>1. 이 약관은 2024년 1월 1부터 적용됩니다.</p>
                        	</div>
		      
		      				<!-- Modal footer -->
		      				<div class="modal-footer">
		        				<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
		        				<button type="button" id="btn_agree" class="btn btn-primary" data-dismiss="modal">약관 동의</button>
		      				</div>
		    			</div>
		  			</div>
				</div>
                </div>
                
                
                
                <div class="w-100"></div>
                

                <div style="margin: 5% 0 5% 0;"></div>

                <%-- 가입, 취소 버튼 --%>
                <div class="col-lg-5 col-md-7">
                    <input type="button" class="btnstyle" value="가입하기" onclick="goRegister()" />
                </div>
                <div class="w-100"></div>
                <div style="margin-bottom: 10%;"></div>

            </div>

        </form>

</div>

</body>
</html>


