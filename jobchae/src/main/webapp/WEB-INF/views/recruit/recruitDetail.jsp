<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/header/header.jsp" />

<%-- Quill 에디터 --%>
<link href="https://cdn.jsdelivr.net/npm/quill@2.0.3/dist/quill.snow.css" rel="stylesheet">

<script type="text/javascript">
$(document).ready(function() {

    // 필수 자격 질문이 없으면 숨기기
    if ($("#questionRequiredList").children().length == 0) {
        $("#questionRequiredDiv").hide();
    }
    // 우대 자격(필수가 아닌) 질문이 없으면 숨기기
    if ($("#questionNotRequiredList").children().length == 0) {
        $("#questionNotRequiredDiv").hide();
    }

    $("button.edit-step2").on("click", function() {
        location.href = "${pageContext.request.contextPath}/recruit/edit/${requestScope.recruitVO.recruit_no}/step2";
    });

    $("button.edit-step3").on("click", function() {
        location.href = "${pageContext.request.contextPath}/recruit/edit/${requestScope.recruitVO.recruit_no}/step3";
    });

    $("input[name='tabs']").on("change", function() {
        $(".center").hide();
        $(".center-"+$(this).attr("id")).show();
    });
    
    // 불합격 통보 이메일 체크/체크해제
    $("#recruit_auto_fail").on("change", function() {
        const isChecked = $(this).prop("checked");
        const recruitAutoFail = "${requestScope.recruitVO.recruit_auto_fail}";

        // 메시지 박스와 textarea 활성화 여부 설정
        $("#recruitAutoFailMessageDiv").toggle(isChecked);
        $("textarea[name='recruit_auto_fail_message']").prop("disabled", !isChecked);

        // 버튼 상태 설정
        const shouldEnableButton = (isChecked && recruitAutoFail === "0") || (!isChecked && recruitAutoFail === "1");

        $("#recruitUpdateSubmit")
            .toggleClass("button-selected", shouldEnableButton)
            .toggleClass("button-disabled", !shouldEnableButton);
    });
    
    // 불합격 통보 여부 체크하기
    if(${requestScope.recruitVO.recruit_auto_fail == "1"}) {
        $("input[name='recruit_auto_fail']").click();
    }

    // 불합격 통보 이메일 내용 수정시
    $("textarea[name='recruit_auto_fail_message']").on("input", function() {
        if($(this).val() != `${requestScope.recruitVO.recruit_auto_fail_message}`) {
            $("#recruitUpdateSubmit").removeClass("button-disabled").addClass("button-selected");
        }
        else {
            $("#recruitUpdateSubmit").removeClass("button-selected").addClass("button-disabled");
        }
    });

    // 수정 사항 저장 클릭
    $("#recruitUpdateSubmit").on("click", function() {
        
        const form = document.recruitUpdateForm;
        
        let $emptyElmt = null;

        $(".error:not(.hidden)").each((index, elmt) => {
            $(elmt).addClass("hidden");
        });

        const inputList = $(form).find(".required:not(input:checkbox)");
        for(let input of inputList) {
            if(!$(input).attr("disabled") && ($(input).val() == 0 || $(input).val().trim() == "")){
                $(input).next(".error").removeClass("hidden");
                $emptyElmt = $(input);
                break;
            }
        }

        if($emptyElmt != null) { // 입력하지 않은 input 태그가 존재한다면
            $emptyElmt.focus();
        }
        else { // 수정
            
            const data = $(form).serialize();

            $("#recruitUpdateSubmit").removeClass("button-selected").addClass("button-disabled");

            $.ajax({
                url: ctxPath + "/api/recruit/edit/${requestScope.recruitVO.recruit_no}",
                data: data,
                type: "put",
                dataType: "json",
                success: function (json) {
                    if(json.result == "1") {
                        alert("수정을 완료했습니다.");
                    }
                    else {
                        alert("수정을 실패했습니다.");
                    }
                },
                error: function (request, status, error) {
                    alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
                }
            });
        }
    });
});
</script>

