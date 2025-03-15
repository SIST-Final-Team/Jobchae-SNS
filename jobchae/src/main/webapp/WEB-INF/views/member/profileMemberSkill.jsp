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
    // 한 회원의 보유기술 목록 조회
    getMemberSkillListByMemberId(memberId);
</script>

<style>
    dialog.dropdown::backdrop {
        background: transparent;
    }
</style>
  
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
                            <input type="text" name="skill_name" id="skill_name" placeholder="보유기술 입력"
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

                <!-- 보유기술 -->
                <div>
                    <div class="flex items-center">
                        <button type="button" class="back btn-transparent"><i
                                class="fa-solid fa-arrow-left-long"></i></button>
                        <h1 class="h1 flex-1">보유기술</h1>
                        <%-- 로그인 본인 체크 --%>
                        <c:if test="${not empty sessionScope.loginuser && sessionScope.loginuser.member_id == requestScope.memberId}">
                            <button type="button" data-target-modal="MemberSkill"
                                class="btn-transparent btn-open-modal"><i class="fa-solid fa-plus"></i></button>
                        </c:if>
                    </div>

                    <ul id="memberSkillList" class="space-y-2">
                        <%-- 보유기술 목록 --%>
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