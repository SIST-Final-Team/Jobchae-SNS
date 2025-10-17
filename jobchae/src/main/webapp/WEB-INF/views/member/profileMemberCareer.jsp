<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${not empty (sessionScope.loginuser).member_id}">
    <jsp:include page="/WEB-INF/views/header/header.jsp" />
</c:if>

<c:if test="${empty (sessionScope.loginuser).member_id}">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/tailwind.css" />
            <%-- Optional JavaScript --%>
        <script
                type="text/javascript"
                src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"
        ></script>
        <script
                type="text/javascript"
                src="${pageContext.request.contextPath}/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js"
        ></script>

        <script type="text/javascript">
            const ctxPath = "${pageContext.request.contextPath}";
        </script>

        <script
                type="text/javascript"
                src="${pageContext.request.contextPath}/js/main-header/header.js"
        ></script>

        <!-- TailWind Script -->
        <script src="${pageContext.request.contextPath}/js/tailwind.js"></script>

        <!-- Font Awesome CSS -->
        <link
                rel="stylesheet"
                href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
        />

            <%-- 웹소켓 연결 관리 모듈 JS --%>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/chat/chat.js"></script>

            <%-- 검색 --%>

        <script type="text/javascript">
            let ctxPathForSearch = "${pageContext.request.contextPath}";
        </script>
        <script
                type="text/javascript"
                src="${pageContext.request.contextPath}/js/main-header/search.js"
        ></script>
    </head>
    <body>
    <jsp:include page="/WEB-INF/views/common/headerBeforeLogin.jsp" />
    <div class="pt-15"></div>
</c:if>
<%-- TailWind 사용자 정의 CSS --%>
<jsp:include page="/WEB-INF/views/member/profileTailwind.jsp" />

<script type="text/javascript">
    const memberId = '${requestScope.memberId}'; // 조회 대상 회원 아이디
    const reload = false; // 등록, 수정, 삭제 후 페이지 새로고침 여부
    const isMyProfile = ${not empty sessionScope.loginuser && sessionScope.loginuser.member_id == requestScope.memberId}; // 본인의 프로필인지 여부
</script>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/member/profileMore.js"></script>

<script type="text/javascript">
    // 한 회원의 경력 목록 조회
    getMemberCareerListByMemberId(memberId);
</script>

    <!-- 경력 Modal -->
    <jsp:include page="/WEB-INF/views/member/modal/modalMemberCareer.jsp" />

    <!-- 본문 -->
    <div class="container m-auto mt-5 grid grid-cols-10 lg:grid-cols-14 gap-6 xl:max-w-[1140px]">

        <!-- 중앙 본문 -->
        <div class="center col-span-14 md:col-span-10 space-y-2">
            <div class="scroll-mt-22 border-board">

                <!-- 경력 -->
                <div>
                    <div class="flex items-center">
                        <button type="button" class="back btn-transparent"><i
                                class="fa-solid fa-arrow-left-long"></i></button>
                        <h1 class="h1 flex-1">경력</h1>
                        <%-- 로그인 본인 체크 --%>
                        <c:if test="${not empty sessionScope.loginuser && sessionScope.loginuser.member_id == requestScope.memberId}">
                            <button type="button" data-target-modal="MemberCareer"
                                class="btn-transparent btn-open-modal"><i class="fa-solid fa-plus"></i></button>
                        </c:if>
                    </div>

                    <ul id="memberCareerList" class="space-y-2">
                        <%-- 경력 목록 --%>
                    </ul>
                </div>
            </div>
        </div>

        <!-- 우측 광고 -->
        <div class="right-side lg:col-span-4 h-full relative hidden lg:block">
            <div class="border-list sticky top-20 space-y-2 text-center relative">
                <div class="absolute top-5 right-5 bg-white rounded-sm text-[0.9rem]">
                    <span class="pl-1.5 font-bold">광고</span>
                    <button type="button"
                        class="font-bold hover:bg-gray-100 cursor-pointer px-1.5 py-1 rounded-r-sm"><i
                            class="fa-solid fa-ellipsis"></i></button>
                </div>
                <div>
                    <img src="${pageContext.request.contextPath}/images/ad.png"/>
                </div>
                <div class="px-4">
                    <p class="font-bold">${sessionScope.loginuser.member_name}님, ANTICO에서 경매에 참여해보세요.</p>
                    <p>ANTICO에서 나에게 맞는 물건을 살펴보세요.</p>
                </div>
                <div class="px-4">
					<a href="http://antico.shop/antico/index">
                    <button type="button" class="button-orange">방문하기</button>
					</a>
                </div>
            </div>
        </div>
    </div>
</body>

</html>