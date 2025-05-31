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

    <title>채용공고 올리기 - JOB CHAE</title>

    <script type="text/javascript">
    let autocompleteID = 0; // 자동완성 위한 id
    const ctxPath = "${pageContext.request.contextPath}";
$(document).ready(function() {

    // 모달 열기
    $(document).on("click", ".btn-open-modal", function () {
        openModal(this);
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

    // 질문 삭제 버튼(X)을 클릭했을 때
    $(document).on("click", "button.question-delete", function() {
        let target = $(this).data("target");
        if(target != undefined) {
            let $button = $("button."+target.replace("question-", ""));
            $button.removeClass("button-disabled").addClass("button-gray");
            $button.html($button.html().replace("fa-check", "fa-plus"));
        }
        $(this).parent().parent().remove();
    });

    // 응답 유형을 변경했을 때
    $(document).on("input", "select[name='question_type']", function() {
        if($(this).val() == "1") { // 응답 유형: 네/아니오
            questionCorrectHtml = `
                            <div class="flex-1">
                                <label class="question-correct-label block text-sm font-medium text-gray-700">모범 답안:</label>
                                <select name="question_correct" class="mt-1 p-2 border border-gray-600 rounded-sm max-w-50 required">
                                    <option value="1">네</option>
                                    <option value="2">아니요</option>
                                </select>
                            </div>`;
            $(this).parent().parent().find(".question-correct-div").html(questionCorrectHtml);
            console.log($(this).parent().parent().find(".question-correct-div"));
        }
        else if($(this).val() == "2") { // 응답 유형: 숫자
            questionCorrectHtml = `
                            <div class="flex-1">
                                <label class="block text-sm font-medium text-gray-700">모범 답안(최소):</label>
                                <input type="number" name="question_correct" class="mt-1 py-2 border border-gray-600 rounded-sm max-w-50 required"
                                    max="99" min="0" value="1" />
                            </div>`;
            $(this).parent().parent().find(".question-correct-div").html(questionCorrectHtml);
        }
        else if($(this).val() == "3") { // 응답 유형: 글자
            $(this).parent().parent().find(".question-correct-div").html('');
        }
    });

    // 모범답안 숫자일 때 값이 없으면 0으로 변경
    $(document).on("input", "input[type='number'][name='question_correct']", function() {
        if(this.value == "") {
            this.value = 0;
        }
    });

    // 질문 추가 버튼 클릭시
    $(document).on("click", ".add-question.button-gray", function() {
        console.log($("#questionList").children().length);

        if($("#questionList").children().length >= 30) {
            alert("최대 질문 개수는 30개 입니다.");
            return;
        }

        let questionType = $(this).data("question-type");

        let questionQuery = "";
        let subqueryHtml = "";
        let answerType = "yes"; // "yes", "number", "text"

        switch(questionType) {
            case "degree": // 학력
                questionQuery = "다음 학위를 취득하셨나요? : [학위]";
                subqueryHtml = `
                            <div class="flex-1">
                                <label class="block text-sm font-medium text-gray-700 mt-4">학위 *</label>
                                <input type="text" maxlength="15" class="question_subquery mt-1 p-2 border border-gray-600 rounded-sm md:max-w-50 required w-full" placeholder="학위" />
                                <span class="error block text-red-500 text-sm mt-1 hidden">학위는 필수 입력사항입니다.</span>
                            </div>`;
                $(this).removeClass("button-gray").addClass("button-disabled");
                $(this).html($(this).html().replace("fa-plus", "fa-check"));
            break;

            case "bgCheck": // 신원 조회
                questionQuery = "현지 법률 및 규정에 따라 신원 조회를 진행할 수 있습니다. 이에 동의하십니까?";
                $(this).removeClass("button-gray").addClass("button-disabled");
                $(this).html($(this).html().replace("fa-plus", "fa-check"));
            break;

            case "driver": // 운전면허증
                questionQuery = "유효한 운전면허증을 소지하고 계십니까?";
                $(this).removeClass("button-gray").addClass("button-disabled");
                $(this).html($(this).html().replace("fa-plus", "fa-check"));
            break;

            case "drug": // 약물 검사
                questionQuery = "현지 법률 및 규정에 따라 약물 검사를 진행할 수 있습니다. 이에 동의하십니까?";
                $(this).removeClass("button-gray").addClass("button-disabled");
                $(this).html($(this).html().replace("fa-plus", "fa-check"));
            break;

            case "skill": // 보유기술 관련 경력
                questionQuery = "[보유기술] 관련 업무 경험이 몇 년 있으십니까?";
                subqueryHtml = `
                            <div class="flex-1">
                                <label class="block text-sm font-medium text-gray-700 mt-4">보유기술 *</label>
                                <input type="text" id="skill\${++autocompleteID}"
                                    placeholder="예: 스프링"
                                    autocomplete="off"
                                    data-target-url="/api/member/skill/search"
                                    data-search-type="skill_name"
                                    class="question_subquery input-search mt-1 p-2 border border-gray-600 rounded-sm md:max-w-50 required w-full"
                                    maxlength="50" />
                                <span class="error block text-red-500 text-sm mt-1 hidden">보유기술은 필수 입력사항입니다.</span>
                            </div>`;
                answerType = "number";
            break;

            case "hybrid": // 하이브리드 근무
                questionQuery = "하이브리드 근무 환경에서 일하는 데 문제가 없으십니까?";
                $(this).removeClass("button-gray").addClass("button-disabled");
                $(this).html($(this).html().replace("fa-plus", "fa-check"));
            break;

            case "job": // 직종 경험
                questionQuery = "현재 [직종] 분야에서 몇 년의 경력이 있으십니까?";
                subqueryHtml = `
                            <div class="flex-1">
                                <label class="block text-sm font-medium text-gray-700 mt-4">직종 *</label>
                                <input type="text" id="job\${++autocompleteID}"
                                    placeholder="직종"
                                    autocomplete="off"
                                    data-target-url="/api/member/job/search"
                                    data-search-type="job_name"
                                    class="question_subquery input-search mt-1 p-2 border border-gray-600 rounded-sm md:max-w-50 required w-full"
                                    maxlength="50" />
                                <span class="error block text-red-500 text-sm mt-1 hidden">직종은 필수 입력사항입니다.</span>
                            </div>`;
                answerType = "number";
            break;

            case "location": // 근무 위치
                questionQuery = "해당 근무지까지 출퇴근하는 데 문제가 없으십니까?";
                $(this).removeClass("button-gray").addClass("button-disabled");
                $(this).html($(this).html().replace("fa-plus", "fa-check"));
            break;

            case "manual": // 직접 쓴 질문
                questionQuery = "";
            break;

            default:

            break;
        }

        let answerHtml = ``;
        if(answerType == "yes") {
            answerHtml = `
                            <div class="flex-1">
                                <label class="block text-sm font-medium text-gray-700 mt-4">모범 답안:</label>
                                <input type="text" name="question_correct" class="outline-0 mt-1 py-2 md:max-w-30 required w-full"
                                    value="네" readonly />
                                <input type="hidden" name="question_type" value="1"/>
                            </div>`;
        }
        else if(answerType == "number") {
            answerHtml = `
                            <div class="flex-1">
                                <label class="block text-sm font-medium text-gray-700 mt-4">모범 답안(최소):</label>
                                <input type="number" name="question_correct" class="mt-1 py-2 border border-gray-600 rounded-sm md:max-w-50 required w-full"
                                    max="99" min="0" value="1" />
                                <input type="hidden" name="question_type" value="2"/>
                            </div>`;
        }

        if(questionQuery != "") {
            let questionHtml = `
                <li class="border-normal question-\${questionType}">
                    <%-- 질문 헤더 --%>
                    <div class="flex bg-gray-100 font-bold px-3 py-2 rounded-t-lg">
                        <div class="flex-1">
                            \${questionQuery}
                        </div>
                        <input type="hidden" class="w-full outline-0" name="question_query" value="\${questionQuery}" readonly />

                        <button type="button" data-target="question-\${questionType}"
                            class="question-delete hover:bg-gray-200 rounded-full aspect-square w-6 -mr-1 duration-100"><i class="fa-solid fa-xmark text-lg"></i></button>
                    </div>
                    
                    <%-- 질문 작성 폼 --%>
                    <div class="px-3">
                        
                        <div class="md:flex pt-2 pb-3 space-x-3">

                            \${subqueryHtml}
                            \${answerHtml}
                            <div class="mt-5 flex items-center">
                                <input type="checkbox" id="question_required" name="question_required" value="1" class="text-sm accent-orange-600 opacity-60 mr-2 md:-mb-7" style="zoom: 1.5;"/>
                                <label for="question_required" class="text-sm font-medium text-gray-700 md:-mb-10">필수 질문</label>
                            </div>
                        </div>
                    </div>
                </li>`;

            $("#questionList").append(questionHtml);
        }
        else {
            let questionHtml = `
                <li class="border-normal">
                    <%-- 질문 헤더 --%>
                    <div class="flex bg-gray-100 font-bold px-3 py-2 rounded-t-lg">
                        <div class="flex-1">
                            직접 선별 질문을 만들어 보세요.
                        </div>

                        <button type="button"
                            class="question-delete hover:bg-gray-200 rounded-full aspect-square w-6 -mr-1 duration-100"><i class="fa-solid fa-xmark text-lg"></i></button>
                    </div>
                    
                    <%-- 질문 작성 폼 --%>
                    <div class="px-3">
                        <label for="questionQuery" class="block text-sm font-medium text-gray-700 pt-2">질문 *</label>
                        <textarea name="question_query" id="questionQuery" maxlength="200" class="mt-1 p-2 border border-gray-600 rounded-sm w-full required" placeholder='"개인 디바이스를 가져오시겠어요?" 같은 질문을 던져보세요.' ></textarea>
                        <div class="text-end text-gray-600 text-sm"><span id="textCount">0</span>/200</div>
                        
                        <div class="md:flex pb-3">
                            <div class="flex-1">
                                <label class="block text-sm font-medium text-gray-700 mt-4">응답 유형:</label>
                                <select name="question_type" class="mt-1 p-2 border border-gray-600 rounded-sm md:max-w-50 required w-full">
                                    <option value="1">네/아니요</option>
                                    <option value="2">숫자</option>
                                    <%-- <option value="3">글자</option> --%>
                                </select>
                            </div>
                            <div class="question-correct-div flex-1">
                                <label class="block text-sm font-medium text-gray-700 mt-4">모범 답안:</label>
                                <select name="question_correct" class="mt-1 p-2 border border-gray-600 rounded-sm md:max-w-50 required w-full">
                                    <option>네</option>
                                    <option>아니요</option>
                                </select>
                            </div>
                            <div class="mt-5 flex items-center">
                                <input type="checkbox" id="question_required" name="question_required" value="1" class="text-sm accent-orange-600 opacity-60 mr-2 md:-mb-7" style="zoom: 1.5;"/>
                                <label for="question_required" class="text-sm font-medium text-gray-700 md:-mb-10">필수 질문</label>
                            </div>
                        </div>
                    </div>
                </li>`;

            $("#questionList").append(questionHtml);
        }

    });

    $(".add-question.degree").click(); // 학위 기본 체크

    // 불합격 통보 이메일 체크/체크해제
    $("#recruit_auto_fail").on("change", function() {
        if($(this).prop("checked") == true) {
            $("#recruitAutoFailMessageDiv").show();
            $("textarea[name='recruit_auto_fail_message']").attr("disabled", false);
        }
        else {
            $("#recruitAutoFailMessageDiv").hide();
            $("textarea[name='recruit_auto_fail_message']").attr("disabled", true);
        }
    });

    // 폼 제출
    $("#submitRecruitStep3").on("click", function() {
        const form = document.recruitAddStep3Form;

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
        else { // 등록

            // 학력, 보유기술, 직종을 질문 내용에 넣기
            $("input.question_subquery").each((index, item) => {
                const subquery = $(item).val();

                const $input_question_query = $(item).parent().parent().parent().parent().find("input[name='question_query']");
                // 원래 질문 input 태그

                const result = $input_question_query.val().replace(/\[(.*?)\]/g, (match, p1) => {
                    return subquery;
                });

                $input_question_query.val(result);

                // console.log($input_question_query.val());
            });

            // 질문 목록의 이름을 다음과 같은 형식으로 변환
            // name="questionList[0].question_query"
            $("#questionList").children().each((index, element) => {
                $(element).find("input").each((i, elmt) => {
                    const name = "questionVOList["+index+"]." + $(elmt).attr("name");
                    $(elmt).attr("name", name);
                });
                $(element).find("textarea").each((i, elmt) => {
                    const name = "questionVOList["+index+"]." + $(elmt).attr("name");
                    $(elmt).attr("name", name);
                });
                $(element).find("select").each((i, elmt) => {
                    const name = "questionVOList["+index+"]." + $(elmt).attr("name");
                    $(elmt).attr("name", name);
                });
            });

            form.submit(); // 제출
        }
    });
});

// 미리보기 모달 띄우기
function openModal(btnEl) {
    const btnId = $(btnEl).attr("id");
    const targetModal = $(btnEl).data("target-modal");

    const modalId = "#modal" + targetModal;
    const rect = btnEl.getBoundingClientRect();
    $(modalId)[0].showModal();
    $(".quill-viewer .ql-editor").html($("textarea[name='recruit_explain']").text());
}
    </script>

    <%-- 자동완성 위한 js --%>
    <script src="${pageContext.request.contextPath}/js/recruit/recruitAddStep1.js"></script>

</head>
<body>

    <!-- 헤더 -->
	<jsp:include page="/WEB-INF/views/common/headerBeforeLogin.jsp" />

    <!-- 미리보기 Modal -->
    <jsp:include page="/WEB-INF/views/recruit/modalRecruitPreview.jsp" />

    <!-- 본문 -->
    <div class="container m-auto mt-22 lg:grid lg:grid-cols-4 gap-6 xl:max-w-[1140px]">

        <!-- 중앙 본문 -->
        <div class="center lg:col-span-3 mb-5 scroll-mt-22 border-rwd">

            <div class="text-xl font-bold p-4 pb-2">3/3: 우수 지원자 받기</div>
            <hr class="border-gray-300">
            
            <div class="text-gray-500 p-4 pb-0 text-sm">* 필수</div>

            <form name="recruitAddStep3Form" action="${pageContext.request.contextPath}/recruit/add/complete" method="post">

            <%-- 지원자 모집 --%>
            <div class="text-xl font-bold p-4 pb-2">지원자 모집</div>
            <div class="w-full mb-4 px-4">
                <label for="recruit_email" class="block text-sm font-medium text-gray-700">이메일 주소 *</label>
                <input type="email" name="recruit_email" id="recruit_email" maxlength="50" class="mt-1 p-2 border border-gray-600 rounded-sm w-full required" placeholder="example@example.com" />
                <div class="error hidden text-red-500 text-sm mt-1">이메일 주소는 필수 입력사항입니다.</div>
            </div>

            <%-- 선별 질문 --%>
            <div class="text-xl font-bold p-4 pb-0">선별 질문</div>
            <div class="text-sm p-4 pt-0 text-gray-700">질문은 3개 이상 등록하는 것이 좋습니다. 지원자는 각 질문에 답해야 합니다.</div>
            <ul id="questionList" class="px-4 space-y-4">
                <%-- 질문 목록 --%>
            </ul>

            <div class="text-sm p-4 pb-2 text-gray-700">선별 질문 등록:</div>
            <div class="px-4 space-y-2 space-x-1">
                <button class="add-question button-gray text-base! degree" data-question-type="degree" type="button"><i class="fa-solid fa-plus"></i> 학력</button>
                <button class="add-question button-gray text-base! bgCheck" data-question-type="bgCheck" type="button"><i class="fa-solid fa-plus"></i> 신원 조회</button>
                <button class="add-question button-gray text-base! driver" data-question-type="driver" type="button"><i class="fa-solid fa-plus"></i> 운전면허증</button>
                <button class="add-question button-gray text-base! drug" data-question-type="drug" type="button"><i class="fa-solid fa-plus"></i> 약물 검사</button>
                <button class="add-question button-gray text-base! skill" data-question-type="skill" type="button"><i class="fa-solid fa-plus"></i> 보유기술 관련 경력</button>
                <button class="add-question button-gray text-base! hybrid" data-question-type="hybrid" type="button"><i class="fa-solid fa-plus"></i> 하이브리드 근무</button>
                <button class="add-question button-gray text-base! job" data-question-type="job" type="button"><i class="fa-solid fa-plus"></i> 직종 경험</button>
                <button class="add-question button-gray text-base! location" data-question-type="location" type="button"><i class="fa-solid fa-plus"></i> 근무 위치</button>
                <button class="add-question button-gray text-base! manual" data-question-type="manual" type="button"><i class="fa-solid fa-plus"></i> 직접 쓴 질문</button>
            </div>

            <%-- 자격 설정 --%>
            <div class="text-xl font-bold p-4 pb-2">자격 설정</div>
            <div class="w-full mb-4 px-4 flex items-center">
                <input type="checkbox" id="recruit_auto_fail" name="recruit_auto_fail" class="text-sm accent-orange-600 opacity-60 mr-2" style="zoom: 1.5;" value="1" checked>
                <label for="recruit_auto_fail" class="text-sm font-medium text-gray-700">필수 자격을 갖추지 못한 지원자를 분류해서 불합격 통보를 보냅니다.</label>
            </div>

            <%-- 불합격 통보 이메일 --%>
            <div id="recruitAutoFailMessageDiv" class="p-4">
                <label for="recruit_auto_fail_message" class="block text-sm font-medium text-gray-700">미리보기 *</label>
                <textarea name="recruit_auto_fail_message" id="recruit_auto_fail_message" maxlength="2000" class="mt-1 border border-gray-600 rounded-sm w-full h-30 required" >${requestScope.recruitVO.company_name} ${requestScope.recruitVO.recruit_job_name}에 지원해 주셔서 감사합니다. 아쉽지만, 회원님을 이 자리의 채용에 더 이상 고려하지 않기로 결정했습니다. ${requestScope.recruitVO.company_name}에 관심을 가져주셔서 다시 한번 감사드립니다.

감사합니다.
${requestScope.recruitVO.company_name}</textarea>
                <span class="error text-red-500 text-sm mt-1 hidden">불합격 통보 이메일 미리보기는 필수항목입니다.</span>
                <div class="text-end text-gray-600 text-sm"><span id="textCount">0</span>/2,000</div>
            </div>

            <%-- 이전 폼 내용 --%>
            <input type="hidden" name="fk_region_no" value="${requestScope.recruitVO.fk_region_no}"/>
            <input type="hidden" name="fk_company_no" value="${requestScope.recruitVO.fk_company_no}"/>
            <textarea class="hidden" name="recruit_explain">${requestScope.recruitVO.recruit_explain}</textarea>
            <input type="hidden" name="recruit_job_name" value="${requestScope.recruitVO.recruit_job_name}"/>
            <input type="hidden" name="company_name" value="${requestScope.recruitVO.company_name}"/>
            <input type="hidden" name="recruit_work_type" value="${requestScope.recruitVO.recruit_work_type}"/>
            <input type="hidden" name="recruit_job_type" value="${requestScope.recruitVO.recruit_job_type}"/>

            </form>

            <hr class="border-gray-300">

            <%-- 미리보기, 뒤로, 채용공고 등록 --%>
            <div class="flex p-4 space-x-2">
                <button class="button-board-action w-auto! text-orange-500 px-2 hover:bg-orange-50! btn-open-modal" type="button" data-target-modal="RecruitPreview">미리보기</button>
                <div class="flex-1"></div>
                <button class="button-gray text-base!" type="button">뒤로</button>
                <button id="submitRecruitStep3" class="button-selected text-base!" type="button">채용공고 등록</button>
            </div>
        </div>

        <!-- 우측 -->
        <div class="right-side lg:col-span-1 h-full relative">
            <div class="sticky top-20 relative space-y-2">
                <div class="border-rwd p-4 flex space-x-2">
                    <div>
                    <%-- <c:if test="${not empty item.company_logo}">
                        <img src="${pageContext.request.contextPath}/resources/files/companyLogo/${item.company_logo}" class="aspect-square w-15 object-cover" />
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
                        <p class="font-bold">선별 질문은 왜 사용하나요?</p>
                        <p>채용공고는 해당 요건을 만족하는 사람들에게 집중 표시되고, 지원자가 선별 질문을 통과하면 회원님은 알림을 받습니다.</p>
                        <p><br></p>
                        <p class="font-bold">내가 채용 중이라는 점을 인맥들이 알게 되나요?</p>
                        <p>채용공고를 올리면 채용공고가 최대한 널리 노출될 수 있도록 회원들의 인맥들에게 채용공고가 통보됩니다. 인맥들은 이 채용공고를 각자 공유해서 채용공고의 노출을 더욱 증가시킬 수 있습니다.</p>
                        <p><br></p>
                        <p class="font-bold">지원자가 나와 내 채용공고에 대해 어떤 정보를 볼 수 있나요?</p>
                        <p>채용공고를 올리면 회사 규모, 위치, JOB CHAE 프로필을 만든 시기에 대한 정보 등을 공유하는 데 동의하게 됩니다.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>

</html>