<%-- TailWind 사용자 정의 CSS --%>
<jsp:include page="/WEB-INF/views/member/profileTailwind.jsp" />

    <!-- 상단 헤더 -->
    <div class="fixed left-0 pb-0 bg-white w-full z-99 drop-shadow-md">
        <div class="bg-white">

            <%-- 회사 정보 --%>
            <div class="flex space-x-2 xl:max-w-[1140px] m-auto py-4">
                <div>
                <%-- <c:if test="${not empty item.company_logo}">
                    <img src="${pageContext.request.contextPath}/resources/files/${item.company_logo}" class="aspect-square w-15 object-cover" />
                </c:if>
                <c:if test="${empty item.company_logo}"> --%>
                    <div class="aspect-square w-15 bg-gray-200 flex items-center justify-center"><i class="fa-solid fa-building text-2xl text-gray-500"></i></div>
                <%-- </c:if> --%>
                </div>
                <div class="flex-1 text-base/5">
                    <div class="font-bold">${requestScope.recruitVO.recruit_job_name}</div>
                    <div>${requestScope.recruitVO.recruit_company_name} |  ${requestScope.recruitVO.region_name}<span>
                        <c:if test='${requestScope.recruitVO.recruit_work_type == "1"}'>(대면근무)</c:if>
                        <c:if test='${requestScope.recruitVO.recruit_work_type == "2"}'>(대면재택혼합근무)</c:if>
                        <c:if test='${requestScope.recruitVO.recruit_work_type == "3"}'>(재택근무)</c:if>
                        </span>
                    </div>
                    <div class="text-gray-500">만든 날짜: ${requestScope.recruitVO.recruit_register_date}</div>
                </div>

                <div class="flex items-center gap-2">
                    <button type="button" class="button-orange">지원자 보기</button>
                    <button type="button" class="button-orange">채용공고 재등록</button>
                    <button type="button" class="btn-transparent w-10 h-10 relative"><i class="absolute left-1/2 top-1/2 transform -translate-y-1/2 -translate-x-1/2 fa-solid fa-ellipsis"></i></button>
                </div>
            </div>

            <hr class="border-gray-200">

            <!-- 탭 -->
            <div class="xl:max-w-[1140px] m-auto">
                <input type="radio" name="tabs" id="tab1" class="hidden peer/tab1" checked>
                <label class="inline-block cursor-pointer hover:bg-gray-100 border-white hover:border-gray-100 p-2 text-center peer-checked/tab1:text-orange-500 peer-checked/tab1:font-bold border-b-2 peer-checked/tab1:border-orange-500!" for="tab1">
                채용공고 정보
                </label>
                <input type="radio" name="tabs" id="tab2" class="hidden peer/tab2">
                <label class="inline-block cursor-pointer hover:bg-gray-100 border-white hover:border-gray-100 p-2 text-center peer-checked/tab2:text-orange-500 peer-checked/tab2:font-bold border-b-2 peer-checked/tab2:border-orange-500!" for="tab2">
                설정
                </label>
            </div>
        </div>
    </div>

    <!-- 본문 -->
    <div class="container m-auto mt-40 lg:grid lg:grid-cols-7 gap-6 xl:max-w-[1140px]">

        <!-- 중앙 본문 / 채용공고 정보 -->
        <div class="center center-tab1 lg:col-span-5 mb-4 lg:mb-5">
            <div class="border-board">

                <!-- 주요 업무 -->
                <div class="px-2! py-6!">
                    <div class="flex items-center">
                        <h1 class="h1 font-normal! flex-1">주요 업무</h1>
                        <%-- 주요 업무 수정(임시저장이 없으므로 필요 없는 기능) --%>
                        <%-- <c:if test="${not empty sessionScope.loginuser && sessionScope.loginuser.member_id == requestScope.recruitVO.fk_member_id}">
                            <button type="button"
                                class="btn-transparent edit-step2"><i class="fa-solid fa-pen"></i></button>
                        </c:if> --%>
                    </div>

                    <div class="md:grid md:grid-cols-4">
                        <%-- 주요 업무 설명 html --%>
                        <div class="md:col-span-3 pb-4">
                            <div class="ql-editor text-base! p-0!" contenteditable="false"><c:import url="/resources/files/recruit/${requestScope.recruitVO.recruit_explain_html}" charEncoding="UTF-8"/></div>
                        </div>

                        <%-- 고용 형태 --%>
                        <div class="md:col-span-1">
                            <div class="font-bold">고용 형태</div>
                            <div>
                                <c:if test='${requestScope.recruitVO.recruit_job_type == "1"}'>풀타임</c:if>
                                <c:if test='${requestScope.recruitVO.recruit_job_type == "2"}'>파트타임</c:if>
                                <c:if test='${requestScope.recruitVO.recruit_job_type == "3"}'>계약직</c:if>
                                <c:if test='${requestScope.recruitVO.recruit_job_type == "4"}'>임시직</c:if>
                                <c:if test='${requestScope.recruitVO.recruit_job_type == "5"}'>기타</c:if>
                                <c:if test='${requestScope.recruitVO.recruit_job_type == "6"}'>자원봉사</c:if>
                                <c:if test='${requestScope.recruitVO.recruit_job_type == "7"}'>인턴</c:if>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 선별 질문 -->
                <div class="px-2! py-6!">
                    <div class="flex items-center">
                        <h1 class="h1 font-normal! flex-1 pb-2">선별 질문</h1>
                        <%-- 선별질문 수정(임시저장이 없으므로 필요 없는 기능) --%>
                        <%-- <c:if test="${not empty sessionScope.loginuser && sessionScope.loginuser.member_id == requestScope.recruitVO.fk_member_id}">
                            <c:if test="${requestScope.recruitVO.questionVOList.size() > 0}">
                                <button type="button"
                                    class="btn-transparent edit-step3"><i class="fa-solid fa-pen"></i></button>
                            </c:if>

                            <c:if test="${requestScope.recruitVO.questionVOList.size() == 0}">
                                <button type="button"
                                    class="btn-transparent edit-step3"><i class="fa-solid fa-plus"></i></button>
                            </c:if>
                        </c:if> --%>
                    </div>

                    <div>
                    
                        <%-- 선별 질문이 없다면 --%>
                        <c:if test="${requestScope.recruitVO.questionVOList.size() == 0}">
                            <%-- <div>아직 선별 질문이 없습니다. 선별 질문을 입력해서 지원자를 쉽게 선별하세요.</div> --%>
                            <div>선별 질문이 없습니다.</div>
                        </c:if>
                        <%-- 필수 자격 --%>
                        <div id="questionRequiredDiv" class="pb-4">
                            <div class="font-bold">필수 자격</div>
                            <ul id="questionRequiredList" class="grid grid-cols-2 gap-x-8 gap-y-4">
                            <c:forEach var="item" items="${requestScope.recruitVO.questionVOList}" varStatus="status">
                                <c:if test='${item.question_required == "1"}'>
                                    <li class="col-span-1">
                                        <div>${item.question_query}</div>
                                        <div class="text-gray-500">모범 답안: ${item.question_correct}</div>
                                    </li>
                                </c:if>
                            </c:forEach>
                            </ul>
                        </div>

                        <%-- 우대 자격 --%>
                        <div id="questionNotRequiredDiv">
                            <div class="font-bold">우대 자격</div>
                            <ul id="questionNotRequiredList" class="grid grid-cols-2 gap-x-8 gap-y-4">
                            <c:forEach var="item" items="${requestScope.recruitVO.questionVOList}" varStatus="status">
                                <c:if test='${item.question_required != "1"}'>
                                    <li class="col-span-1">
                                        <div>${item.question_query}</div>
                                        <div class="text-gray-500">모범 답안: ${item.question_correct}</div>
                                    </li>
                                </c:if>
                            </c:forEach>
                            </ul>
                        </div>
                    </div>
                    
                </div>
            </div>
        </div>

        <!-- 중앙 본문 / 설정 -->
        <div class="center center-tab2 hidden lg:col-span-5 mb-4 lg:mb-5">
            <div class="border-rwd p-6">
                <h1 class="h1 font-normal!">적임자 자동 분류</h1>

                <form name="recruitUpdateForm">
                
                <%-- 자격 설정 --%>
                <div class="text-xl font-bold py-4 pb-2">자격 설정</div>
                <div class="w-full mb-4 flex items-center">
                    <input type="checkbox" id="recruit_auto_fail" name="recruit_auto_fail" class="text-sm accent-orange-600 opacity-60 mr-2" style="zoom: 1.5;" value="1">
                    <label for="recruit_auto_fail" class="text-sm font-medium text-gray-700">필수 자격을 갖추지 못한 지원자를 분류해서 불합격 통보를 보냅니다.</label>
                </div>

                <%-- 불합격 통보 이메일 --%>
                <div id="recruitAutoFailMessageDiv" class="pt-4 hidden">
                    <label for="recruit_auto_fail_message" class="block text-sm font-medium text-gray-700">미리보기 *</label>
                    <textarea name="recruit_auto_fail_message" id="recruit_auto_fail_message" maxlength="2000" class="mt-1 border border-gray-600 rounded-sm w-full h-30 required" >${requestScope.recruitVO.recruit_auto_fail_message}</textarea>
                    <span class="error text-red-500 text-sm mt-1 hidden">불합격 통보 이메일 미리보기는 필수항목입니다.</span>
                    <div class="text-end text-gray-600 text-sm"><span id="textCount">0</span>/2,000</div>
                </div>

                </form>

                <div class="text-right mt-4">
                    <button type="button" class="button-disabled" id="recruitUpdateSubmit">저장</button>
                </div>
            </div>
        </div>

        <!-- 우측 영역 -->
        <div class="right-side h-full relative mb-5 lg:col-span-2">
            <div class="sticky top-20 relative space-y-2">
                <div class="border-rwd p-6 gap-4">
                    <div class="h1">채용공고 실적</div>
                    <div class="grid grid-cols-2 my-4">
                        <div class="col-span-1">
                            <div class="text-lg">지원자</div>
                            <div class="text-3xl">0</div>
                        </div>
                        <div class="col-span-1">
                            <div class="text-lg">조회</div>
                            <div class="text-3xl">0</div>
                        </div>
                    </div>
                </div>
                <div class="border-rwd p-6 flex gap-4">
                    <div>
                        <div class="aspect-square w-14 bg-gray-200 flex items-center justify-center"><i class="fa-solid fa-briefcase text-2xl text-gray-500"></i></div>
                    </div>
                    <div class="flex-1">
                        <div class="font-bold text-lg mb-2">다른 역할도 채용 중이세요?</div>
                        <button type="button" class="button-gray text-[0.95rem]/5! py-1!" onclick="location.href='${pageContext.request.contextPath}/recruit/add/step1'">새 채용공고 등록하기</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>