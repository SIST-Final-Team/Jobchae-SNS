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

<script type="text/javascript">
let start = 1;
let len = 16;
let hasMore = true; // 글 목록이 더 존재하는지 확인하는 변수
let requestLock = false;
let recruit_closed = 0;

$(document).ready(function() {

    getRecruitList(recruit_closed);

    // 채용공고 진행중/마감됨 클릭
    $(".recruit-progress").on("click", function() {

        $(".recruit-progress").removeClass("button-selected").addClass("button-gray");
        $(this).removeClass("button-gray").addClass("button-selected");

        recruit_closed = $(this).data("recruit-closed");

        start = 1; // 시작 번호를 1로 초기화
        $("#recruitList").html(``); // 내용 삭제

        getRecruitList(recruit_closed);
        
    });

    $(window).scroll(function() {
        // 스크롤이 전체 페이지 크기만큼 내려가면
        if( $(window).scrollTop() + $(window).height() + 300 >= $(document).height() ) {
            getRecruitList(recruit_closed);
        }
    });

    $(document).on("click", ".btn-more", function(e) {
        alert("클릭");

        return false;
    });

    // 정렬기준 드롭다운 모달 열기
    $(document).on("click", ".btn-open-dropdown", function() {
        const recruit_no = $(this).data("recruit-no");
        const recruit_closed = $(this).data("recruit-closed");
        let html = ``;
        
        if(recruit_closed == "0") {
            html = `
                <dialog id="dropdownRecruitMore" class="option-dropdown border-normal drop-shadow-lg">
                    <ul class="nav font-bold text-gray-600 w-70 pb-0!">
                        <li><a href="${pageContext.request.contextPath}/recruit/detail/\${recruit_no}">채용공고 관리</a></li>
                        <li><a href="${pageContext.request.contextPath}/recruit/view/\${recruit_no}">지원자 상태로 채용공고 보기</a></li>
                    </ul>
                </dialog>`;
        }
        if(recruit_closed == "1") {
            html = `
                <dialog id="dropdownRecruitMore" class="option-dropdown border-normal drop-shadow-lg">
                    <ul class="nav font-bold text-gray-600 w-70 pb-0!">
                        <li><a href="${pageContext.request.contextPath}/recruit/detail/\${recruit_no}">채용공고 관리</a></li>
                        <li><a href="${pageContext.request.contextPath}/recruit/add/step1">채용공고 재등록</a></li>
                        <li><a href="${pageContext.request.contextPath}/recruit/view/\${recruit_no}">지원자 상태로 채용공고 보기</a></li>
                    </ul>
                </dialog>`;
        }

        $("#recruitMoreDiv").html(html);

        const rect = this.getBoundingClientRect();

        $("#dropdownRecruitMore").css({"left":rect.left+"px","top":(rect.bottom)+"px"});
        $("#dropdownRecruitMore")[0].showModal();

        return false;
    });

    // 바깥 클릭하면 드롭다운 모달 닫기
    $(document).on("click", ".option-dropdown", function(e) {
        if (e.target === this) {
            this.close();
        }
    });
});

