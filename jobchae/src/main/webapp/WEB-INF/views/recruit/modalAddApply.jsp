<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">
let step = 1;
let progress = 0;
let totalStep = 3;
$(document).ready(function () {

    // 맨 처음 채용지원 버튼 클릭시
    $(document).on("click", "#btnAddApply", function() {

        $(".apply-step").hide();
        step = 1;
        $("#applyStep"+step).show();

        progress = 0;
        $("#progressBar").css({ width: progress+"%" });
        $("#progressPct").text(progress);

        $("#applyPrev").hide();
        $("#applyNext").show();
        $("#applySubmit").hide();
        $(".preview").addClass("hidden"); // 파일 미리보기 숨기기
    });

    // 다음 버튼 클릭시
    $("#applyNext").on("click", function() {

        const form = $("#applyStep"+step);

        let $emptyElmt = null;

        $(".error:not(.hidden)").each((index, elmt) => {
            $(elmt).addClass("hidden");
        });

        const inputList = $(form).find(".required:not(input:checkbox)");
        for(let input of inputList) {
            if($(input).is(":radio") && !$(`input[name='\${$(input).attr("name")}']`).is(":checked")) {
                $(input).parent().find(".error").removeClass("hidden");
                $emptyElmt = $(input);
                break;
            }
            else if(!$(input).attr("disabled") && ($(input).val() == 0 || $(input).val().trim() == "")){
                $(input).parent().find(".error").removeClass("hidden");
                $emptyElmt = $(input);
                break;
            }
        }

        if($emptyElmt != null) { // 입력하지 않은 input 태그가 존재한다면
            $emptyElmt.focus();
            return;
        }

        $(".apply-step").hide();
        step++;
        if(totalStep == 2 && step == 3) {
            step++;
        }
        $("#applyStep"+step).show();

        progress += 1/totalStep*100;
        $("#progressBar").animate({ width: Math.round(progress)+"%" }, 800);
        $("#progressPct").text(Math.round(progress));
        
        $("#applyPrev").show();

        // 결과 미리보기
        if(Math.round(progress) == 100) {
            $("#applyNext").hide();
            $("#applySubmit").show();

            let answerResultHtml = ``;

            $.each($("#applyanswerVOList").children(), (index, elmt) => {
                let input = $(`input[name='answerVOList[\${index}].answer_query']`);
                let answer;

                if(input.length == 0) {
                    answerResultHtml = `<li>자격 질문이 없습니다.</li>`;
                    return;
                }

                if ($(input).is(":radio")) {
                    answer = $(`input[name='answerVOList[\${index}].answer_query']:checked`).val();
                }
                else {
                    answer = $(input).val();
                }

                if(answer == undefined || answer.trim() == "") {
                    answer = "답변 안 함";
                }

                let question_query = $(elmt).find("label.question-query").text();

                answerResultHtml += `
                    <li>
                        <label class="text-gray-500">\${question_query}</label><br>
                        <div>\${answer}</div>
                    </li>`;
            });

            $("#applyanswerVOListResult").html(answerResultHtml);
        }
    });

    // 뒤로 버튼 클릭시
    $("#applyPrev").on("click", function() {

        if(step == 1) {
            return;
        }
        
        $(".apply-step").hide();
        step--;
        if(totalStep == 2 && step == 3) {
            step--;
        }
        $("#applyStep"+step).show();

        progress -= 1/totalStep*100;
        $("#progressBar").animate({ width: Math.round(progress)+"%" }, 800);
        $("#progressPct").text(Math.round(progress));

        if(progress == 0) {
            $("#applyPrev").hide();
        }

        $("#applySubmit").hide();
        $("#applyNext").show();
    });

    // 이력서 파일 업로드
	$(document).on("change", "input[name='apply_resume_file']", function(e) {
		const inputFileEl = $(e.target).get(0);
	    const previewEl = $(".preview"); // 미리보기 element

	    if (inputFileEl.files && inputFileEl.files[0]) { // 파일을 업로드한 경우

            const fileType = inputFileEl.files[0].type;
            console.log(inputFileEl.files[0].type);
	        const reg = /application\/(haansoftdocx|haansoftpdf|msword|pdf)$/; // 확장자가 워드 또는 pdf 문서인지 확인하기 위한 regex

	        if(!reg.test(fileType)){ // 확장자가 이미지가 아닌 경우
                alert('지원되는 형식(DOC, DOCX, PDF)으로 업로드하세요.');
	            inputFileEl.value = ""; // input 비우기
                return;
            }

	        const limitSize = 2 * 1024 * 1024; // 2mb 크기 제한을 위한 변수

            const uploadSize = inputFileEl.files[0].size;

	        if (limitSize < uploadSize) { // 파일 크기가 2mb 이상인 경우
                alert('2MB 미만 파일만 업로드가 가능합니다.');
	            inputFileEl.value = ""; // input 비우기
                return;
            }

			// 파일 정보를 미리보기에 표시
	        $(previewEl).removeClass("hidden"); // 미리보기 표시
            $(previewEl).find(".file-preview-icon").hide();
            if(fileType.includes("pdf")) {
                $(".file-preview-icon.file-icon-pdf").show();
            }
            else {
                $(".file-preview-icon.file-icon-word").show();
            }

            $(previewEl).find(".apply-resume-file-name").text(inputFileEl.files[0].name);
            $(previewEl).find(".apply-resume-file-size").text(Math.round(inputFileEl.files[0].size/1024));
            
            // 현재 날짜 표시
            let today = new Date();   
            let year = today.getFullYear(); // 년도
            let month = today.getMonth() + 1;  // 월
            let date = today.getDate();  // 날짜
            $(previewEl).find(".apply-resume-upload-date").text(`\${year}. \${month}. \${date}`);

            let path = URL.createObjectURL(inputFileEl.files[0]);
            $(".download-apply-resume").attr("href", path);

            $(previewEl).parent().find(".error").addClass("hidden"); // 오류를 없애기

	    } else { // 파일을 업로드하지 않은 경우
	        $(previewEl).addClass("hidden"); // 미리보기 숨기기
        }
	});

    // 파일 삭제
    $("#deleteApplyResume").on("click", function() {
        $("input[name='apply_resume_file']").val(""); // input 비우기
        $(".preview").addClass("hidden"); // 미리보기 숨기기
    });

    // 답변 숫자 범위 0~99로 제한
    $(document).on("input", ".answer-number", function() {
        if($(".answer-number").val() > 99) {
            $(".answer-number").val(99);
        }
        else if($(".answer-number").val() < 0) {
            $(".answer-number").val(0);
        }
    });

    // 결과 화면에서 수정 버튼 클릭 시
    $(".edit-apply").on("click", function() {
        
        $(".apply-step").hide();
        step = Number($(this).data("step"));
        $("#applyStep"+step).show();

        progress = (step-1) * 1/totalStep*100;
        $("#progressBar").animate({ width: Math.round(progress)+"%" }, 800);
        $("#progressPct").text(Math.round(progress));

        if(progress == 0) {
            $("#applyPrev").hide();
        }

        $("#applySubmit").hide();
        $("#applyNext").show();
    });

    // 지원서 제출
    $("#applySubmit").on("click", function() {
        const form = document.addApplyForm;
        const data = new FormData(form);

        $.ajax({
            url: "${pageContext.request.contextPath}/api/recruit/add/apply",
            data: data,
            type: "post",
            enctype: 'multipart/form-data',
            dataType: "json",
            processData: false,
            contentType: false,
            success: function (json) {
                console.log(JSON.stringify(json));

                if(json != null && json.result != "0") {
                    
                    alert("입사 지원서가 등록되었습니다.");
                    $(".btn-close-modal").click();
                }
            },
            error: function (request, status, error) {
                alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
                requestLock = false;
            }
        });
    });
});

