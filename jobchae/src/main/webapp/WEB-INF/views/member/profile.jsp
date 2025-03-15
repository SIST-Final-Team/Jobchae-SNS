<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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

    // 이미지 미리보기
	$(document).on("change", "input.img_file", function(e) {
		const inputFileEl = $(e.target).get(0);
	    const previewEl = $(inputFileEl).parent().find(".preview"); // 미리보기 element

	    if (inputFileEl.files && inputFileEl.files[0]) { // 파일을 업로드한 경우

	        const fileType = inputFileEl.files[0].type; // "image/jpeg", "image/png", ...
	        const reg = /image\/(jpeg|png|webp)$/; // 확장자가 이미지인지 확인하기 위한 regex

	        if(!reg.test(fileType)){ // 확장자가 이미지가 아닌 경우
                alert('이미지 파일만 업로드 가능합니다.\n .jpeg .png, .webp');
	            inputFileEl.value = ""; // input 비우기
                return;
            }

	        const limitSize = 5 * 1024 * 1024; // 5mb 크기 제한을 위한 변수

            const uploadSize = inputFileEl.files[0].size;

	        if (limitSize < uploadSize) { // 이미지 크기가 5mb 이상인 경우
                alert('5MB 미만 이미지만 업로드가 가능합니다.');
	            inputFileEl.value = ""; // input 비우기
                return;
            }

			// 이미지 파일을 로드해서 미리보기에 표시
            const fileReader = new FileReader();
			
			fileReader.readAsDataURL(inputFileEl.files[0]);
            fileReader.onload = function() { 
				$(previewEl).attr("src", fileReader.result);
            };
	    } else { // 파일을 업로드하지 않은 경우
	        $(previewEl).attr("src", "${pageContext.request.contextPath}/resources/files/profile/${requestScope.memberVO.member_background_img}"); // 미리보기 이미지 되돌리기
        }
	});

    // 프로필 배경 이미지 수정
    $("#submitProfileBackground").on("click", function(){
        const profileBackgroundForm = document.profileBackgroundForm;
        const data = new FormData(profileBackgroundForm);
        $("#submitProfileBackground").prop("disabled", true);

        $.ajax({
            url: ctxPath+"/api/member/member-background-img",
            data: data,
            enctype: 'multipart/form-data',
            type: "put",
            dataType: "json",
            processData: false,
            contentType: false,
            success: function (json) {
                if(json.result=="1"){
                    $("#submitProfileBackground").prop("disabled", false);
                    location.reload();
                }
                else {
                    alert("프로필 배경 수정을 실패했습니다.");
                }
            },
            error: function(request, status, error){
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
        });
    });

    // 프로필 이미지 수정
    $("#submitProfile").on("click", function(){
        const profileForm = document.profileForm;
        const data = new FormData(profileForm);
        $("#submitProfile").prop("disabled", true);

        $.ajax({
            url: ctxPath+"/api/member/member-profile",
            data: data,
            enctype: 'multipart/form-data',
            type: "put",
            dataType: "json",
            processData: false,
            contentType: false,
            success: function (json) {
                if(json.result=="1"){
                    $("#submitProfile").prop("disabled", false);
                    location.reload();
                }
                else {
                    alert("프로필 배경 수정을 실패했습니다.");
                }
            },
            error: function(request, status, error){
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
        });
    });

});

