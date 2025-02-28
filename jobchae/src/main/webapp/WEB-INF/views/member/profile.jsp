<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/header/header.jsp" />

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<!-- TailWind Script -->
<script src="https://unpkg.com/@tailwindcss/browser@4"></script>
<!-- Font Awesome CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">


<style type="text/tailwindcss">
        html {
            font-size: 0.9rem;
        }
        body {
            background-color: rgb(244, 242, 238);
        }
        .h1 {
            @apply text-[1.35rem] font-bold;
        }
        .border-normal {
            @apply border-1 border-gray-300 rounded-lg bg-white;
        }
        .border-search-board {
            @apply border-1 border-gray-300 rounded-lg bg-white;

            &>li:not(:last-child) {
                @apply border-b-4 border-gray-200;
            }

            &>li {
                @apply space-y-2;
            }

            &>li:not(.py-0) {
                @apply pt-4 pb-2;
            }
            
            &>li>*:not(.px-0) {
                @apply px-4;
            }

            .button-more {
                @apply rounded-b-lg py-2 text-center font-bold text-lg w-full cursor-pointer hover:bg-gray-100 transition-all duration-200;
            }
        }
        .border-board {
            @apply space-y-4;

            &>div {
                @apply border-1 border-gray-300 rounded-lg bg-white;
            }

            &>div:not(.space-y-0) {
                @apply space-y-2;
            }

            &>div:not(.py-0) {
                @apply pt-4;
                @apply pb-2;
            }
            
            &>div>*:not(.px-0) {
                @apply px-4;
            }

            .button-more {
                @apply rounded-b-lg py-2 text-center font-bold text-lg w-full cursor-pointer hover:bg-gray-100 transition-all duration-200;
            }
        }
        .border-search-member {
            @apply border-1 border-gray-300 rounded-lg bg-white;

            &>div:not(:last-child) {
                @apply border-b-1 border-gray-300 space-y-2;
            }

            &>div:not(.py-0) {
                @apply py-4;
            }
            
            &>div>*:not(.px-0) {
                @apply px-4;
            }
        }
        .button-more {
            @apply rounded-b-lg py-2 text-center font-bold text-lg w-full cursor-pointer hover:bg-gray-100 transition-all duration-200;
        }
        .nav-selected {
            @apply relative before:inline-block before:absolute before:w-0.5 before:h-10 before:bg-green-800 before:mr-2 before:left-0 before:top-1/2 before:-translate-y-1/2;
        }
        .nav {
            @apply list-none pb-2 [&>li]:px-4 [&>li]:hover:bg-gray-100 [&>li]:cursor-pointer [&>li>a]:block [&>li>a]:py-2;
        }
        .border-list {
            @apply my-0.5 space-y-4 py-4 bg-white;
            @apply first:border-1 first:border-gray-300 first:rounded-t-lg;
            @apply not-first:border-1 not-first:border-gray-300;
            @apply last:border-1 last:border-gray-300 last:rounded-b-lg;
        }
        .button-gray:not(.button-selected) {
            @apply border-1 rounded-full border-gray-400 px-3 py-0.5 font-bold text-gray-700 text-lg;
            @apply hover:bg-gray-100 hover:inset-ring-1 hover:inset-ring-gray-400 transition-all duration-200;
            @apply hover:cursor-pointer;
        }
        .button-orange:not(.button-selected) {
            @apply border-1 rounded-full border-orange-500 px-3 py-0.5 font-bold text-orange-500 text-lg;
            @apply hover:bg-gray-100 hover:inset-ring-1 hover:inset-ring-orange-500 transition-all duration-200;
            @apply hover:cursor-pointer;
        }
        .button-selected {
            @apply border-1 border-orange-400 rounded-full px-3 py-0.5 font-bold text-white text-lg bg-orange-400;
            @apply hover:bg-orange-500 hover:border-orange-500 transition-all duration-200;
            @apply hover:cursor-pointer;
        }
        .board-member-profile {
            @apply flex gap-4;

            /* 프로필 이미지 */
            div:first-child>a>img {
                @apply w-15 h-15 object-cover;
            }

            div:nth-child(2) span {
                @apply block text-gray-600 text-sm;
            }

            div:nth-child(2) span:first-child {
                @apply font-bold text-lg text-black;
            }

            /* 프로필 정보 및 팔로우 버튼 */
            div:nth-child(3) {
                @apply flex items-start;

                button {
                    @apply px-4 py-1 text-lg rounded-full;
                }

                button:hover {
                    @apply bg-gray-100 cursor-pointer;
                }

                /* 팔로우 버튼 */
                .follow-button {
                    @apply text-orange-500 font-bold;
                }
                
                /* 팔로우 버튼 */
                .unfollow-button {
                    @apply text-black;
                }
            }
        }

        .file-image {
            @apply grid grid-flow-row-dense grid-flow-col gap-1 p-0.5;

            :hover {
                @apply cursor-pointer;
            }

            button:first-child {
                @apply max-h-[50rem] m-auto col-span-3;
            }
            button:not(:first-child) {
                @apply m-auto;
            }
            
            button:not(:first-child)>img {
                @apply object-cover aspect-[3/2];
            }
            button.more-image {
                @apply relative;
            }
            button.more-image>img {
                @apply brightness-50;
            }
            button.more-image>span {
                @apply absolute text-white;
                @apply top-1/2 -translate-y-1/2 left-1/2 -translate-x-1/2;
            }
        }
        
        .reaction-images {
            @apply flex items-center;
            img {
                @apply w-6 rounded-full border-2 border-white;
            }
            img:not(img:last-child) {
                @apply -mr-2;
            }
        }

        .button-underline {
            @apply flex hover:cursor-pointer hover:underline hover:text-orange-500;
        }

        .hover-underline {
            @apply hover:cursor-pointer hover:underline hover:text-orange-500;
        }

        .button-board-action {
            @apply w-full h-10 flex items-center justify-center rounded-md font-bold hover:cursor-pointer hover:bg-gray-100;
        }
        button {
            @apply hover:cursor-pointer;
        }
        
        .btn-transparent {
            @apply px-4 py-1 text-lg rounded-full;
        }

        .btn-transparent:hover {
            @apply bg-gray-100 cursor-pointer;
        }
    </style>
