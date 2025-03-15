<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/header/header.jsp" />

<%-- TailWind 사용자 정의 CSS --%>
<jsp:include page="/WEB-INF/views/member/profileTailwind.jsp" />

<script type="text/javascript">
    const ctxPath = '${pageContext.request.contextPath}';
    const memberId = '${requestScope.memberId}'; // 조회 대상 회원 아이디
    const reload = false; // 등록, 수정, 삭제 후 페이지 새로고침 여부
    const isMyProfile = ${not empty sessionScope.loginuser && sessionScope.loginuser.member_id == requestScope.memberId}; // 본인의 프로필인지 여부
</script>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/member/profileMore.js"></script>

<script type="text/javascript">
    // 한 회원의 학력 목록 조회
    getMemberEducationListByMemberId(memberId);
</script>
    

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

    <!-- 본문 -->
    <div class="container m-auto grid grid-cols-10 lg:grid-cols-14 gap-6 xl:max-w-[1140px]">

        <!-- 중앙 본문 -->
        <div class="center col-span-14 md:col-span-10 space-y-2 my-5">
            <div class="scroll-mt-22 border-board">

                <!-- 학력 -->
                <div>
                    <div class="flex items-center">
                        <button type="button" class="back btn-transparent"><i
                                class="fa-solid fa-arrow-left-long"></i></button>
                        <h1 class="h1 flex-1">학력</h1>
                        <%-- 로그인 본인 체크 --%>
                        <c:if test="${not empty sessionScope.loginuser && sessionScope.loginuser.member_id == requestScope.memberId}">
                            <button type="button" data-target-modal="MemberEducation"
                                class="btn-transparent btn-open-modal"><i class="fa-solid fa-plus"></i></button>
                        </c:if>
                    </div>

                    <ul id="memberEducationList" class="space-y-2">
                        <%-- 학력 목록 --%>
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
                    <img src="7.png" />
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