function initApplyForm(json) {
    $("#applyCompanyName").text(json.company_name);

    $("input[name='fk_recruit_no']").val(json.recruit_no);

    if(json.questionVOList.length > 0) {
        totalStep = 3; // 총 3단계로 진행
        $("#answerResultDiv").show(); // 선별 질문에 대한 답변 결과를 표시
        let questionHtml = ``;
        
        $.each(json.questionVOList, (index, item) => {

            let required = ``;
            let requiredHtml = ``;

            <%-- if(item.question_required == "1") { --%>
                required = `required`;
                requiredHtml = ` *`;
            <%-- } --%>

            let answerHtml;

            if(item.question_type == "1") { // 대답 형식이 네/아니요인 경우
                answerHtml = `
                    <input type="radio" name="answerVOList[\${index}].answer_query" id="answerVOList[\${index}].answer_query_yes" value="네" class="\${required}"><label for="answerVOList[\${index}].answer_query_yes" class="ml-2 inline-block">네</label><br>
                    <input type="radio" name="answerVOList[\${index}].answer_query" id="answerVOList[\${index}].answer_query_no" value="아니요" class="\${required}"><label for="answerVOList[\${index}].answer_query_no" class="ml-2 inline-block">아니요</label>
                    `;
            }
            else if(item.question_type == "2") { // 대답 형식이 숫자인 경우
                answerHtml = `<input type="number" name="answerVOList[\${index}].answer_query" min=0 max=99 class="answer-number w-full border rounded-sm p-2 border-gray-400 \${required}" />`;
            }
            else if(item.question_type == "3") { // 대답 형식이 문자인 경우(미구현)
                answerHtml = `<input type="text" name="answerVOList[\${index}].answer_query" class="w-full border rounded-sm p-2 border-gray-400 \${required}" />`;
            }

            questionHtml += `
                    <li>
                        <label class="text-gray-500 question-query">\${item.question_query}\${requiredHtml}</label><br>
                        
                        <input type="hidden" name="answerVOList[\${index}].fk_question_no" value="\${item.question_no}"/>
                        \${answerHtml}
                        <span class="block error text-red-600 mb-2"><i class="fa-solid fa-triangle-exclamation"></i> 필수 답변사항입니다.</span>
                    </li>`;
        });

        $("#applyanswerVOList").html(questionHtml);
    }
    else {
        totalStep = 2; // 총 2단계로 진행
        $("#answerResultDiv").hide(); // 선별 질문에 대한 답변 결과를 숨김
        let questionHtml = `<li>자격 질문이 없습니다.</li>`;
        $("#applyanswerVOList").html(questionHtml);
        $("#applyanswerVOListResuilt").html(questionHtml);
    }
}
</script>