const oldMemberEmail = "${sessionScope.loginuser.member_email}"; // 회원정보 수정시 자신의 이메일인지 체크하기 위함
sessionStorage.setItem("contextpath", "${pageContext.request.contextPath}"); // js 사용하기 위한 contextPath
</script>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/member/memberUpdate.js"></script>

    <%-- 회원 정보 수정 Modal --%>
    <dialog id="modalUpdateMember"
        class="fixed left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 modal rounded-lg pt-6 pb-4 drop-shadow-lg w-150">
        <div class="modal-box w-full flex flex-col max-h-[calc(100vh-80px)] space-y-4">
            <!-- 모달 상단부 -->
            <div>
                <button type="button"
                    class="btn-close-modal btn btn-sm btn-circle btn-ghost absolute right-8 top-6">&#10005;</button>
                <h1 class="h1 px-8">회원 정보 수정</h1>
                <hr class="border-gray-200 mt-4">
            </div>

            <!-- 모달 내용 -->
            <div class="space-y-4 overflow-auto px-8">
                <form name="updateMemberForm">
                    <input type="hidden" name="member_id" value="${sessionScope.loginuser.member_id}"/>
                    <ul class="space-y-4">
                        <!-- 비밀번호 -->
                        <li>
                            <label class="text-gray-500">비밀번호 *</label>
                            <input type="password" name="member_passwd" id="member_passwd" maxlength="15" 
                                class="w-full border rounded-sm p-2 border-gray-400" placeholder="영문자/숫자/특수기호 조합하여 8~16글자" />
                            <div id="member_passwd_error" class="text-red-500 text-sm"></div>
                        </li>
                        <!-- 비밀번호 확인 -->
                        <li>
                            <label class="text-gray-500">비밀번호 확인 *</label>
                            <input type="password" name="passwdcheck" id="passwdcheck" maxlength="15" 
                                class="w-full border rounded-sm p-2 border-gray-400" placeholder="비밀번호 확인" />
                            <div id="passwdcheckerror" class="text-red-500 text-sm"></div>
                        </li>
                        <!-- 이름 -->
                        <li>
                            <label class="text-gray-500">이름 *</label>
                            <input type="text" name="member_name" id="member_name" maxlength="20" 
                                class="w-full border rounded-sm p-2 border-gray-400" placeholder="이름을 입력하세요."
                                value="${sessionScope.loginuser.member_name}" />
                            <div id="member_name_error" class="text-red-500 text-sm"></div>
                        </li>
                        <!-- 생년월일 -->
                        <li>
                            <label class="text-gray-500">생년월일 *</label>
                            <input type="date" id="member_birth" name="member_birth" min="1924-01-01" max="2025-03-15"
                                class="w-full border rounded-sm p-2 border-gray-400"
                                value="${sessionScope.loginuser.member_birth}" />
                            <div id="birtherror" class="text-red-500 text-sm"></div>
                        </li>
                        <!-- 이메일 -->
                        <li>
                            <label class="text-gray-500">이메일 *</label>
                            <div class="relative">
                                <input type="email" name="member_email" id="member_email" maxlength="60" 
                                    class="w-full border rounded-sm p-2 pr-20 border-gray-400" placeholder="이메일을 입력하세요."
                                value="${sessionScope.loginuser.member_email}" />
                                <button type="button" id="emailcheck" 
                                    class="absolute right-4 top-1/2 transform -translate-y-1/2 text-orange-400 hover:underline cursor-pointer">인증번호 발송</button>
                            </div>
                            <div id="emailCheckResult" class="text-red-500 text-sm"></div>
                            <div id="member_email_error" class="text-red-500 text-sm"></div>
                        </li>
                        <!-- 이메일 인증번호 입력 -->
                        <li class="hidden hide_emailAuth" id="emailAuthSection">
                            <label class="text-gray-500">인증번호 *</label>
                            <div class="relative">
                                <input type="text" name="email_auth" id="email_auth" maxlength="60" 
                                    class="w-full border rounded-sm p-2 pr-20 border-gray-400" placeholder="발송된 인증번호를 입력하세요." />
                                <button type="button" id="btn_email_auth" 
                                    class="absolute right-4 top-1/2 transform -translate-y-1/2 text-orange-400 hover:underline cursor-pointer">인증번호 확인</button>
                            </div>
                            <div id="email_authResult" class="text-red-500 text-sm"></div>
                        </li>
                        <!-- 연락처 -->
                        <li>
                            <label class="text-gray-500">연락처 *</label>
                            <div class="flex items-center space-x-2">
                                <input type="text" id="hp1" size="6" maxlength="3" value="010" readonly
                                    class="w-1/3 border rounded-sm p-2 text-center border-gray-400" />
                                <input type="text" id="hp2" size="6" maxlength="4" class="w-1/3 border rounded-sm p-2 text-center border-gray-400" value="${fn:substring(sessionScope.loginuser.member_tel, 3, 7)}" />
                                <input type="text" id="hp3" size="6" maxlength="4" class="w-1/3 border rounded-sm p-2 text-center border-gray-400" value="${fn:substring(sessionScope.loginuser.member_tel, 7, 11)}" />
                            </div>
                            <input type="hidden" name="member_tel" id="member_tel" maxlength="11" />
                            <div id="telerror" class="text-red-500 text-sm"></div>
                        </li>
                        <!-- 지역 -->
                        <li>
                            <label for="region_name" class="text-gray-500">지역 *</label><br>
                            <input type="text" name="region_name" id="member_region_name"
                                value="${sessionScope.loginuser.region_name}"
                                data-target-url="/api/member/region/search"
                                data-search-type="region_name"
                                data-result-name="fk_region_no"
                                class="input-search w-full border-1 rounded-sm p-2 border-gray-400" />
                            <input type="hidden" name="fk_region_no" class="required" value="${sessionScope.loginuser.fk_region_no}"/>
                            <span class="hidden error text-red-600 text-sm">지역을 목록에서 선택하세요.</span>
                        </li>
                    </ul>
                </form>
            </div>

            <!-- 모달 하단부 -->
            <div>
                <hr class="border-gray-200 mb-4">
                <div class="flex justify-end items-center px-4">
                    <button type="button" id="submitUpdateMember" class="button-selected" onclick="goUpdate()">저장</button>
                </div>
            </div>
        </div>
    </dialog>

    <!-- 프로필 배경 이미지 수정 Modal -->
    <dialog id="modalProfileBackground"
        class="fixed left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 modal rounded-lg pt-6 pb-4 drop-shadow-lg w-200">
        <div class="modal-box w-full flex flex-col max-h-[calc(100vh-80px)] space-y-4">
            <!-- 모달 상단부 -->
            <div>
                <button type="button"
                    class="btn-close-modal btn btn-sm btn-circle btn-ghost absolute right-8 top-6">✕</button>
                <h1 class="h1 px-8">프로필 배경 이미지</h1>

                <hr class="border-gray-200 mt-4">
            </div>

            <!-- 모달 내용 -->
            <div class="space-y-4 overflow-auto">
                <form name="profileBackgroundForm" enctype="multipart/form-data">
                    <ul class="space-y-4 px-8">
                        <li>
                            <label class="text-gray-500">배경 이미지</label><br>
                            <img src="${pageContext.request.contextPath}/resources/files/profile/${requestScope.memberVO.member_background_img}" class="preview w-full h-50 object-cover rounded-lg mb-4"/>
                            
                            <c:if test="${sessionScope.loginuser.member_id == requestScope.memberId}">
                                <label for="attach_member_background_img" class="button-orange w-full inline-block my-2 text-center">사진 선택</label>
                                <input type="file" name="attach_member_background_img" id="attach_member_background_img" 
                                    accept="image/*" class="img_file hidden" />
                            </c:if>
                        </li>
                    </ul>
                </form>
            </div>

            <c:if test="${sessionScope.loginuser.member_id == requestScope.memberId}">
                <!-- 모달 하단부 -->
                <div>
                    <hr class="border-gray-200 mb-4">
                    <div class="flex justify-end items-center px-4">
                        <div>
                            <button type="button" id="submitProfileBackground" class="button-selected">저장</button>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>
    </dialog>

    <!-- 프로필 사진 수정 Modal -->
    <dialog id="modalProfile"
        class="fixed left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 modal rounded-lg pt-6 pb-4 drop-shadow-lg w-100">
        <div class="modal-box w-full flex flex-col max-h-[calc(100vh-80px)] space-y-4">
            <!-- 모달 상단부 -->
            <div>
                <button type="button"
                    class="btn-close-modal btn btn-sm btn-circle btn-ghost absolute right-8 top-6">✕</button>
                <h1 class="h1 px-8">프로필 이미지</h1>

                <hr class="border-gray-200 mt-4">
            </div>

            <!-- 모달 내용 -->
            <div class="space-y-4 overflow-auto">
                <form name="profileForm" enctype="multipart/form-data">
                    <ul class="space-y-4 px-8">
                        <li>
                            <label class="text-gray-500">프로필 이미지</label><br>
                            <img src="${pageContext.request.contextPath}/resources/files/profile/${requestScope.memberVO.member_profile}" class="preview m-auto w-40 h-40 rounded-full object-cover mb-4"/>
                            
                            <c:if test="${sessionScope.loginuser.member_id == requestScope.memberId}">
                                <label for="attach_member_profile" class="button-orange w-full inline-block my-2 text-center">사진 선택</label>
                                <input type="file" name="attach_member_profile" id="attach_member_profile" 
                                    accept="image/*" class="img_file hidden" />
                            </c:if>
                        </li>
                    </ul>
                </form>
            </div>

            <c:if test="${sessionScope.loginuser.member_id == requestScope.memberId}">
            <!-- 모달 하단부 -->
            <div>
                <hr class="border-gray-200 mb-4">
                <div class="flex justify-end items-center px-4">
                    <div>
                        <button type="button" id="submitProfile" class="button-selected">저장</button>
                    </div>
                </div>
            </div>
            </c:if>
        </div>
    </dialog>

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
    <jsp:include page="/WEB-INF/views/member/modal/modalMemberCareer.jsp" />

    <!-- 학력 Modal -->
    <jsp:include page="/WEB-INF/views/member/modal/modalMemberEducation.jsp" />

    <!-- 보유기술 Modal -->
    <jsp:include page="/WEB-INF/views/member/modal/modalMemberSkill.jsp" />


    <!-- 본문 -->
    <div class="container m-auto grid grid-cols-10 lg:grid-cols-14 gap-6 xl:max-w-[1140px]">

        <!-- 중앙 본문 -->
        <div class="center col-span-14 md:col-span-10 space-y-2 my-5">
            <div class="scroll-mt-22 border-board">

                <!-- 프로필 -->
                <div class="pt-0! relative pb-4!">
                    <div class="w-full h-50 px-0 bg-gray-100">
                        <img src="${pageContext.request.contextPath}/resources/files/profile/${requestScope.memberVO.member_background_img}" class="w-full h-50 object-cover rounded-t-md"/>
                        <button type="button" class="button btn-open-modal absolute top-4 right-4 w-10 h-10 rounded-full text-orange-500 hover:text-orange-600 flex justify-center text-center items-center bg-white text-md"
                            data-target-modal="ProfileBackground"><i class="fa-solid fa-camera"></i></button>
                    </div>
                    <div class="absolute top-22">
                        <button type="button" class="button btn-open-modal" data-target-modal="Profile">
                            <img src="${pageContext.request.contextPath}/resources/files/profile/${requestScope.memberVO.member_profile}" class="bg-white w-40 h-40 rounded-full object-cover"/>
                        </button>
                    </div>
                    <c:if test="${requestScope.memberVO.member_profile == 'default/profile.png' && sessionScope.loginuser.member_id == requestScope.memberId}">
                        <button type="button" class="button btn-open-modal absolute top-50 left-33 w-12 h-12 rounded-full border-1 border-orange-500 text-orange-500 flex justify-center text-center items-center bg-white text-xl"
                            data-target-modal="Profile">
                            <i class="fa-solid fa-plus"></i>
                        </button>
                    </c:if>
                    <div class="text-end text-xl py-2 min-h-14">
                        <c:if test="${sessionScope.loginuser.member_id == requestScope.memberId}">
                            <button type="button" class="btn-transparent btn-open-modal" data-target-modal="UpdateMember"><i class="fa-solid fa-pen"></i></button>
                        </c:if>
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
                            <a href="#" class="hover:underline text-orange-500 font-bold">팔로워 <fmt:formatNumber value="${requestScope.followerCount}" pattern="#,###" />명</a>
                        </div>
                    </div>
                    <%-- <div class="flex space-x-2">
                        <button type="button" class="button-selected">활동 상태</button>
                        <button type="button" class="button-gray">리소스</button>
                    </div> --%>
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
                        팔로워 <fmt:formatNumber value="${requestScope.followerCount}" pattern="#,###" />명
                    </div>
                    <div id="update" class="border-board flex gap-4 overflow-x-auto pb-4 space-y-0!">
                        <c:forEach var="item" items="${searchBoardVOList}" varStatus="status">
                        <!-- 게시물 -->
                        <div class="min-w-100 h-120 flex flex-col">
                            <!-- 멤버 프로필 -->
                            <div class="board-member-profile">
                                <div>
                                    <a href="${pageContext.request.contextPath}/member/profile/${item.fk_member_id}"><img src="${pageContext.request.contextPath}/resources/files/profile/${item.member_profile}" class="aspect-square w-15 object-cover rounded-full"/></a>
                                </div>
                                <div class="flex-1">
                                    <a href="#">
                                        <span>${item.member_name}</span>
                                        <span>팔로워 <fmt:formatNumber value="${item.followerCount}" pattern="#,###" />명</span>
                                    </a>
                                    <span>${item.board_register_date}</span>
                                </div>
                            </div>
                            <!-- 글 내용 -->
                            <div>
                                ${item.board_content}
                            </div>
                            <!-- 사진 또는 동영상 등 첨부파일 -->
                            <div class="px-0 flex-grow">
                                
                            </div>
                            <!-- 반응 및 댓글 수(아무 반응 및 댓글이 없으면 표시하지 않음, 댓글만 있으면 댓글만 표시 등) -->
                            <div>
                                <ul class="flex gap-4 text-gray-600">
                                    <li class="flex-1">
                                        <c:if test="${not empty item.reactionStatusList}">
                                            <button type="button" class="button-underline">
                                                <div class="reaction-images">
                                                    <c:forEach var="reaction" items="${fn:split(item.reactionStatusList, ',')}">
                                                        <c:if test="${reaction == 1}">
                                                            <img src="${pageContext.request.contextPath}/images/emotion/like_small.svg"/>
                                                        </c:if>
                                                        <c:if test="${reaction == 2}">
                                                            <img src="${pageContext.request.contextPath}/images/emotion/celebrate_small.svg"/>
                                                        </c:if>
                                                        <c:if test="${reaction == 3}">
                                                            <img src="${pageContext.request.contextPath}/images/emotion/support_small.svg"/>
                                                        </c:if>
                                                        <c:if test="${reaction == 4}">
                                                            <img src="${pageContext.request.contextPath}/images/emotion/love_small.svg"/>
                                                        </c:if>
                                                        <c:if test="${reaction == 5}">
                                                            <img src="${pageContext.request.contextPath}/images/emotion/insightful_small.svg"/>
                                                        </c:if>
                                                        <c:if test="${reaction == 6}">
                                                            <img src="${pageContext.request.contextPath}/images/emotion/funny_small.svg"/>
                                                        </c:if>
                                                    </c:forEach>
                                                </div>
                                                <span id="reactionCount">${item.reactionCount}</span>
                                            </button>
                                        </c:if>
                                    </li>
                                    <li>
                                        <button type="button" class="button-underline">
                                            <span>댓글&nbsp;</span>
                                            <span id="commentCount">${item.commentCount}</span>
                                        </button>
                                    </li>
                                    <li>
                                        <button type="button" class="button-underline">
                                            <span>퍼감&nbsp;</span>
                                            <span id="embedCount">${item.embedCount}</span>
                                        </button>
                                    </li>
                                </ul>
                            </div>

                            <hr class="border-gray-300 mx-4">
                            <!-- 추천 댓글 퍼가기 등 버튼 -->
                            <div class="py-0 text-gray-800">
                                <ul class="grid grid-cols-4 gap-4 text-center">
                                    <li>
                                        <button type="button" class="button-board-action">
                                            <i class="fa-regular fa-thumbs-up"></i>
                                        </button>
                                    </li>
                                    <li>
                                        <button type="button" class="button-board-action">
                                            <i class="fa-regular fa-comment"></i>
                                        </button>
                                    </li>
                                    <li>
                                        <button type="button" class="button-board-action">
                                            <i class="fa-solid fa-retweet"></i>
                                        </button>
                                    </li>
                                    <li>
                                        <button type="button" class="button-board-action">
                                            <i class="fa-regular fa-paper-plane"></i>
                                        </button>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        </c:forEach>
                    </div>
                    <c:if test="${empty requestScope.searchBoardVOList}">
                        <div class="-mt-8 mb-4">
                            <span class="font-bold">${requestScope.memberVO.member_name}님이 올린 업데이트가 없습니다.</span><br>
                            ${requestScope.memberVO.member_name}님이 올리는 최근 업데이트는 여기에 표시됩니다.
                        </div>
                    </c:if>
                        
                    <c:if test="${not empty requestScope.searchBoardVOList and requestScope.searchBoardVOList.size() > 2}">
                        <div class="px-0">
                            <hr class="border-gray-300">
                            <button type="button" class="button-more"  onclick="location.href=ctxPath+'/member/profile/update/'+memberId">
                                활동 모두 보기 <i class="fa-solid fa-arrow-right"></i>
                            </button>
                        </div>
                    </c:if>
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
                            <li class="-pt-2 pb-4"><span class="block">조회된 경력 정보가 없습니다.</span>
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
                            <li class="-pt-2 pb-4"><span class="block">조회된 학력 정보가 없습니다.</span>
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
                            <li class="-pt-2 pb-4"><span class="block">조회된 보유기술 정보가 없습니다.</span>
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