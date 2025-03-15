<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/header/header.jsp" />

<%-- TailWind 사용자 정의 CSS --%>
<jsp:include page="/WEB-INF/views/member/profileTailwind.jsp" />

<jsp:include page="/WEB-INF/views/member/profileTailwind.jsp" />

<script type="text/javascript">
    const ctxPath = '${pageContext.request.contextPath}';
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

    <!-- 본문 -->
    <div class="container m-auto grid grid-cols-10 lg:grid-cols-14 gap-6 xl:max-w-[1140px]">

        <!-- 중앙 본문 -->
        <div class="center col-span-14 md:col-span-10 space-y-2 my-5">
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