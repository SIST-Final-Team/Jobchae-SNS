<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- === JSTL( Java Standard Tag Library) 사용하기 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/header/header.jsp" />

    <!-- TailWind Script -->
    <script src="${pageContext.request.contextPath}/js/tailwind.js"></script>
    <!-- Font Awesome CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <%-- TailWind 사용자 정의 CSS --%>
    <jsp:include page="/WEB-INF/views/member/profileTailwind.jsp" />

<script type="text/javascript">
$(document).ready(function() {

    // 모달 애니메이션 추가
    $("dialog.modal").addClass("animate-slideDown");
    
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

    // 드롭다운 모달 열기
    $(".btn-open-dropdown").on("click", function() {
        const btnId = $(this).attr("id");
        const dropdownId = "#dropdown" + btnId.slice(3);
        const rect = this.getBoundingClientRect();

        $(dropdownId).css({"left":rect.left+"px","top":(rect.bottom)+"px"});
        $(dropdownId)[0].showModal();
    });

    // 바깥 클릭하면 드롭다운 모달 닫기
    $(".option-dropdown").on("click", function(e) {
        if (e.target === this) {
            this.close();
        }
    });

    const recruit_no = "${requestScope.recruit_no}";

    $.ajax({
        url: "${pageContext.request.contextPath}/api/recruit/"+recruit_no,
        dataType: "json",
        success: function (item) {
            // console.log(JSON.stringify(item));

            if(item != null) {

                initApplyForm(item); // 채용공고 지원 폼을 구성하기, modalAddApply에서 구현

                getCompanyInfo(item.fk_company_no); // 회사 정보 불러오기

                const companyLogoHtml = (item.company_logo != null)
                    ?`<img src="\${ctxPath}/resources/files/companyLogo/\${item.company_logo}" class="aspect-square w-10 object-cover" />`
                    :`<div class="aspect-square w-10 bg-gray-200 flex items-center justify-center"><i class="fa-solid fa-building text-xl text-gray-500"></i></div>`;

                $("#recruit_company_logo").html(companyLogoHtml);
                $(".companyLink").attr("href", `\${ctxPath}/company/dashboard/\${item.fk_company_no}/`);

                $("#recruit_job_name").text(item.recruit_job_name);
                $("#recruit_company_name").text(item.company_name);
                $("#recruit_region_name").text(item.region_name);
                $("#recruit_register_date").text(item.time_ago);
                $("#recruit_explain").html(item.recruit_explain);

                const apply_cnt = (item.apply_cnt == null)?`초기 지원자가 되세요.`:`지원자 \${item.apply_cnt}명`;
                $(".applyCnt").text(apply_cnt);

                let recruit_work_type = ``;
                switch(item.recruit_work_type) {
                    case "1":
                        recruit_work_type = `대면근무`;
                    break;
                    case "2":
                        recruit_work_type = `대면재택혼합근무`;
                    break;
                    case "3":
                        recruit_work_type = `재택근무`;
                    break;
                }
                $("#recruit_work_type").text(recruit_work_type);
                
                let recruit_job_type = ``;
                switch(item.recruit_job_type) {
                    case "1":
                        recruit_job_type = `풀타임`;
                    break;
                    case "2":
                        recruit_job_type = `파트타임`;
                    break;
                    case "3":
                        recruit_job_type = `계약직`;
                    break;
                    case "4":
                        recruit_job_type = `임시직`;
                    break;
                    case "5":
                        recruit_job_type = `기타`;
                    break;
                    case "6":
                        recruit_job_type = `자원봉사`;
                    break;
                    case "7":
                        recruit_job_type = `인턴`;
                    break;
                }
                $("#recruit_job_type").text(recruit_job_type);

            }
            else {
                alert("채용공고 정보를 읽어오지 못했습니다.");
            }

        },
        error: function (request, status, error) {
            alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
        }
    });

    $("#copyLink").on("click", function() {
        const link = 'www.jobchae.kro.kr${pageContext.request.contextPath}/recruit/view/${requestScope.recruit_no}';
        navigator.clipboard.writeText(link).then(() => {
            alert("링크가 클립보드에 복사되었습니다.");
        });
    });
});

// 회사 정보 읽어오기
function getCompanyInfo(company_no) {
    $.ajax({
        url: "${pageContext.request.contextPath}/api/company/dashboard/"+company_no,
        dataType: "json",
        success: function (item) {
            // console.log(JSON.stringify(item));

            if(item != null) {

                const companyLogoHtml = (item.companyLogo != null)
                    ?`<img src="\${ctxPath}/resources/files/companyLogo/\${item.companyLogo}" class="aspect-square w-20 object-cover" />`
                    :`<div class="aspect-square w-20 bg-gray-200 flex items-center justify-center"><i class="fa-solid fa-building text-xl text-gray-500"></i></div>`;

                $("#company_logo").html(companyLogoHtml);
                $("#company_name").text(item.companyName);
                $("#company_explain").text(item.companyExplain);

            }

        },
        error: function (request, status, error) {
            alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
        }
    });
}