<dialog id="modalAddApply"
    class="fixed left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 modal rounded-lg pt-6 pb-4 drop-shadow-lg w-200">
    <div class="modal-box w-full flex flex-col max-h-[calc(100vh-80px)] space-y-4">
        <!-- 모달 상단부 -->
        <div>
            <button type="button" class="btn-close-modal absolute aspect-square w-10 right-3 top-4">
                <i class="fa-solid fa-xmark text-xl"></i>
            </button>
            <h1 class="h1 px-6"><span id="applyCompanyName"></span>에 지원</h1>

            <hr class="border-gray-200 mt-4">
        </div>

        <!-- 모달 내용 -->
        <div class="space-y-4 overflow-auto">

            <%-- progressBar --%>
            <div class="flex items-center gap-4 px-6">
                <div class="relative my-2 flex-1 h-3 rounded-full bg-gray-200 overflow-hidden">
                    <div id="progressBar" class="absolute w-0 top-0 left-0 h-3 bg-orange-500"></div>
                </div>
                <div><span id="progressPct"></span>%</div>
            </div>

            <form name="addApplyForm">
            <input type="hidden" name="fk_recruit_no">

            <%-- Step1 연락처 --%>
            <div id="applyStep1" class="apply-step px-6">

                <div class="font-bold text-lg mb-4">연락처</div>

                <div class="flex mb-4">
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
                        <c:if test="${not empty sessionScope.loginuser.region_name}">
                            <div class="text-gray-500 text-sm">${sessionScope.loginuser.region_name}</div>
                        </c:if>
                    </div>
                </div>
                
                <ul class="space-y-4">
                    <li>
                        <label class="text-gray-500">이메일 *</label><br>
                        ${sessionScope.loginuser.member_email}
                    </li>
                    <li>
                        <label class="text-gray-500">연락처 *</label><br>
                        <div>
                            010-${fn:substring(sessionScope.loginuser.member_tel, 3, 7)}-${fn:substring(sessionScope.loginuser.member_tel, 7, 11)}
                        </div>
                    </li>
                </ul>
            </div>
            
            <%-- Step2 이력서 --%>
            <div id="applyStep2" class="apply-step px-6">

                <div class="font-bold text-lg mb-2">이력서</div>
                
                <ul class="space-y-4">
                    <li>
                        <label class="text-gray-500 mb-2 block">최신 이력서를 함께 올려주세요. *</label>
                        <div class="border-rwd flex overflow-hidden mb-4 preview hidden">
                            <div class="bg-gray-600 w-12 flex justify-center items-center file-preview-icon file-icon-word">
                                <i class="fa-regular fa-file-lines text-white text-xl"></i>
                            </div>
                            <div class="bg-red-600 w-12 flex justify-center items-center file-preview-icon file-icon-pdf">
                                <i class="fa-regular fa-file-pdf text-white text-xl"></i>
                            </div>
                            <div class="p-4 flex-1">
                                <div class="apply-resume-file-name text-gray-500 text-sm font-bold">파일명.docx</div>
                                <div class="text-gray-500 text-sm"><span class="apply-resume-file-size">536</span>KB · 업로드: <span class="apply-resume-upload-date">2025. 4. 16</span></div>
                            </div>
                            <a class="download-apply-resume block flex items-center justify-center aspect-square w-15">
                                <i class="fa-solid fa-download text-xl"></i>
                            </a>
                            <div class="border-l-1 border-gray-200 my-3"></div>
                            <button type="button" id="deleteApplyResume" class="aspect-square w-15">
                                <i class="fa-solid fa-xmark text-xl"></i>
                            </button>
                        </div>
                        <input type="file" name="apply_resume_file" id="apply_resume_file" class="hidden required"
                            accept="application/msword, application/haansoftdocx, application/pdf">
                        <label type="button" class="button-orange inline-block" for="apply_resume_file">이력서 업로드</label>
                        <span class="error text-red-600 block mt-2"><i class="fa-solid fa-triangle-exclamation"></i> 이력서를 첨부해야 합니다.</span>
                        <span class="block text-gray-500 text-sm mt-2">DOC, DOCX, PDF(최대 2MB)</span>
                    </li>
                </ul>
            </div>

            <%-- Step3 자격 질문 --%>
            <div id="applyStep3" class="apply-step px-6">

                <div class="font-bold text-lg mb-4">자격 질문</div>
                
                <ul class="space-y-4" id="applyanswerVOList">
                    <%-- 선별 질문 목록 --%>
                </ul>
            </div>

            </form>

            <%-- Step4 요약 --%>
            <div id="applyStep4" class="apply-step px-6">

                <div class="text-xl">지원서 다시보기</div>
                <div class="text-gray-500 mb-4">회사에도 회원님의 프로필이 전송됩니다.</div>

                <hr class="border-gray-300 my-8">

                <div class="relative">
                    <div class="font-bold mb-4">연락처</div>
                    <button type="button" data-step="1" class="edit-apply absolute w-10 right-0 top-0 text-orange-500 font-bold">
                        수정
                    </button>
                </div>

                <div class="flex mb-4">
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
                        <c:if test="${not empty sessionScope.loginuser.region_name}">
                            <div class="text-gray-500 text-sm">${sessionScope.loginuser.region_name}</div>
                        </c:if>
                    </div>
                </div>
                
                <ul class="space-y-4">
                    <li>
                        <label class="text-gray-500">이메일 *</label><br>
                        ${sessionScope.loginuser.member_email}
                    </li>
                    <li>
                        <label class="text-gray-500">연락처 *</label><br>
                        <div>
                            010-${fn:substring(sessionScope.loginuser.member_tel, 3, 7)}-${fn:substring(sessionScope.loginuser.member_tel, 7, 11)}
                        </div>
                    </li>
                </ul>

                <hr class="border-gray-300 my-8">

                <div class="relative">
                    <div class="font-bold mb-4">이력서</div>
                    <button type="button" data-step="2" class="edit-apply absolute w-10 right-0 top-0 text-orange-500 font-bold">
                        수정
                    </button>
                </div>
                
                <ul class="space-y-4 pb-4">
                    <li>
                        <label class="text-gray-500 mb-2 block">최신 이력서를 함께 올려주세요. *</label>
                        <div class="border-rwd flex overflow-hidden preview">
                            <div class="bg-gray-600 w-12 flex justify-center items-center file-preview-icon file-icon-word">
                                <i class="fa-regular fa-file-lines text-white text-xl"></i>
                            </div>
                            <div class="bg-red-600 w-12 flex justify-center items-center file-preview-icon file-icon-pdf">
                                <i class="fa-regular fa-file-pdf text-white text-xl"></i>
                            </div>
                            <div class="p-4 flex-1">
                                <div class="apply-resume-file-name text-gray-500 text-sm font-bold">파일명.docx</div>
                                <div class="text-gray-500 text-sm"><span class="apply-resume-file-size">536</span>KB · 업로드: <span class="apply-resume-upload-date">2025. 4. 16</span></div>
                            </div>
                            <div class="border-l-1 border-gray-200 my-3"></div>
                            <a class="download-apply-resume block flex items-center justify-center aspect-square w-20 font-bold">
                                보기
                            </a>
                        </div>
                    </li>
                </ul>

                <hr class="border-gray-300 my-8">

                <div id="answerResultDiv">
                    <div class="relative">
                        <div class="font-bold mb-4">자격 질문</div>
                        <button type="button" data-step="3" class="edit-apply absolute w-10 right-0 top-0 text-orange-500 font-bold">
                            수정
                        </button>
                    </div>
                    
                    <ul class="space-y-4" id="applyanswerVOListResult">
                        <%-- 선별 질문 목록 --%>
                    </ul>
                </div>
            </div>
        </div>

        <!-- 모달 하단부 -->
        <div>
            <hr class="border-gray-200 mb-4">
            <div class="flex justify-end gap-2 items-center px-6 pb-1">
                <div>
                    <button type="button" id="applyPrev" class="btn-transparent">뒤로</button>
                </div>
                <div>
                    <button type="button" id="applyNext" class="button-selected">다음</button>
                </div>
                <div>
                    <button type="button" id="applySubmit"  class="hidden button-selected">지원서 전송</button>
                </div>
            </div>
        </div>
    </div>
</dialog>