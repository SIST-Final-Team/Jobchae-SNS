<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Optional JavaScript -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>

    <!-- TailWind Script -->
    <script src="${pageContext.request.contextPath}/js/tailwind.js"></script>
    
    <%-- TailWind 사용자 정의 CSS --%>
    <jsp:include page="/WEB-INF/views/member/profileTailwind.jsp" />

    <!-- Font Awesome CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <%-- Quill 에디터 --%>
    <script src="https://cdn.jsdelivr.net/npm/quill@2.0.3/dist/quill.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/quill@2.0.3/dist/quill.snow.css" rel="stylesheet">

    <title>채용공고 올리기 - JOB CHAE</title>

    <script>
    let quill;
    const toolbarOptions = [
        ['bold', 'italic'],
        [{ 'list': 'bullet' }, { 'list': 'ordered'}]
    ];
    $(document).ready(function () {
        quill = new Quill('#editor', {
            modules: {
                toolbar: toolbarOptions
            },
            theme: 'snow',
            placeholder: '역할 설명 입력'
        });

        // 다음 버튼 클릭시 폼 제출
        $("#submitRecruitStep2").on("click", function() {
            const form = document.recruitAddStep2Form;

            if($("#editor .ql-editor.ql-blank").length > 0) { // 입력하지 않은 input 태그가 존재한다면
                $(".error").show();
                $("#editor .ql-editor.ql-blank").focus();
            }
            else { // 등록
                let recruit_explain = quill.root.innerHTML;
                $("textarea[name='recruit_explain']").val(recruit_explain);
                
                form.submit();
            }
        });

        // 모달 열기
        $(document).on("click", ".btn-open-modal", function () {
            openModal(this);
        });

        // 취소 버튼 또는 X 버튼으로 모달 닫기
        $(".btn-close-modal").on("click", function (e) {
            dialog = $(this).parent().parent().parent()[0];
            $(dialog).removeClass("animate-slideDown"); // 열리는 애니메이션 제거
            $(dialog).addClass("animate-slideUp"); // 닫히는 애니메이션 추가

            // 애니메이션이 끝난 후 모달 닫기
            setTimeout(() => {
                dialog.close();
                $(dialog).removeClass("animate-slideUp"); // 닫히는 애니메이션 제거
                $(dialog).addClass("animate-slideDown"); // 열리는 애니메이션 추가
            }, 300);
        });
    });

    
// 미리보기 모달 띄우기
function openModal(btnEl) {
    const btnId = $(btnEl).attr("id");
    const targetModal = $(btnEl).data("target-modal");

    const modalId = "#modal" + targetModal;
    const rect = btnEl.getBoundingClientRect();
    $(modalId)[0].showModal();
    $(".quill-viewer .ql-editor").html(quill.root.innerHTML);
}
    </script>
</head>
<body>

    <!-- 헤더 -->
	<jsp:include page="/WEB-INF/views/common/headerBeforeLogin.jsp" />

    <!-- 미리보기 Modal -->
    <jsp:include page="/WEB-INF/views/recruit/modalRecruitPreview.jsp" />

    <!-- 본문 -->
    <div class="container m-auto mt-22 lg:grid lg:grid-cols-4 gap-6 xl:max-w-[1140px]">

        <!-- 중앙 본문 -->
        <div class="center lg:col-span-3 mb-4 lg:mb-5 scroll-mt-22 border-rwd">
            
            <form name="recruitAddStep2Form" action="${pageContext.request.contextPath}/recruit/add/step3" method="post">

            <div class="text-xl font-bold p-4 pb-2">2/3: 역할 설명</div>
            <hr class="border-gray-300">
            
            <div class="text-gray-500 p-4 pb-0 text-sm">* 필수</div>

            <div class="text-xl font-bold p-4 pb-2">설명 *</div>
            <div class="px-4">
                <div id="editor" class="h-80!">
                </div>
            </div>
            <div class="text-end text-gray-600 px-4 pb-8 text-sm"><span id="textCount"></span>/10,000</div>
            
            <span class="error text-red-500 text-sm mt-1 hidden">역할 설명은 필수 입력사항입니다.</span>

            <%-- 역할 설명 폼 제출용 --%>
            <textarea name="recruit_explain" class="hidden"></textarea>

            <%-- 이전 폼 내용 --%>
            <input type="hidden" name="fk_region_no" value="${requestScope.recruitVO.fk_region_no}"/>
            <input type="hidden" name="recruit_job_name" value="${requestScope.recruitVO.recruit_job_name}"/>
            <input type="hidden" name="recruit_company_name" value="${requestScope.recruitVO.recruit_company_name}"/>
            <input type="hidden" name="recruit_work_type" value="${requestScope.recruitVO.recruit_work_type}"/>
            <input type="hidden" name="recruit_job_type" value="${requestScope.recruitVO.recruit_job_type}"/>
            </form>

            <hr class="border-gray-300">

            <%-- 미리보기, 뒤로, 다음 --%>
            <div class="flex p-4 space-x-2">
                <button class="button-board-action w-auto! text-orange-500 px-2 hover:bg-orange-50! btn-open-modal" data-target-modal="RecruitPreview" type="button">미리보기</button>
                <div class="flex-1"></div>
                <button class="button-gray text-base!" type="button">뒤로</button>
                <button id="submitRecruitStep2" class="button-selected text-base!" type="button">다음</button>
            </div>
        </div>

        <!-- 우측 -->
        <div class="right-side h-full relative mb-5 lg:col-span-1">
            <div class="sticky top-20 relative space-y-2">
                <div class="border-rwd p-4 flex space-x-2">
                    <div>
                    <%-- <c:if test="${not empty item.company_logo}">
                        <img src="${pageContext.request.contextPath}/resources/files/${item.company_logo}" class="aspect-square w-15 object-cover" />
                    </c:if>
                    <c:if test="${empty item.company_logo}"> --%>
                        <div class="aspect-square w-15 bg-gray-200 flex items-center justify-center"><i class="fa-solid fa-building text-2xl text-gray-500"></i></div>
                    <%-- </c:if> --%>
                    </div>
                    <div class="flex-1 text-base/5">
                        <div class="font-bold">직종</div>
                        <div>회사명</div>
                        <div class="text-gray-500">지역 (대면근무)</div>
                    </div>
                </div>
                <div class="border-rwd p-4">
                    <div class="text-green-700 text-xl pb-4">
                        <i class="fa-regular fa-lightbulb"></i>
                    </div>
                    <div class="text-gray-500 text-[0.95rem]/5">
                        <p class="font-bold">딱 맞는 인재 공략하기</p>
                        <p>채용공고 설명을 포함하고 필수 보유기술을 등록하여 기준에 맞는 구직자를 공략하세요.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>

</html>