<script type="text/javascript">
$(document).ready(function() {

    // 스크롤 위치에 따라 nav 선택 변경
    $(window).scroll(function() {
        for(let i=0; i<$(".center>*").length; i++) {
            if( $(".center>*").eq(i).position().top - 100 <= $(window).scrollTop() &&
                $(window).scrollTop() < $(".center>*").eq(i).height() + $(".center>*").eq(i).position().top - 100 ) {
                $(".nav>li").removeClass("nav-selected");
                $(".nav>li").eq(i).addClass("nav-selected");
            }
            // console.log($(".center>*").eq(i).position().top , $(window).scrollTop());
        }
    });

    // 정렬기준 모달 열기
    $(".btn-open-modal").on("click", function() {
        const btnId = $(this).attr("id");
        const modalId = "#modal" + btnId.slice("btn".length);
        const rect = this.getBoundingClientRect();
        $(modalId)[0].showModal();
    });

    // 바깥 클릭하면 모달 닫기
    /*
    $(".modal").on("click", function(e) {
        if (e.target === this) {
            this.close();
        }
    });
    */
    
    // 취소 버튼 또는 X 버튼으로 모달 닫기
    $(".btn-close-modal").on("click", function(e) {
        $(this).parent().parent().parent()[0].close();
    });


    // 자동완성 드롭다운 모달 열기
    $(".input-search").on("focus", function() {
        const inputId = $(this).attr("id");
        const dropdownId = "#suggest" + inputId.slice("input".length);
        const width = $(this).width();

        $(dropdownId).css({"width":width+8});
        $(dropdownId).removeClass("hidden");
    });
    
    // 바깥 클릭하면 드롭다운 모달 닫기
    $(".input-search").on("blur", function() {
        const inputId = $(this).attr("id");
        const dropdownId = "#" + inputId.slice(5) + "Suggest";

        setTimeout(() => {
            $(dropdownId).addClass("hidden");
        }, 100);
    });

    // 자동완성 선택 시 값 변경
    $(".suggest").on("click", function(e) {
        const keyword = $(e.target).text();

        const suggestId = $(this).attr("id");
        const inputId = "#input" + suggestId.slice(0, -"Suggest".length);

        const value = $(e.target).data("value");
        if(value!= undefined) {
            $(inputId).val(keyword);
            $(inputId+"Value").val(value);
        }
    });

    $(".input-search").on("input", function() {
        const inputId = $(this).attr("id");
        const search = inputId.slice("input".length);
        const dropdownId = "#suggest" + search;

        getSearch(inputId, search, dropdownId);
    });
});