// 채용공고 등록 모달 띄우기
function openModal(btnEl) {
    const btnId = $(btnEl).attr("id");
    const targetModal = $(btnEl).data("target-modal");

    // 폼 리셋
    $("form").each(function (index, elmt) {
        elmt.reset();
    });

    const modalId = "#modal" + targetModal;
    const rect = btnEl.getBoundingClientRect();
    $(modalId)[0].showModal();
}
</script>
<style>
dialog.option-dropdown::backdrop {
    background: transparent;
}
</style>

    <!-- 채용공고 지원 Modal -->
    <jsp:include page="/WEB-INF/views/recruit/modalAddApply.jsp" />

    <dialog id="dropdownRecruitMore" class="option-dropdown border-normal drop-shadow-lg">
        <ul class="nav font-bold text-gray-600 w-70 pb-0!">
            <li class="py-2"><button type="button" id="copyLink"><i class="fa-solid fa-link"></i> 링크 복사</button></li>
        </ul>
    </dialog>

    <!-- 본문 -->
    <div class="container m-auto grid grid-cols-10 lg:grid-cols-14 gap-6 xl:max-w-[1140px] py-5">

        <!-- 중앙 본문 -->
        <div class="center col-span-10 space-y-4">
            <div class="border-rwd p-6">
                <div class="flex">
                    <div class="flex-1 flex items-center gap-2">
                        <a class="companyLink">
                            <div id="recruit_company_logo">
                                <div class="aspect-square w-10 bg-gray-200 flex items-center justify-center"><i class="fa-solid fa-building text-xl text-gray-500"></i></div>
                            </div>
                        </a>
                        <a class="companyLink">
                            <div id="recruit_company_name" class="font-bold"></div>
                        </a>
                    </div>
                    <button type="button" id="btnRecruitMore" class="btn-open-dropdown btn-transparent w-13 h-13 relative"><i class="absolute left-1/2 top-1/2 transform -translate-y-1/2 -translate-x-1/2 fa-solid fa-ellipsis text-xl"></i></button>
                </div>

                <h1 id="recruit_job_name" class="text-3xl font-bold"></h1>

                <div class="text-gray-500 my-2"><span id="recruit_region_name"></span> · <span id="recruit_register_date"></span> · <span class="text-green-700 font-bold applyCnt"></span></div>

                <div class="text-gray-700"><i class="fa-solid fa-briefcase text-gray-500"></i> <span id="recruit_work_type"></span> · <span id="recruit_job_type"></span></div>

                <div class="flex mt-4 gap-2">
                    <button type="button" id="btnAddApply" class="btn-open-modal button-selected py-1! px-5!" data-target-modal="AddApply">지원</button>
                </div>
            </div>

            <div class="border-rwd p-6">
                <div>
                    <div class="text-2xl font-bold pb-4">채용공고 설명</div>
                    <div id="recruit_explain" class="ql-editor text-base! p-0!" contenteditable="false"></div>
                </div>
            </div>

            <div class="border-rwd p-6">
                <div>
                    <div class="text-2xl font-bold pb-4">회사 소개</div>
                </div>
                <div class="flex-1 flex items-center gap-2">
                    <a class="companyLink">
                        <div id="company_logo">
                            <div class="aspect-square w-10 bg-gray-200 flex items-center justify-center"><i class="fa-solid fa-building text-xl text-gray-500"></i></div>
                        </div>
                    </a>
                    <a class="companyLink"><div id="company_name" class="font-bold text-xl"></div></a>
                </div>
                <div id="company_explain" class="pt-4 text-lg text-gray-600"></div>
            </div>
        </div>

        <!-- 우측 광고 -->
        <div class="right-side lg:col-span-4 h-full relative hidden lg:block">

            <div class="border-rwd pb-4 sticky space-y-2 text-center relative">
                <div class="absolute top-5 right-5 bg-white rounded-sm text-[0.9rem]">
                    <span class="pl-1.5 font-bold">광고</span>
                    <button type="button" class="font-bold hover:bg-gray-100 cursor-pointer px-1.5 py-1 rounded-r-sm"><i class="fa-solid fa-ellipsis"></i></button>
                </div>
                <div>
                    <img src="${pageContext.request.contextPath}/images/ad2.png"/>
                </div>
                <div class="px-4">
                    <p class="font-bold">${sessionScope.loginuser.member_name}님, syoffice에서 All in One Company Service를 경험하세요.</p>
                </div>
                <div class="px-4">
					<a href="http://syoffice.kro.kr/syoffice">
                    <button type="button" class="button-orange">방문하기</button>
					</a>
                </div>
            </div>

            <div class="border-rwd p-4 mt-4 text-center">
                <div class="text-lg mb-2">인재를 찾고 계세요?</div>
                <a href="${pageContext.request.contextPath}/recruit/add/step1" class="text-center button-orange">채용공고 올리기</a>
            </div>
        </div>
    </div>
</body>
</html>