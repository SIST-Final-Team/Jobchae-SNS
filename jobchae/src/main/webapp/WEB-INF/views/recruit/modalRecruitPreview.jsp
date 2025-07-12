<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- Quill 에디터 --%>
<script src="https://cdn.jsdelivr.net/npm/quill@2.0.3/dist/quill.js"></script>
<link href="https://cdn.jsdelivr.net/npm/quill@2.0.3/dist/quill.snow.css" rel="stylesheet">

<script type="text/javascript">
$(document).ready(function () {
    const quillViewer = new Quill('.quill-viewer', {
        theme: 'snow',
        readOnly: true,
        modules: {
            toolbar: false
        }
    });
});
</script>

<dialog id="modalRecruitPreview"
    class="fixed left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 modal rounded-lg pt-6 pb-4 drop-shadow-lg w-200">
    <div class="modal-box w-full flex flex-col max-h-[calc(100vh-80px)] space-y-4">
        <!-- 모달 상단부 -->
        <div>
            <button type="button" class="btn-close-modal absolute aspect-square w-10 right-2 top-4">
                <i class="fa-solid fa-xmark text-xl"></i>
            </button>
            <h1 class="h1 px-6">채용공고 미리보기</h1>

            <hr class="border-gray-200 mt-4">
        </div>

        <!-- 모달 내용 -->
        <div class="space-y-4 overflow-auto min-h-80">
            <div class="text-gray-500 px-6 text-base/5">구직자에게 표시되는 채용공고 미리보기입니다. 회사 규모, 위치, 회원님의 JOB CHAE 프로필 생성 시기에 대한 정보 등이 포함됩니다. 지원자는 지원할 때 선별 질문에 답변하게 됩니다.</div>
            
            <div class="border-normal m-6 mt-4 p-4">
                
                <div>
                <%-- <c:if test="${not empty item.company_logo}">
                    <img src="${pageContext.request.contextPath}/resources/files/companyLogo/${item.company_logo}" class="aspect-square w-15 object-cover" />
                </c:if>
                <c:if test="${empty item.company_logo}"> --%>
                    <div class="aspect-square w-15 bg-gray-200 flex items-center justify-center"><i class="fa-solid fa-building text-2xl text-gray-500"></i></div>
                <%-- </c:if> --%>
                </div>
                <div class="text-xl font-bold mt-4">직종</div>
                <div class="flex space-x-2 text-gray-700">
                    <div>회사명</div>
                    <div>·</div>
                    <div>지역 (대면근무)</div>
                </div>

                <div class="text-gray-700 mt-4"><i class="fa-solid fa-briefcase"></i> 풀타임</div>

                <button type="button" class="button-disabled mt-4 text-base! py-2! px-6!">원클릭 지원</button>

                <div class="mt-4 block text-sm font-bold text-gray-700 mb-2">게시자:</div>
                <div class="flex items-center">
                    <img class="w-15 h-15 object-cover rounded-full mr-2"
                        src="${pageContext.request.contextPath}/resources/files/profile/${sessionScope.loginuser.member_profile}" />
                    <div class="flex-1">
                        <div class="font-bold text-[1.05rem]">${sessionScope.loginuser.member_name}</div>
                        <c:if test="${not empty sessionScope.loginuser.school_name}">
                            <div>${sessionScope.loginuser.school_name} 학생</div>
                        </c:if>
                        <c:if test="${not empty sessionScope.loginuser.member_career_company}">
                            <div>${sessionScope.loginuser.member_career_company} 재직중</div>
                        </c:if>
                    </div>
                </div>

                <div class="quill-viewer mt-4 text-[1.05rem]!">
                </div>
            </div>
        </div>

    </div>
</dialog>