function getRecruitList(recruit_closed) {

    if (requestLock) {
        return;
    }
    requestLock = true; // 스크롤 이벤트가 여러 번 발생 하기 때문에 ajax를 쓰는동안 락을 걸어야 한다.

    $.ajax({
        url: "${pageContext.request.contextPath}/api/recruit/my-upload",
        data: {"start": start
            ,"end": start + len - 1
            ,"recruit_closed": recruit_closed},
        dataType: "json",
        success: function (json) {
            console.log(JSON.stringify(json));

            if(json.length > 0) {
                
                let html = ``;
                $.each(json, (index, item) => {
                    
                    const companyLogoHtml = (item.company_logo != null)
                        ?`<img src="\${ctxPath}/resources/files/companyLogo/\${item.company_logo}" class="aspect-square w-15 object-cover" />`
                        :`<div class="aspect-square w-15 bg-gray-200 flex items-center justify-center"><i class="fa-solid fa-building text-2xl text-gray-500"></i></div>`;

                    let recruit_work_type = ``;
                    switch(item.recruit_work_type) {
                        case "1":
                            recruit_work_type = `대면근무`;
                        break;
                        case "2":
                            recruit_work_type = `대면재택혼합근무`;
                        break;
                        case "3":
                            recruit_work_type = `재택근무`;
                        break;
                    }

                    let borderHtml = (index != 0)?`border-t-1 border-gray-300`:``;

                    html += `
                        <li>
                            <a href="${pageContext.request.contextPath}/recruit/detail/\${item.recruit_no}" class="w-full text-left flex">
                                <div class="pl-4 pr-2 py-4">
                                    \${companyLogoHtml}
                                </div>
                                <div class="\${borderHtml} flex-1 py-2">
                                    <div class="font-bold text-gray-900 text-lg hover:underline">\${item.recruit_job_name}</div>
                                    <div>\${item.company_name}</div>
                                    <div class="text-gray-600">\${item.region_name} (\${recruit_work_type})</div>
                                </div>
                                <div class="\${borderHtml} flex items-center">
                                    <button type="button" data-recruit-no="\${item.recruit_no}" data-recruit-closed="\${recruit_closed}" class="btn-open-dropdown btn-transparent w-13 h-13 relative"><i class="absolute left-1/2 top-1/2 transform -translate-y-1/2 -translate-x-1/2 fa-solid fa-ellipsis text-xl"></i></button>
                                </div>
                            </a>
                        </li>`;
                });

                $("#recruitList").append(html);
            }
            else {
                if(start==1) { // 목록이 하나도 없다면
                    let html = `
                        <li>
                            <img src="${pageContext.request.contextPath}/images/no_recruit.svg" alt="" class="my-4 mx-auto w-50">
                            <div class="h1 mt-4">이 카테고리에 게시된 채용공고가 아직 없습니다.</div>
                            <div>게시한 채용공고는 여기에 표시됩니다.</div>
                            <a href="${pageContext.request.contextPath}/recruit/add/step1" class="button-orange mt-4 mb-8 inline-block">채용공고 등록</a>
                        </li>`;

                    $("#recruitList").html(html);
                }

                hasMore = false; // 더이상 불러올 목록이 없음
            }

            start += json.length;
            requestLock = false;
        },
        error: function (request, status, error) {
            if(request.status == 200) { // 로그인하지 않은 경우 html 내용을 페이지에 출력
                $(document).html(request.responseText);
            }
            else {
                alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
            }
            requestLock = false;
        }
    });
}
</script>
<style>
dialog.option-dropdown::backdrop {
    background: transparent;
}
</style>

    <!-- 채용공고 더보기 옵션 Dropdown -->
    <div id="recruitMoreDiv"></div>

    <!-- 본문 -->
    <div class="container m-auto grid grid-cols-10 lg:grid-cols-14 gap-6 xl:max-w-[1140px] py-5">
        <!-- 좌측 네비게이션 -->
        <div class="left-side col-span-3 hidden md:block h-full relative">
            <div class="border-normal sticky">
                <h1 class="h1 p-4 text-gray-500 flex items-top"><i class="fa-solid fa-bookmark text-sm mt-2 mr-3"></i>내 항목</h1>
                <ul class="recruit-nav pb-0!">
                    <li class="recruit-nav-selected"><a href="${pageContext.request.contextPath}/recruit/main/upload">게시한 채용공고</a></li>
                    <li><a href="${pageContext.request.contextPath}/recruit/main/save">지원한 채용공고</a></li>
                    <li><a href="${pageContext.request.contextPath}/recruit/add/step1">무료 채용공고 올리기</a></li>
                </ul>
            </div>
        </div>

        <!-- 중앙 본문 -->
        <div class="center col-span-10 md:col-span-7 space-y-2">
            <div class="border-rwd pt-4">
                <div class="px-4 space-y-2">
                    <div class="h1">게시한 채용공고</div>
                    <div>
                        <ul class="flex gap-2">
                            <li><button type="button" class="recruit-progress button-selected" data-recruit-closed="0">진행중</button></li>
                            <li><button type="button" class="recruit-progress button-gray" data-recruit-closed="1">마감됨</button></li>
                        </ul>
                    </div>
                </div>

                <hr class="border-gray-300 mt-4">

                <div id="recruitListDiv" class="text-center">
                    <ul id="recruitList">
                        <%-- 채용공고 목록 --%>
                    </ul>
                    <%-- <img src="${pageContext.request.contextPath}/images/no_recruit.svg" alt="" class="my-4 mx-auto w-50">
                    <div class="h1 mt-4">이 카테고리에 게시된 채용공고가 아직 없습니다.</div>
                    <div>게시한 채용공고는 여기에 표시됩니다.</div>
                    <button type="button" class="button-orange mt-4">채용공고 등록</button> --%>
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