function getSearch(inputId, searchPath, dropdownId) {

    const searchType = $(inputId).attr("name");
    const searchWord = search

    $.$.ajax({
        url: "${pageContext.request.contextPath}/search/"+searchPath,
        data: {searchType : $(inputId).val() // "region_name" : "서울"
              },
        dataType: "dataType",
        success: function (response) {
            

            // 자동완성 표시
            const width = $(inputId).width();
            $(dropdownId).css({"width":width+8});
            $(dropdownId).removeClass("hidden");
        }
    });
}
</script>
<style>
dialog.dropdown::backdrop {
    background: transparent;
}
</style>

    <!-- 경력 Modal -->
    <dialog id="modalMemberCareer" class="fixed left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 modal rounded-lg pt-6 pb-4 drop-shadow-lg w-200">
        <div class="modal-box  w-full flex flex-col max-h-[calc(100vh-80px)] space-y-4">
            <!-- 모달 상단부 -->
            <div>
                <button type="button" class="btn-close-modal btn btn-sm btn-circle btn-ghost absolute right-8 top-6">✕</button>
                <h1 class="h1 px-8">경력 입력</h1>

                <hr class="border-gray-200 mt-4">
            </div>
            
            <!-- 모달 내용 -->
            <div class="space-y-4 overflow-auto">
                <div class="text-gray-500 px-8">* 필수</div>
                <form name="memberCareerForm">
                <ul class="space-y-4 px-8">
                    <li>
                        <label for="jobName" class="text-gray-500">직종 *</label><br>
                        <input type="text" name="job_name" id="jobName" class="input-search w-full border-1 rounded-sm p-1"/>
                        <input type="hidden" name="fk_job_no" id="jobNameResult"/>

                        <!-- 직종 자동완성 Dropdown -->
                        <div id="jobNameSuggest" class="absolute suggest bg-white hidden rounded-lg drop-shadow-lg">
                            <ul>
                                <li class="hover:bg-gray-100 p-2" data-no="1">소프트웨어 개발자1</li>
                                <li class="hover:bg-gray-100 p-2" data-no="2">소프트웨어 개발자2</li>
                                <li class="hover:bg-gray-100 p-2" data-no="3">소프트웨어 개발자3</li>
                            </ul>
                        </div>
                    </li>
                    <li>
                        <label for="member_career_type" class="text-gray-500">고용 형태 *</label><br>
                        <select name="member_career_type" class="w-full border-1 rounded-sm p-1" id="member_career_type">
                            <option value="0">선택하세요</option>
                            <option value="1">정규직</option>
                            <option value="2">시간제</option>
                            <option value="3">자영업/개인사업</option>
                            <option value="4">프리랜서</option>
                            <option value="5">계약직</option>
                            <option value="6">인턴</option>
                            <option value="7">수습생</option>
                            <option value="8">시즌</option>
                        </select>
                    </li>
                    <li>
                        <label for="member_career_company" class="text-gray-500">회사 또는 단체 *</label><br>
                        <input type="text" name="member_career_company" id="member_career_company" class="w-full border-1 rounded-sm p-1"/>
                    </li>
                    <li>
                        <label class="text-gray-500">시작일 *</label><br>
                        <input type="hidden" name="member_career_startdate"/>
                        <div class="flex gap-4">
                            <select id="member_career_startdate_year" class="w-full border-1 rounded-sm p-1">
                                <option value="0">연도</option>
                                <option value="2025">2025</option>
                                <option value="2024">2024</option>
                                <option value="2023">2023</option>
                            </select>
                            <select id="member_career_startdate_month" class="w-full border-1 rounded-sm p-1">
                                <option value="0">월</option>
                                <option value="1">1월</option>
                                <option value="2">2월</option>
                                <option value="3">3월</option>
                                <option value="4">4월</option>
                                <option value="5">5월</option>
                                <option value="6">6월</option>
                                <option value="7">7월</option>
                                <option value="8">8월</option>
                                <option value="9">9월</option>
                                <option value="10">10월</option>
                                <option value="11">11월</option>
                                <option value="12">12월</option>
                            </select>
                        </div>
                    </li>
                    <li>
                        <label class="text-gray-500">종료일 *</label><br>
                        <input type="hidden" name="member_career_enddate"/>
                        <div class="flex gap-4">
                            <select id="member_career_enddate_year" class="w-full border-1 rounded-sm p-1 disabled:border-0 disabled:bg-gray-200" disabled>
                                <option value="0">연도</option>
                                <option value="2025">2025</option>
                                <option value="2024">2024</option>
                                <option value="2023">2023</option>
                            </select>
                            <select id="member_career_enddate_month" class="w-full border-1 rounded-sm p-1 disabled:border-0 disabled:bg-gray-200" disabled>
                                <option value="0">월</option>
                                <option value="1">1월</option>
                                <option value="2">2월</option>
                                <option value="3">3월</option>
                                <option value="4">4월</option>
                                <option value="5">5월</option>
                                <option value="6">6월</option>
                                <option value="7">7월</option>
                                <option value="8">8월</option>
                                <option value="9">9월</option>
                                <option value="10">10월</option>
                                <option value="11">11월</option>
                                <option value="12">12월</option>
                            </select>
                        </div>
                    </li>
                    <li>
                        <label for="region_name" class="text-gray-500">지역 *</label><br>
                        <input type="text" name="region_name" id="region_name" class="w-full border-1 rounded-sm p-1"/>
                        <input type="hidden" name="fk_region_no"/>
                    </li>
                    <li>
                        <label for="member_career_explain" class="text-gray-500">설명</label><br>
                        <textarea name="member_career_explain" id="member_career_explain" class="w-full h-40 border-1 rounded-sm p-1"></textarea>
                    </li>
                </ul>
                </form>
            </div>

            <!-- 모달 하단부 -->
            <div>
            <hr class="border-gray-200 mb-4">
            <div class="flex justify-end items-center gap-4 px-4">
                <div>
                    <button type="button" class="button-selected">저장</button>
                </div>
            </div>
            </div>
        </div>
    </dialog>

    <!-- 학력 Modal -->
    <dialog id="modalMemberEducation" class="fixed left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 modal rounded-lg pt-6 pb-4 drop-shadow-lg w-200">
        <div class="modal-box  w-full flex flex-col max-h-[calc(100vh-80px)] space-y-4">
            <!-- 모달 상단부 -->
            <div>
                <button type="button" class="btn-close-modal btn btn-sm btn-circle btn-ghost absolute right-8 top-6">✕</button>
                <h1 class="h1 px-8">학력 입력</h1>

                <hr class="border-gray-200 mt-4">
            </div>
            
            <!-- 모달 내용 -->
            <div class="space-y-4 overflow-auto">
                <div class="text-gray-500 px-8">* 필수</div>
                <form name="memberEducationForm">
                <ul class="space-y-4 px-8">
                    <li>
                        <label for="school_name" class="text-gray-500">학교 *</label><br>
                        <input type="text" name="school_name" id="school_name" class="w-full border-1 rounded-sm p-1"/>
                        <input type="hidden" name="fk_school_no"/>
                    </li>
                    <li>
                        <label for="member_education_degree" class="text-gray-500">학위 *</label><br>
                        <input type="text" name="member_education_degree" id="member_education_degree" class="w-full border-1 rounded-sm p-1"/>
                    </li>
                    <li>
                        <label for="major_name" class="text-gray-500">전공 *</label><br>
                        <input type="text" name="major_name" id="major_name" class="w-full border-1 rounded-sm p-1"/>
                        <input type="text" name="fk_major_no" class="hidden"/>
                    </li>
                    <li>
                        <label class="text-gray-500">입학일 *</label><br>
                        <input type="hidden" name="member_education_startdate"/>
                        <div class="flex gap-4">
                            <select id="member_education_startdate_year" class="w-full border-1 rounded-sm p-1">
                                <option value="0">연도</option>
                                <option value="2025">2025</option>
                                <option value="2024">2024</option>
                                <option value="2023">2023</option>
                            </select>
                            <select id="member_education_startdate_month" class="w-full border-1 rounded-sm p-1">
                                <option value="0">월</option>
                                <option value="1">1월</option>
                                <option value="2">2월</option>
                                <option value="3">3월</option>
                                <option value="4">4월</option>
                                <option value="5">5월</option>
                                <option value="6">6월</option>
                                <option value="7">7월</option>
                                <option value="8">8월</option>
                                <option value="9">9월</option>
                                <option value="10">10월</option>
                                <option value="11">11월</option>
                                <option value="12">12월</option>
                            </select>
                        </div>
                    </li>
                    <li>
                        <label class="text-gray-500">졸업일(예정) *</label><br>
                        <input type="hidden" name="member_education_enddate"/>
                        <div class="flex gap-4">
                            <select id="member_education_enddate_year" class="w-full border-1 rounded-sm p-1 disabled:border-0 disabled:bg-gray-200" disabled>
                                <option value="0">연도</option>
                                <option value="2025">2025</option>
                                <option value="2024">2024</option>
                                <option value="2023">2023</option>
                            </select>
                            <select id="member_education_enddate_month" class="w-full border-1 rounded-sm p-1 disabled:border-0 disabled:bg-gray-200" disabled>
                                <option value="0">월</option>
                                <option value="1">1월</option>
                                <option value="2">2월</option>
                                <option value="3">3월</option>
                                <option value="4">4월</option>
                                <option value="5">5월</option>
                                <option value="6">6월</option>
                                <option value="7">7월</option>
                                <option value="8">8월</option>
                                <option value="9">9월</option>
                                <option value="10">10월</option>
                                <option value="11">11월</option>
                                <option value="12">12월</option>
                            </select>
                        </div>
                    </li>
                    <li>
                        <label for="member_education_grade" class="text-gray-500">학점 *</label><br>
                        <input type="number" name="member_education_grade" id="member_education_grade" class="w-full border-1 rounded-sm p-1"/>
                    </li>
                    <li>
                        <label for="member_education_explain" class="text-gray-500">설명</label><br>
                        <textarea name="member_education_explain" id="member_education_explain" class="w-full h-40 border-1 rounded-sm p-1"></textarea>
                    </li>
                </ul>
                </form>
            </div>

            <!-- 모달 하단부 -->
            <div>
            <hr class="border-gray-200 mb-4">
            <div class="flex justify-end items-center gap-4 px-4">
                <div>
                    <button type="button" class="button-selected">저장</button>
                </div>
            </div>
            </div>
        </div>
    </dialog>

    <!-- 보유기술 Modal -->
    <dialog id="modalMemberSkill" class="fixed left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 modal rounded-lg pt-6 pb-4 drop-shadow-lg w-200">
        <div class="modal-box  w-full flex flex-col max-h-[calc(100vh-80px)] space-y-4">
            <!-- 모달 상단부 -->
            <div>
                <button type="button" class="btn-close-modal btn btn-sm btn-circle btn-ghost absolute right-8 top-6">✕</button>
                <h1 class="h1 px-8">보유기술 입력</h1>

                <hr class="border-gray-200 mt-4">
            </div>
            
            <!-- 모달 내용 -->
            <div class="space-y-4 overflow-auto">
                <div class="text-gray-500 px-8">* 필수</div>
                <form name="memberSkillForm">
                <ul class="space-y-4 px-8">
                    <li>
                        <label for="skill_name" class="text-gray-500">보유기술 *</label><br>
                        <input type="text" name="skill_name" id="skill_name" class="w-full border-1 rounded-sm p-1"/>
                        <input type="text" name="fk_skill_no" class="hidden"/>
                    </li>
                </ul>
                </form>
            </div>

            <!-- 모달 하단부 -->
            <div>
            <hr class="border-gray-200 mb-4">
            <div class="flex justify-end items-center gap-4 px-4">
                <div>
                    <button type="button" class="button-selected">저장</button>
                </div>
            </div>
            </div>
        </div>
    </dialog>
    <!-- 본문 -->
    <div class="container m-auto grid grid-cols-10 lg:grid-cols-14 gap-6 xl:max-w-[1140px]">

        <!-- 중앙 본문 -->
        <div class="center col-span-14 md:col-span-10 space-y-2 my-5">
            <div class="scroll-mt-22 border-board">

                <!-- 프로필 -->
                <div class="py-0 relative pb-4">
                    <div class="w-full h-50 px-0 bg-gray-100">
                    	<c:if test="${empty sessionScope.loginuser.member_background_img}">
                        	<img src="${pageContext.request.contextPath}/images/profile/background_img.jpg" class="w-full h-50 object-cover rounded-t-md"/>
                        	<button type="button" class="button absolute top-4 right-4 w-10 h-10 rounded-full text-orange-500 hover:text-orange-600 flex justify-center text-center items-center bg-white text-md"><i class="fa-solid fa-camera"></i></button>
                        </c:if>
                    	<c:if test="${not empty sessionScope.loginuser.member_background_img}">
                        	<img src="${pageContext.request.contextPath}/${sessionScope.loginuser.member_background_img}" class="w-full h-50 object-cover rounded-t-md"/>
                        </c:if>
                    </div>
                    <c:if test="${empty sessionScope.loginuser.member_profile}">
	                    <div class="absolute top-22">
	                        <button type="button" class="button"><img src="${pageContext.request.contextPath}/images/profile/profile.png" class="w-40 h-40 rounded-full object-cover"/></button>
	                    </div>
	                    <button type="button" class="button absolute top-50 left-33 w-12 h-12 rounded-full border-1 border-orange-500 text-orange-500 flex justify-center text-center items-center bg-white text-xl"><i class="fa-solid fa-plus"></i></button>
                    </c:if>
                    <c:if test="${not empty sessionScope.loginuser.member_profile}">
	                    <div class="absolute top-22">
	                        <button type="button" class="button"><img src="${pageContext.request.contextPath}/${sessionScope.loginuser.member_profile}" class="w-40 h-40 rounded-full object-cover"/></button>
	                    </div>
                    </c:if>
                    <div class="text-end text-xl py-2">
                        <button type="button" class="btn-transparent"><i class="fa-solid fa-pen"></i></button>
                    </div>

                    <div>
                        <div class="text-3xl font-bold">
                            이준영
                        </div>
                        <div class="text-lg">
                            신한대학교 학생
                        </div>
                        <div class="space-x-2">
                            <span class="text-gray-500">대한민국 서울</span>
                            <span><a href="#" class="hover:underline text-orange-500 font-bold">연락처</a></span>
                        </div>
                        <div>
                            <a href="#" class="hover:underline text-orange-500 font-bold">팔로워 1,243명</a>
                        </div>
                    </div>
                    <div class="flex space-x-2">
                        <button type="button" class="button-selected">활동 상태</button>
                        <button type="button" class="button-gray">리소스</button>
                    </div>
                </div>

                <!-- 분석 -->
                <div class="py-0">
                    <h1 class="h1 pt-4">분석</h1>
                    <div class="flex space-x-2 pb-2 text-gray-800 text-center">
                            <a href="#" class="button-board-action space-x-2">
                                <i class="fa-solid fa-user-group text-2xl"></i>
                                <span class="font-bold text-lg">프로필 조회 0</span>
                            </a>
                            <a href="#" class="button-board-action space-x-2">
                                <i class="fa-solid fa-chart-simple text-2xl"></i>
                                <span class="font-bold text-lg">업데이트 노출 48</span>
                            </a>
                            <a href="#" class="button-board-action space-x-2">
                                <i class="fa-solid fa-magnifying-glass text-2xl"></i>
                                <span class="font-bold text-lg">검색결과 노출 3</span>
                            </a>
                    </div>
                    <div class="px-0">
                        <hr class="border-gray-300">
                        <button type="button" class="button-more">분석 모두 보기 <i class="fa-solid fa-arrow-right"></i></button>
                    </div>
                </div>

                <!-- 활동 -->
                <div class="space-y-0">
                    <h1 class="h1 mb-0">활동</h1>
                    <div class="text-gray-500 pb-2 text-lg">
                        팔로워 2,123명
                    </div>
                    <div id="update" class="border-board flex gap-4">
                        <!-- 게시물 -->
                        <div>
                            <!-- 멤버 프로필 -->
                            <div class="board-member-profile">
                                <div>
                                    <a href="#"><img src="./쉐보레전면.jpg" /></a>
                                </div>
                                <div class="flex-1">
                                    <a href="#">
                                        <span>CMC Global Company Limited.</span>
                                        <span>팔로워 26,549명</span>
                                    </a>
                                    <span>1년</span>
                                </div>
                                <div>
                                    <button type="button" class="follow-button"><i class="fa-solid fa-plus"></i>&nbsp;팔로우</button>
                                    <button type="button"><i class="fa-solid fa-ellipsis"></i></button>
                                </div>
                            </div>
                            <!-- 글 내용 -->
                            <div>
                                <p>
                                    On February 10, 2025, representatives from CMC Corp attended a meeting with the government regarding tasks and solutions for private enterprises to accelerate and contribute to the country's rapid and sustainable development in the new era.
                                </p>
                            </div>
                            <!-- 사진 또는 동영상 등 첨부파일 -->
                            <div class="px-0">
                                <div class="file-image">
                                    <button type="button"><img src="4.png"/></button>
                                    <button type="button"><img src="6.png"/></button>
                                    <button type="button"><img src="7.png"/></button>
                                    <button type="button" class="more-image"><img src="240502-Gubi-Showroom-London-003-Print.jpg"/>
                                        <span class="flex items-center">
                                            <span><i class="fa-solid fa-plus"></i></span>
                                            <span class="text-4xl">3</span>
                                        </span>
                                    </button>
                                </div>
                            </div>
                            <!-- 반응 및 댓글 수(아무 반응 및 댓글이 없으면 표시하지 않음, 댓글만 있으면 댓글만 표시 등) -->
                            <div>
                                <ul class="flex gap-4 text-gray-600">
                                    <li class="flex-1">
                                        <button type="button" class="button-underline">
                                            <div class="reaction-images">
                                                <img src="${pageContext.request.contextPath}/images/emotion/celebrate_small.svg"/>
                                                <img src="${pageContext.request.contextPath}/images/emotion/celebrate_small.svg"/>
                                                <img src="${pageContext.request.contextPath}/images/emotion/celebrate_small.svg"/>
                                            </div>
                                            <span id="reactionCount">120</span>
                                        </button>
                                    </li>
                                    <li>
                                        <button type="button" class="button-underline">
                                            <span>댓글&nbsp;</span>
                                            <span id="commentCount">1,205</span>
                                        </button>
                                    </li>
                                    <li>
                                        <button type="button" class="button-underline">
                                            <span>퍼감&nbsp;</span>
                                            <span id="commentCount">4</span>
                                        </button>
                                    </li>
                                </ul>
                            </div>
        
                            <hr class="border-gray-300 mx-4">
                            <!-- 추천 댓글 퍼가기 등 버튼 -->
                            <div class="py-0">
                                <ul class="grid grid-cols-4 gap-4 text-center">
                                    <li>
                                        <button type="button" class="button-board-action">
                                            <i class="fa-regular fa-thumbs-up"></i>
                                            <span>추천</span>
                                        </button>
                                    </li>
                                    <li>
                                        <button type="button" class="button-board-action">
                                            <i class="fa-regular fa-comment"></i>
                                            <span>댓글</span>
                                        </button>
                                    </li>
                                    <li>
                                        <button type="button" class="button-board-action">
                                            <i class="fa-solid fa-retweet"></i>
                                            <span>퍼가기</span>
                                        </button>
                                    </li>
                                    <li>
                                        <button type="button" class="button-board-action">
                                            <i class="fa-regular fa-paper-plane"></i>
                                            <span>보내기</span>
                                        </button>
                                    </li>
                                </ul>
                            </div>
                        </div>
        
                        <!-- 게시물 -->
                        <div class="mb-4">
                            <!-- 멤버 프로필 -->
                            <div class="board-member-profile">
                                <div>
                                    <a href="#"><img src="./쉐보레전면.jpg" /></a>
                                </div>
                                <div class="flex-1">
                                    <a href="#">
                                        <span>CMC Global Company Limited.</span>
                                        <span>팔로워 26,549명</span>
                                    </a>
                                    <span>1년</span>
                                </div>
                                <div>
                                    <button type="button" class="follow-button"><i class="fa-solid fa-plus"></i>&nbsp;팔로우</button>
                                    <button type="button"><i class="fa-solid fa-ellipsis"></i></button>
                                </div>
                            </div>
                            <!-- 글 내용 -->
                            <div>
                                <p>
                                    On February 10, 2025, representatives from CMC Corp attended a meeting with the government regarding tasks and solutions for private enterprises to accelerate and contribute to the country's rapid and sustainable development in the new era.
                                </p>
                            </div>
                            <!-- 사진 또는 동영상 등 첨부파일 -->
                            <div class="px-0">
                                <div class="file-image">
                                    <button type="button"><img src="4.png"/></button>
                                    <button type="button"><img src="6.png"/></button>
                                    <button type="button"><img src="7.png"/></button>
                                    <button type="button" class="more-image"><img src="240502-Gubi-Showroom-London-003-Print.jpg"/>
                                        <span class="flex items-center">
                                            <span><i class="fa-solid fa-plus"></i></span>
                                            <span class="text-4xl">3</span>
                                        </span>
                                    </button>
                                </div>
                            </div>
                            <!-- 반응 및 댓글 수(아무 반응 및 댓글이 없으면 표시하지 않음, 댓글만 있으면 댓글만 표시 등) -->
                            <div>
                                <ul class="flex gap-4 text-gray-600">
                                    <li class="flex-1">
                                        <button type="button" class="button-underline">
                                            <div class="reaction-images">
                                                <img src="${pageContext.request.contextPath}/images/emotion/celebrate_small.svg"/>
                                                <img src="${pageContext.request.contextPath}/images/emotion/celebrate_small.svg"/>
                                                <img src="${pageContext.request.contextPath}/images/emotion/celebrate_small.svg"/>
                                            </div>
                                            <span id="reactionCount">120</span>
                                        </button>
                                    </li>
                                    <li>
                                        <button type="button" class="button-underline">
                                            <span>댓글&nbsp;</span>
                                            <span id="commentCount">1,205</span>
                                        </button>
                                    </li>
                                    <li>
                                        <button type="button" class="button-underline">
                                            <span>퍼감&nbsp;</span>
                                            <span id="commentCount">4</span>
                                        </button>
                                    </li>
                                </ul>
                            </div>
        
                            <hr class="border-gray-300 mx-4">
                            <!-- 추천 댓글 퍼가기 등 버튼 -->
                            <div class="py-0">
                                <ul class="grid grid-cols-4 gap-4 text-center">
                                    <li>
                                        <button type="button" class="button-board-action">
                                            <i class="fa-regular fa-thumbs-up"></i>
                                            <span>추천</span>
                                        </button>
                                    </li>
                                    <li>
                                        <button type="button" class="button-board-action">
                                            <i class="fa-regular fa-comment"></i>
                                            <span>댓글</span>
                                        </button>
                                    </li>
                                    <li>
                                        <button type="button" class="button-board-action">
                                            <i class="fa-solid fa-retweet"></i>
                                            <span>퍼가기</span>
                                        </button>
                                    </li>
                                    <li>
                                        <button type="button" class="button-board-action">
                                            <i class="fa-regular fa-paper-plane"></i>
                                            <span>보내기</span>
                                        </button>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 경력 -->
                <div>
                    <div class="flex">
                        <h1 class="h1 flex-1">경력</h1>
                        <button type="button" id="btnMemberCareer" class="btn-transparent btn-open-modal"><i class="fa-solid fa-plus"></i></button>
                        <button type="button" class="btn-transparent"><i class="fa-solid fa-pen"></i></button>
                    </div>
                    
                    <ul class="space-y-2">
                        <li class="border-b-1 border-gray-300 py-2">
                            <a href="#" class="flex">
                                <div>
                                    <img src="./쉐보레전면.jpg" class="aspect-square w-15 object-cover"/>
                                </div>
                                <div class="flex-1 ml-4">
                                    <div class="font-bold text-xl hover:underline">직종</div>
                                    <div>단체</div>
                                    <div class="text-gray-600">2018년 3월 ~ 2023년 2월</div>
                                </div>
                            </a>
                        </li>
                        <li class="py-2">
                            <a href="#" class="flex">
                                <div>
                                    <img src="./쉐보레전면.jpg" class="aspect-square w-15 object-cover"/>
                                </div>
                                <div class="flex-1 ml-4">
                                    <div class="font-bold text-xl hover:underline">직종</div>
                                    <div>단체</div>
                                    <div class="text-gray-600">2018년 3월 ~ 2023년 2월</div>
                                </div>
                            </a>
                        </li>
                    </ul>
                </div>

                <!-- 학력 -->
                <div>
                    <div class="flex">
                        <h1 class="h1 flex-1">학력</h1>
                        <button type="button" id="btnMemberEducation" class="btn-open-modal btn-transparent"><i class="fa-solid fa-plus"></i></button>
                        <button type="button" class="btn-transparent"><i class="fa-solid fa-pen"></i></button>
                    </div>
                    
                    <ul class="space-y-2">
                        <li class="border-b-1 border-gray-300 py-2">
                            <a href="#" class="flex">
                                <div>
                                    <img src="./쉐보레전면.jpg" class="aspect-square w-15 object-cover"/>
                                </div>
                                <div class="flex-1 ml-4">
                                    <div class="font-bold text-xl hover:underline">한양대학교</div>
                                    <div>컴퓨터 공학 석사</div>
                                    <div class="text-gray-600">2018년 3월 ~ 2023년 2월</div>
                                    <div>학점: 3</div>
                                </div>
                            </a>
                        </li>
                        <li class="py-2">
                            <a href="#" class="flex">
                                <div>
                                    <img src="./쉐보레전면.jpg" class="aspect-square w-15 object-cover"/>
                                </div>
                                <div class="flex-1 ml-4">
                                    <div class="font-bold text-xl hover:underline">한양대학교</div>
                                    <div>컴퓨터 공학 석사</div>
                                    <div class="text-gray-600">2018년 3월 ~ 2023년 2월</div>
                                    <div>학점: 3</div>
                                </div>
                            </a>
                        </li>
                    </ul>
                </div>

                <!-- 보유기술 -->
                <div>
                    <div class="flex">
                        <h1 class="h1 flex-1">보유기술</h1>
                        <button type="button" id="btnMemberSkill" class="btn-open-modal btn-transparent"><i class="fa-solid fa-plus"></i></button>
                        <button type="button" class="btn-transparent"><i class="fa-solid fa-pen"></i></button>
                    </div>
                    
                    <ul class="space-y-2">
                        <li class="border-b-1 border-gray-300 py-2">
                            <a href="#" class="flex">
                                <div class="font-bold text-lg hover:underline">스프링 MVC</div>
                            </a>
                        </li>
                        <li class="py-2">
                            <a href="#" class="flex">
                                <div class="font-bold text-lg hover:underline">스프링 프레임워크</div>
                            </a>
                        </li>
                    </ul>
                </div>

                <!-- 관심분야 -->
                <div class="py-0">
                    <h1 class="h1 pt-4">관심분야</h1>
                    <div class="px-0">
                        <!-- 탭 -->
                        <input type="radio" name="tabs" id="tab1" class="hidden peer/tab1" checked>
                        <label class="ml-4 px-4 inline-block cursor-pointer p-2 text-center peer-checked/tab1:text-orange-500 peer-checked/tab1:font-bold peer-checked/tab1:border-b-2 peer-checked/tab1:border-orange-500" for="tab1">
                        회사
                        </label>
                        <input type="radio" name="tabs" id="tab2" class="hidden peer/tab2">
                        <label class="px-4 inline-block cursor-pointer p-2 text-center peer-checked/tab2:text-orange-500 peer-checked/tab2:font-bold peer-checked/tab2:border-b-2 peer-checked/tab2:border-orange-500" for="tab2">
                        학교
                        </label>
                        <hr class="border-gray-300">
                      
                        <!-- 회사 탭 -->
                        <div class="hidden col-span-2 peer-checked/tab1:block">
                            <ul class="px-4 grid grid-cols-2 py-4">
                                <li class="col-span-1">
                                    <a href="#" class="flex">
                                        <div>
                                            <img src="./쉐보레전면.jpg" class="aspect-square w-15 object-cover"/>
                                        </div>
                                        <div class="flex-1 ml-4">
                                            <div class="font-bold text-xl hover:underline">Microsoft</div>
                                            <div class="text-gray-600">팔로워 2,043명</div>
                                            <button type="button" class="button-gray mt-2"><i class="fa-solid fa-check"></i> 팔로우 중</button>
                                        </div>
                                    </a>
                                </li>
                                <li class="col-span-1">
                                    <a href="#" class="flex">
                                        <div>
                                            <img src="./쉐보레전면.jpg" class="aspect-square w-15 object-cover"/>
                                        </div>
                                        <div class="flex-1 ml-4">
                                            <div class="font-bold text-xl hover:underline">Intel</div>
                                            <div class="text-gray-600">팔로워 2,043명</div>
                                            <button type="button" class="button-orange mt-2"><i class="fa-solid fa-plus"></i> 팔로우</button>
                                        </div>
                                    </a>
                                </li>
                            </ul>
                            <hr class="border-gray-300">
                            <button type="button" class="button-more">회사 모두 표시 <i class="fa-solid fa-arrow-right"></i></button>
                        </div>
                      
                        <!-- 학교 탭 -->
                        <div class="hidden col-span-2 peer-checked/tab2:block">
                            <ul class="px-4 grid grid-cols-2 py-4">
                                <li class="col-span-1">
                                    <a href="#" class="flex">
                                        <div>
                                            <img src="./쉐보레전면.jpg" class="aspect-square w-15 object-cover"/>
                                        </div>
                                        <div class="flex-1 ml-4">
                                            <div class="font-bold text-xl hover:underline">한양대학교</div>
                                            <div class="text-gray-600">팔로워 2,043명</div>
                                            <button type="button" class="button-gray mt-2"><i class="fa-solid fa-check"></i> 팔로우 중</button>
                                        </div>
                                    </a>
                                </li>
                                <li class="col-span-1">
                                    <a href="#" class="flex">
                                        <div>
                                            <img src="./쉐보레전면.jpg" class="aspect-square w-15 object-cover"/>
                                        </div>
                                        <div class="flex-1 ml-4">
                                            <div class="font-bold text-xl hover:underline">한양대학교</div>
                                            <div class="text-gray-600">팔로워 2,043명</div>
                                            <button type="button" class="button-orange mt-2"><i class="fa-solid fa-plus"></i> 팔로우</button>
                                        </div>
                                    </a>
                                </li>
                            </ul>
                            <hr class="border-gray-300">
                            <button type="button" class="button-more">학교 모두 표시 <i class="fa-solid fa-arrow-right"></i></button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 우측 광고 -->
        <div class="right-side lg:col-span-4 h-full relative hidden lg:block">
            <div class="border-list sticky top-20 space-y-2 text-center relative">
                <div class="absolute top-5 right-5 bg-white rounded-sm text-[0.9rem]">
                    <span class="pl-1.5 font-bold">광고</span>
                    <button type="button" class="font-bold hover:bg-gray-100 cursor-pointer px-1.5 py-1 rounded-r-sm"><i class="fa-solid fa-ellipsis"></i></button>
                </div>
                <div>
                    <img src="7.png"/>
                </div>
                <div class="px-4">
                    <p class="font-bold">준영님, Tridge의 관련 채용공고를 살펴보세요.</p>
                    <p>업계 최신 뉴스와 취업 정보를 받아보세요.</p>
                </div>
                <div class="px-4">
                    <button type="button" class="button-orange">팔로우</button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>