<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/header/header.jsp" />

<%-- TailWind 사용자 정의 CSS --%>
<jsp:include page="/WEB-INF/views/member/profileTailwind.jsp" />

<script type="text/javascript">
    const ctxPath = '${pageContext.request.contextPath}';
    const memberId = '${requestScope.memberId}'; // 조회 대상 회원 아이디
    const reload = true; // 등록, 수정, 삭제 후 페이지 새로고침 여부
    const isMyProfile = ${not empty sessionScope.loginuser && sessionScope.loginuser.member_id == requestScope.memberId}; // 본인의 프로필인지 여부
</script>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/member/profileMore.js"></script>

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

});
</script>

    <!-- 연락처 Modal -->
    <dialog id="modalMemberContact"
        class="fixed left-1/2 top-1/3 -translate-x-1/2 -translate-y-1/2 modal rounded-lg pt-6 pb-4 drop-shadow-lg w-150">
        <div class="modal-box  w-full flex flex-col max-h-[calc(100vh-80px)] space-y-4">
            <!-- 모달 상단부 -->
            <div>
                <button type="button"
                    class="btn-close-modal btn btn-sm btn-circle btn-ghost absolute right-8 top-6">✕</button>
                <h1 class="h1 px-8">연락처</h1>

                <hr class="border-gray-200 mt-4">
            </div>

            <!-- 모달 내용 -->
            <div class="space-y-4 overflow-auto">
                <ul class="space-y-4 px-8">
                    <li>
                        <div class="font-bold text-lg">JobChae 프로필</div>
                        <div>
                            <a class="hover:underline text-orange-500 font-bold" href="http://www.jobchae.kro.kr${pageContext.request.contextPath}/member/profile/${requestScope.memberVO.member_id}">
                                www.jobchae.kro.kr${pageContext.request.contextPath}/member/profile/${requestScope.memberVO.member_id}
                            </a>
                        </div>
                    </li>
                    <li>
                        <div class="font-bold text-lg">이메일</div>
                        <div>
                            <a class="hover:underline text-orange-500 font-bold" href="mailto:${requestScope.memberVO.member_email}">
                                ${requestScope.memberVO.member_email}
                            </a>
                        </div>
                    </li>
                    <li>
                        <div class="font-bold text-lg">전화번호</div>
                        <div>
                            <a class="hover:underline text-orange-500 font-bold" href="tel:${requestScope.memberVO.member_tel}">
                                ${requestScope.memberVO.member_tel}
                            </a>
                        </div>
                    </li>
                    <%-- <li>
                        <div>팔로우 날짜</div>
                        <div></div>
                    </li> --%>
                </ul>
            </div>
        </div>
    </dialog>

    <!-- 경력 Modal -->
    <dialog id="modalMemberCareer"
        class="fixed left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 modal rounded-lg pt-6 pb-4 drop-shadow-lg w-200">
        <div class="modal-box  w-full flex flex-col max-h-[calc(100vh-80px)] space-y-4">
            <!-- 모달 상단부 -->
            <div>
                <button type="button"
                    class="btn-close-modal btn btn-sm btn-circle btn-ghost absolute right-8 top-6">✕</button>
                <h1 class="h1 px-8">경력 입력</h1>

                <hr class="border-gray-200 mt-4">
            </div>

            <!-- 모달 내용 -->
            <div class="space-y-4 overflow-auto">
                <div class="text-gray-500 px-8">* 필수</div>
                <form name="memberCareerForm">
                    <input type="hidden" name="member_career_no">
                    <ul class="space-y-4 px-8">
                        <li>
                            <label for="job_name" class="text-gray-500">직종 *</label><br>
                            <input type="text" name="job_name" id="job_name"
                                data-target-url="/api/member/job/search"
                                data-search-type="job_name"
                                data-result-name="fk_job_no"
                                class="input-search w-full border-1 rounded-sm p-1" />
                            <input type="hidden" name="fk_job_no" class="required"/>
                            <span class="hidden error text-red-600 text-sm">직종을 목록에서 선택하세요.</span>
                        </li>
                        <li>
                            <label for="member_career_type" class="text-gray-500">고용 형태 *</label><br>
                            <select name="member_career_type" class="w-full border-1 rounded-sm p-1 required"
                                id="member_career_type">
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
                            <span class="hidden error text-red-600 text-sm">고용 형태를 목록에서 선택하세요.</span>
                        </li>
                        <li>
                            <label for="member_career_company" class="w-14 text-gray-500">회사 또는 단체 *</label><br>
                            <div class="relative">
                                <input type="text" name="member_career_company" id="member_career_company"
                                data-target-url="/api/member/company/search"
                                data-search-type="company_name"
                                data-result-name="fk_company_no"
                                class="input-search w-full border-1 rounded-sm p-1 required"/>
                                <span class="hidden error text-red-600 text-sm">회사 또는 단체를 입력하세요.</span>
                            </div>
                            <input type="hidden" name="fk_company_no"/>
                        </li>
                        <li class="flex items-center gap-2">
                            <input type="checkbox" name="member_career_is_current" value="1" style="zoom:1.5;" class="accent-orange-600 opacity-60 required" id="member_career_is_current"/>
                            <label for="member_career_is_current" class="text-lg pb-0.5">현재 이 업무로 근무 중</label>
                        </li>
                        <li>
                            <label class="text-gray-500">시작일 *</label><br>
                            <div class="flex gap-4">
                                <select id="member_career_startdate_year" class="select-date w-full border-1 rounded-sm p-1">
                                    <option value="0">연도</option>
                                </select>
                                <select id="member_career_startdate_month" class="select-date w-full border-1 rounded-sm p-1">
                                    <option value="0">월</option>
                                    <option value="01">1월</option>
                                    <option value="02">2월</option>
                                    <option value="03">3월</option>
                                    <option value="04">4월</option>
                                    <option value="05">5월</option>
                                    <option value="06">6월</option>
                                    <option value="07">7월</option>
                                    <option value="08">8월</option>
                                    <option value="09">9월</option>
                                    <option value="10">10월</option>
                                    <option value="11">11월</option>
                                    <option value="12">12월</option>
                                </select>
                            </div>
                            <input type="hidden" name="member_career_startdate"class="required"/>
                            <span class="hidden error text-red-600 text-sm">시작일을 선택하세요.</span>
                        </li>
                        <li>
                            <label class="text-gray-500">종료일 *</label><br>
                            <div class="flex gap-4">
                                <select id="member_career_enddate_year"
                                    class="select-date w-full border-1 rounded-sm p-1 disabled:border-0 disabled:bg-gray-200">
                                    <option value="0">연도</option>
                                </select>
                                <select id="member_career_enddate_month"
                                    class="select-date w-full border-1 rounded-sm p-1 disabled:border-0 disabled:bg-gray-200">
                                    <option value="0">월</option>
                                    <option value="01">1월</option>
                                    <option value="02">2월</option>
                                    <option value="03">3월</option>
                                    <option value="04">4월</option>
                                    <option value="05">5월</option>
                                    <option value="06">6월</option>
                                    <option value="07">7월</option>
                                    <option value="08">8월</option>
                                    <option value="09">9월</option>
                                    <option value="10">10월</option>
                                    <option value="11">11월</option>
                                    <option value="12">12월</option>
                                </select>
                            </div>
                            <input type="hidden" name="member_career_enddate" class="required"/>
                            <span class="hidden error text-red-600 text-sm">종료일을 선택하세요.</span>
                        </li>
                        <li>
                            <label for="region_name" class="text-gray-500">지역 *</label><br>
                            <input type="text" name="region_name" id="region_name"
                                data-target-url="/api/member/region/search"
                                data-search-type="region_name"
                                data-result-name="fk_region_no"
                                class="input-search w-full border-1 rounded-sm p-1" />
                            <input type="hidden" name="fk_region_no" class="required"/>
                            <span class="hidden error text-red-600 text-sm">지역을 목록에서 선택하세요.</span>
                        </li>
                        <li>
                            <label for="member_career_explain" class="text-gray-500">설명</label><br>
                            <textarea name="member_career_explain" id="member_career_explain"
                                class="w-full h-40 border-1 rounded-sm p-1 resize-none"></textarea>
                        </li>
                    </ul>
                </form>
            </div>

            <!-- 모달 하단부 -->
            <div>
                <hr class="border-gray-200 mb-4">
                <div class="flex justify-between items-center px-4">
                    <div>
                        <button type="button" id="deleteMemberCareer" class="btn-transparent">경력 삭제</button>
                    </div>
                    <div>
                        <button type="button" id="submitMemberCareer" class="button-selected">저장</button>
                    </div>
                </div>
            </div>
        </div>
    </dialog>

    <!-- 학력 Modal -->
    <dialog id="modalMemberEducation"
        class="fixed left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 modal rounded-lg pt-6 pb-4 drop-shadow-lg w-200">
        <div class="modal-box  w-full flex flex-col max-h-[calc(100vh-80px)] space-y-4">
            <!-- 모달 상단부 -->
            <div>
                <button type="button"
                    class="btn-close-modal btn btn-sm btn-circle btn-ghost absolute right-8 top-6">✕</button>
                <h1 class="h1 px-8">학력 입력</h1>

                <hr class="border-gray-200 mt-4">
            </div>

            <!-- 모달 내용 -->
            <div class="space-y-4 overflow-auto">
                <div class="text-gray-500 px-8">* 필수</div>
                <form name="memberEducationForm">
                    <input type="hidden" name="member_education_no">
                    <ul class="space-y-4 px-8">
                        <li>
                            <label for="school_name" class="text-gray-500">학교 *</label><br>
                            <input type="text" name="school_name" id="school_name"
                                data-target-url="/api/member/school/search"
                                data-search-type="school_name"
                                data-result-name="fk_school_no"
                                class="input-search w-full border-1 rounded-sm p-1" />
                            <input type="hidden" name="fk_school_no" class="required"/>
                            <span class="hidden error text-red-600 text-sm">학교를 선택하세요.</span>
                        </li>
                        <li>
                            <label for="member_education_degree" class="text-gray-500">학위 *</label><br>
                            <select name="member_education_degree" class="w-full border-1 rounded-sm p-1 required"
                                id="member_education_degree">
                                <option value="0">선택하세요</option>
                                <option value="1">중학교 졸업</option>
                                <option value="2">고등학교 졸업</option>
                                <option value="3">전문학사</option>
                                <option value="4">학사</option>
                                <option value="5">석사</option>
                                <option value="6">박사</option>
                            </select>
                            <span class="hidden error text-red-600 text-sm">학위를 목록에서 선택하세요.</span>
                        </li>
                        <li>
                            <label for="major_name" class="text-gray-500">전공 *</label><br>
                            <input type="text" name="major_name" id="major_name"
                                data-target-url="/api/member/major/search"
                                data-search-type="major_name"
                                data-result-name="fk_major_no"
                                class="input-search w-full border-1 rounded-sm p-1" />
                            <input type="text" name="fk_major_no" class="hidden required" />
                            <span class="hidden error text-red-600 text-sm">전공을 선택하세요.</span>
                        </li>
                        <li>
                            <label class="text-gray-500">입학일 *</label><br>
                            <div class="flex gap-4">
                                <select id="member_education_startdate_year" class="select-date w-full border-1 rounded-sm p-1">
                                    <option value="0">연도</option>
                                </select>
                                <select id="member_education_startdate_month"
                                    class="select-date w-full border-1 rounded-sm p-1">
                                    <option value="0">월</option>
                                    <option value="01">1월</option>
                                    <option value="02">2월</option>
                                    <option value="03">3월</option>
                                    <option value="04">4월</option>
                                    <option value="05">5월</option>
                                    <option value="06">6월</option>
                                    <option value="07">7월</option>
                                    <option value="08">8월</option>
                                    <option value="09">9월</option>
                                    <option value="10">10월</option>
                                    <option value="11">11월</option>
                                    <option value="12">12월</option>
                                </select>
                            </div>
                            <input type="hidden" name="member_education_startdate" class="required"/>
                            <span class="hidden error text-red-600 text-sm">입학일을 선택하세요.</span>
                        </li>
                        <li>
                            <label class="text-gray-500">졸업일(예정) *</label><br>
                            <div class="flex gap-4">
                                <select id="member_education_enddate_year"
                                    class="select-date w-full border-1 rounded-sm p-1">
                                    <option value="0">연도</option>
                                </select>
                                <select id="member_education_enddate_month"
                                    class="select-date w-full border-1 rounded-sm p-1">
                                    <option value="0">월</option>
                                    <option value="01">1월</option>
                                    <option value="02">2월</option>
                                    <option value="03">3월</option>
                                    <option value="04">4월</option>
                                    <option value="05">5월</option>
                                    <option value="06">6월</option>
                                    <option value="07">7월</option>
                                    <option value="08">8월</option>
                                    <option value="09">9월</option>
                                    <option value="10">10월</option>
                                    <option value="11">11월</option>
                                    <option value="12">12월</option>
                                </select>
                            </div>
                            <input type="hidden" name="member_education_enddate" class="required"/>
                            <span class="hidden error text-red-600 text-sm">졸업일을 선택하세요.</span>
                        </li>
                        <li>
                            <label for="member_education_grade" class="text-gray-500">학점 *</label><br>
                            <input type="number" name="member_education_grade" id="member_education_grade"
                                class="w-full border-1 rounded-sm p-1 required" min=2.0 max=4.5/>
                                <span class="hidden error text-red-600 text-sm">학점을 선택하세요.</span>
                        </li>
                        <li>
                            <label for="member_education_explain" class="text-gray-500">설명</label><br>
                            <textarea name="member_education_explain" id="member_education_explain"
                                class="w-full h-40 border-1 rounded-sm p-1 resize-none"></textarea>
                        </li>
                    </ul>
                </form>
            </div>

            <!-- 모달 하단부 -->
            <div>
                <hr class="border-gray-200 mb-4">
                <div class="flex justify-between items-center px-4">
                    <div>
                        <button type="button" id="deleteMemberEducation" class="btn-transparent">학력 삭제</button>
                    </div>
                    <div>
                        <button type="button" id="submitMemberEducation" class="button-selected">저장</button>
                    </div>
                </div>
            </div>
        </div>
    </dialog>

    <!-- 보유기술 Modal -->
    <dialog id="modalMemberSkill"
        class="fixed left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 modal rounded-lg pt-6 pb-4 drop-shadow-lg w-200">
        <div class="modal-box  w-full flex flex-col max-h-[calc(100vh-80px)] space-y-4">
            <!-- 모달 상단부 -->
            <div>
                <button type="button"
                    class="btn-close-modal btn btn-sm btn-circle btn-ghost absolute right-8 top-6">✕</button>
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
                            <input type="text" name="skill_name" id="skill_name"
                                data-target-url="/api/member/skill/search"
                                data-search-type="skill_name"
                                data-result-name="fk_skill_no"
                                class="input-search w-full border-1 rounded-sm p-1" />
                            <input type="text" name="fk_skill_no" class="hidden" />
                        </li>
                    </ul>
                </form>
            </div>

            <!-- 모달 하단부 -->
            <div>
                <hr class="border-gray-200 mb-4">
                <div class="flex justify-end items-center px-4">
                    <div>
                        <button type="button" id="submitMemberSkill" class="button-selected">저장</button>
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
                <div class="pt-0! relative pb-4!">
                    <div class="w-full h-50 px-0 bg-gray-100">
                        <img src="${pageContext.request.contextPath}/resources/files/profile/${requestScope.memberVO.member_background_img}" class="w-full h-50 object-cover rounded-t-md"/>
                        <button type="button" class="button absolute top-4 right-4 w-10 h-10 rounded-full text-orange-500 hover:text-orange-600 flex justify-center text-center items-center bg-white text-md"><i class="fa-solid fa-camera"></i></button>
                    </div>
                    <div class="absolute top-22">
                        <button type="button" class="button"><img src="${pageContext.request.contextPath}/resources/files/profile/${requestScope.memberVO.member_profile}" class="w-40 h-40 rounded-full object-cover"/></button>
                    </div>
                    <c:if test="${requestScope.memberVO.member_profile == 'default/profile.png'}">
	                    <button type="button" class="button absolute top-50 left-33 w-12 h-12 rounded-full border-1 border-orange-500 text-orange-500 flex justify-center text-center items-center bg-white text-xl"><i class="fa-solid fa-plus"></i></button>
                    </c:if>
                    <div class="text-end text-xl py-2">
                        <button type="button" class="btn-transparent"><i class="fa-solid fa-pen"></i></button>
                    </div>

                    <div>
                        <div class="text-3xl font-bold">
                            ${requestScope.memberVO.member_name}
                        </div>
                        <div class="text-lg">
                            <c:if test="${not empty requestScope.memberVO.school_name}">
                                <div>${requestScope.memberVO.school_name} 학생</div>
                            </c:if>
                            <c:if test="${not empty requestScope.memberVO.member_career_company}">
                                <div>${requestScope.memberVO.member_career_company} 재직중</div>
                            </c:if>
                        </div>
                        <div class="space-x-2">
                            <span class="text-gray-500">${requestScope.memberVO.region_name}</span>
                            <span><button class="hover:underline text-orange-500 font-bold btn-open-modal"
                                data-target-modal="MemberContact">연락처</button>
                            </span>
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
                <div class="py-0!">
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
                <div class="space-y-0 pb-0!">
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
                <div class="pb-0!">
                    <div class="flex items-center">
                        <h1 class="h1 flex-1">경력</h1>
                        <%-- 로그인 본인 체크 --%>
                        <c:if test="${not empty sessionScope.loginuser && sessionScope.loginuser.member_id == requestScope.memberId}">
                            <button type="button" data-target-modal="MemberCareer"
                                class="btn-transparent btn-open-modal"><i class="fa-solid fa-plus"></i></button>
                            <button type="button" class="btn-transparent" onclick="location.href=ctxPath+'/member/profile/member-career/'+memberId">
                                <i class="fa-solid fa-pen"></i>
                            </button>
                        </c:if>
                    </div>

                    <ul id="memberCareerList" class="space-y-2">
                        <%-- 경력 목록 출력 --%>
                        <c:if test="${not empty requestScope.memberCareerVOList}">
                            <c:forEach var="item" items="${memberCareerVOList}" varStatus="status">
                            <c:if test="${status.count < 3}">
                                <li class="${(status.count < requestScope.memberCareerVOList.size() && status.count < 2)? 'border-b-1 border-gray-300 ':''}py-2 flex items-start">
                                    <a href="#" class="flex flex-1">
                                        <div>
                                            <c:if test="${not empty item.company_logo}">
                                                <img src="${pageContext.request.contextPath}/resources/files/${item.company_logo}" class="aspect-square w-15 object-cover" />
                                            </c:if>
                                            <c:if test="${empty item.company_logo}">
                                                <div class="aspect-square w-15 bg-gray-200 flex items-center justify-center"><i class="fa-solid fa-building text-2xl text-gray-500"></i></div>
                                            </c:if>
                                        </div>
                                        <div class="flex-1 ml-4">
                                            <div class="font-bold text-xl hover:underline">${item.job_name}</div>
                                            <div>${item.member_career_company}</div>
                                            <div class="text-gray-600">${item.member_career_startdate}${enddate}</div>
                                        </div>
                                    </a>
                                    <%-- 로그인 본인 체크 --%>
                                    <c:if test="${not empty sessionScope.loginuser && sessionScope.loginuser.member_id == requestScope.memberId}">
                                        <button type="button" data-target-modal="MemberCareer" data-target-no="${item.member_career_no}"
                                            class="btn-transparent btn-open-modal"><i
                                                class="fa-solid fa-pen"></i></button>
                                    </c:if>
                                </li>
                            </c:if>
                            </c:forEach>
                        </c:if>
                        <c:if test="${empty requestScope.memberCareerVOList}">
                            <li class="text-center text-lg py-2"><span class="block">조회된 경력 정보가 없습니다.</span>
                                <%-- 로그인 본인 체크 --%>
                                <c:if test="${not empty sessionScope.loginuser && sessionScope.loginuser.member_id == requestScope.memberId}">
                                    <button type="button" data-target-modal="MemberCareer"
                                        class="btn-open-modal btn-transparent px-3!"><i class="fa-solid fa-plus"></i>
                                    </button>
                                    <span class="font-bold -ml-1">버튼을 눌러 경력을 추가해보세요.</span>
                                </c:if>
                            </li>
                        </c:if>
                    </ul>
                    <c:if test="${not empty requestScope.memberCareerVOList and requestScope.memberCareerVOList.size() > 2}">
                        <div class="px-0">
                            <hr class="border-gray-300">
                            <button type="button" class="button-more"  onclick="location.href=ctxPath+'/member/profile/member-career/'+memberId">
                                경력 모두 보기 <i class="fa-solid fa-arrow-right"></i>
                            </button>
                        </div>
                    </c:if>
                </div>

                <!-- 학력 -->
                <div class="pb-0!">
                    <div class="flex items-center">
                        <h1 class="h1 flex-1">학력</h1>
                        <%-- 로그인 본인 체크 --%>
                        <c:if test="${not empty sessionScope.loginuser && sessionScope.loginuser.member_id == requestScope.memberId}">
                            <button type="button" data-target-modal="MemberEducation"
                                class="btn-open-modal btn-transparent"><i class="fa-solid fa-plus"></i></button>
                            <button type="button" class="btn-transparent" onclick="location.href=ctxPath+'/member/profile/member-education/'+memberId">
                                <i class="fa-solid fa-pen"></i>
                            </button>
                        </c:if>
                    </div>

                    <ul id="memberEducationList" class="space-y-2">
                        <%-- 학력 목록 출력 --%>
                        <c:if test="${not empty requestScope.memberEducationVOList}">
                            <c:forEach var="item" items="${memberEducationVOList}" varStatus="status">
                            <c:if test="${status.count < 3}">
                                <li class="${(status.count < requestScope.memberEducationVOList.size() && status.count < 2)? 'border-b-1 border-gray-300 ':''}py-2 flex items-start">
                                    <a href="#" class="flex flex-1">
                                        <div>
                                            <c:if test="${not empty item.school_logo}">
                                                <img src="${pageContext.request.contextPath}/resources/files/${item.school_logo}" class="aspect-square w-15 object-cover" />
                                            </c:if>
                                            <c:if test="${empty item.school_logo}">
                                                <div class="aspect-square w-15 bg-gray-200 flex items-center justify-center"><i class="fa-solid fa-school text-2xl text-gray-500"></i></div>
                                            </c:if>
                                        </div>
                                        <div class="flex-1 ml-4">
                                            <div class="font-bold text-xl hover:underline">${item.school_name}</div>
                                            <div>${item.major_name}</div>
                                            <div class="text-gray-600">${item.member_education_startdate} ~ ${item.member_education_enddate}</div>
                                            <div>학점: ${item.member_education_grade}</div>
                                        </div>
                                    </a>
                                    <%-- 로그인 본인 체크 --%>
                                    <c:if test="${not empty sessionScope.loginuser && sessionScope.loginuser.member_id == requestScope.memberId}">
                                        <button type="button" data-target-modal="MemberEducation" data-target-no="${item.member_education_no}"
                                            class="btn-open-modal btn-transparent"><i class="fa-solid fa-pen"></i></button>
                                    </c:if>
                                </li>
                            </c:if>
                            </c:forEach>
                        </c:if>
                        <c:if test="${empty requestScope.memberEducationVOList}">
                            <li class="text-center text-lg py-2"><span class="block">조회된 학력 정보가 없습니다.</span>
                                <%-- 로그인 본인 체크 --%>
                                <c:if test="${not empty sessionScope.loginuser && sessionScope.loginuser.member_id == requestScope.memberId}">
                                    <button type="button" data-target-modal="MemberEducation"
                                        class="btn-open-modal btn-transparent px-3!"><i class="fa-solid fa-plus"></i>
                                    </button>
                                    <span class="font-bold -ml-1">버튼을 눌러 학력을 추가해보세요.</span>
                                </c:if>
                            </li>
                        </c:if>
                    </ul>
                    <c:if test="${not empty requestScope.memberEducationVOList and requestScope.memberEducationVOList.size() > 2}">
                        <div class="px-0">
                            <hr class="border-gray-300">
                            <button type="button" class="button-more"  onclick="location.href=ctxPath+'/member/profile/member-education/'+memberId">
                                학력 모두 보기 <i class="fa-solid fa-arrow-right"></i>
                            </button>
                        </div>
                    </c:if>
                </div>

                <!-- 보유기술 -->
                <div class="pb-0!">
                    <div class="flex items-center">
                        <h1 class="h1 flex-1">보유기술</h1>
                        <%-- 로그인 본인 체크 --%>
                        <c:if test="${not empty sessionScope.loginuser && sessionScope.loginuser.member_id == requestScope.memberId}">
                            <button type="button" data-target-modal="MemberSkill"
                                class="btn-open-modal btn-transparent"><i class="fa-solid fa-plus"></i></button>
                            <button type="button" class="btn-transparent" onclick="location.href=ctxPath+'/member/profile/member-skill/'+memberId">
                                <i class="fa-solid fa-pen"></i>
                            </button>
                        </c:if>
                    </div>

                    <ul id="memberSkillList" class="space-y-2">
                        <%-- 보유기술 목록 출력 --%>
                        <c:if test="${not empty requestScope.memberSkillVOList}">
                            <c:forEach var="item" items="${memberSkillVOList}" varStatus="status">
                            <c:if test="${status.count < 3}">
                                <li class="${(status.count < requestScope.memberSkillVOList.size() && status.count < 2)? 'border-b-1 border-gray-300 ':''}py-2 flex items-start">
                                    <a href="#" class="flex-1">
                                        <div class="font-bold text-lg hover:underline">${item.skill_name}</div>
                                    </a>
                                    <%-- 로그인 본인 체크 --%>
                                    <c:if test="${not empty sessionScope.loginuser && sessionScope.loginuser.member_id == requestScope.memberId}">
                                        <button type="button" id="deleteMemberSkill"
                                            data-member_skill_no="${item.member_skill_no}"
                                            data-skill_name="${item.skill_name}"
                                            class="btn-transparent"><i class="fa-solid fa-xmark"></i></button>
                                    </c:if>
                                </li>
                            </c:if>
                            </c:forEach>
                        </c:if>
                        <c:if test="${empty requestScope.memberSkillVOList}">
                            <li class="text-center text-lg py-2"><span class="block">조회된 보유기술 정보가 없습니다.</span>
                                <%-- 로그인 본인 체크 --%>
                                <c:if test="${not empty sessionScope.loginuser && sessionScope.loginuser.member_id == requestScope.memberId}">
                                    <button type="button" data-target-modal="MemberSkill"
                                        class="btn-open-modal btn-transparent px-3!"><i class="fa-solid fa-plus"></i>
                                    </button>
                                    <span class="font-bold -ml-1">버튼을 눌러 보유기술을 추가해보세요.</span>
                                </c:if>
                            </li>
                        </c:if>
                    </ul>
                    <c:if test="${not empty requestScope.memberSkillVOList and requestScope.memberSkillVOList.size() > 2}">
                        <div class="px-0">
                            <hr class="border-gray-300">
                            <button type="button" class="button-more"  onclick="location.href=ctxPath+'/member/profile/member-skill/'+memberId">
                                보유기술 모두 보기 <i class="fa-solid fa-arrow-right"></i>
                            </button>
                        </div>
                    </c:if>
                </div>

                <!-- 관심분야 -->
                <%-- <div class="py-0!">
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
                </div> --%>
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