<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- === JSTL( Java Standard Tag Library) 사용하기 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/header/header.jsp" />

    <!-- TailWind Script -->
    <script src="${pageContext.request.contextPath}/js/tailwind.js"></script>
    <!-- Font Awesome CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <%-- TailWind 사용자 정의 CSS --%>
    <jsp:include page="/WEB-INF/views/member/profileTailwind.jsp" />

    <!-- 본문 -->
    <div class="container m-auto grid grid-cols-10 lg:grid-cols-14 gap-6 xl:max-w-[1140px] py-5">
        <!-- 좌측 네비게이션 -->
        <div class="left-side col-span-3 hidden md:block h-full relative">
            <div class="border-normal sticky">
                <h1 class="h1 p-4 text-gray-500 flex items-top"><i class="fa-solid fa-bookmark text-sm mt-2 mr-3"></i>내 항목</h1>
                <ul class="recruit-nav pb-0!">
                    <li><a href="${pageContext.request.contextPath}/recruit/main/upload">게시된 채용공고</a></li>
                    <li class="recruit-nav-selected"><a href="${pageContext.request.contextPath}/recruit/main/save">나의 채용공고</a></li>
                    <li><a href="${pageContext.request.contextPath}/recruit/add/step1">무료 채용공고 올리기</a></li>
                </ul>
            </div>
        </div>

        <!-- 중앙 본문 -->
        <div class="center col-span-10 md:col-span-7 space-y-2">
            <div class="border-rwd py-4">
                <div class="px-4 space-y-2">
                    <div class="h1">나의 채용공고</div>
                    <div>
                        <ul class="flex gap-2">
                            <li><button type="button" class="button-selected">저장함</button></li>
                            <li><button type="button" class="button-gray">진행중</button></li>
                            <li><button type="button" class="button-gray">지원함</button></li>
                            <li><button type="button" class="button-gray">따로보관함</button></li>
                        </ul>
                    </div>
                </div>

                <hr class="border-gray-300 my-4">

                <div class="text-center px-4">
                    <img src="${pageContext.request.contextPath}/images/no_recruit.svg" alt="" class="my-4 mx-auto w-50">
                    <div class="h1 mt-4">최근 구직 활동 없음</div>
                    <div>여기에서 새로운 기회를 찾고 채용공고 검색 진행 상황을 관리하세요.</div>
                    <button type="button" class="button-orange mt-4">채용공고 검색</button>
                </div>
            </div>
        </div>

        <!-- 우측 광고 -->
        <div class="right-side lg:col-span-4 h-full relative hidden lg:block">

            <div class="border-rwd p-4 mb-4">
                <a href="${pageContext.request.contextPath}/recruit/add/step1" class="w-full block text-center button-orange py-2!"><i class="fa-solid fa-pen-to-square"></i> 무료 채용공고 올리기</a>
            </div>

            <div class="border-rwd pb-4 sticky space-y-2 text-center relative">
                <div class="absolute top-5 right-5 bg-white rounded-sm text-[0.9rem]">
                    <span class="pl-1.5 font-bold">광고</span>
                    <button type="button" class="font-bold hover:bg-gray-100 cursor-pointer px-1.5 py-1 rounded-r-sm"><i class="fa-solid fa-ellipsis"></i></button>
                </div>
                <div>
                    <img src="${pageContext.request.contextPath}/images/ad2.png"/>
                </div>
                <div class="px-4">
                    <p class="font-bold">${sessionScope.loginuser.member_name}님, syoffice에서 All in One Company Service를 경험하세요.</p>
                </div>
                <div class="px-4">
					<a href="http://syoffice.kro.kr/syoffice">
                    <button type="button" class="button-orange">방문하기</button>
					</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>