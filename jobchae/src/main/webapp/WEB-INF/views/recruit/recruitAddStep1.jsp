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

    <%-- 사용자정의 js --%>
    <script src="${pageContext.request.contextPath}/js/recruit/recruitAddStep1.js"></script>

    <title>채용공고 올리기 - JOB CHAE</title>

    <script type="text/javascript">
        const ctxPath = "${pageContext.request.contextPath}";
    </script>
</head>
<body>

    <!-- 헤더 -->
	<jsp:include page="/WEB-INF/views/common/headerBeforeLogin.jsp" />

    <div class="flex items-center justify-center h-200 bg-gray-100">

        <div class="mx-auto w-md bg-white rounded-lg p-6 shadow-md">

            <h4 class="text-2xl mt-0 font-semibold mb-4">지금 채용공고 올리기</h4>

            <form name="recruitAddStep1Form" action="${pageContext.request.contextPath}/recruit/add/step2" method="post">
                <div class="flex flex-col items-center">

                    <!-- 직종 -->
                    <div class="w-full max-w-md mb-4">
                        <label for="recruit_job_name" class="block text-sm font-medium text-gray-700">직종<span class="text-red-500">*</span></label>
                        <input type="text" name="recruit_job_name" id="recruit_job_name"
                            placeholder="채용 중인 직종 입력"
                            autocomplete="off"
                            data-target-url="/api/member/job/search"
                            data-search-type="job_name"
                            data-result-name="fk_job_no"
                            class="input-search mt-1 p-2 border border-gray-300 rounded-md w-full required" />
                        <span class="error text-red-500 text-sm mt-1 hidden">직종은 필수 입력사항입니다.</span>
                    </div>

                    <!-- 회사 -->
                    <div class="w-full max-w-md mb-4">
                        <label for="company_name" class="block text-sm font-medium text-gray-700">회사<span class="text-red-500">*</span></label>
                        <div class="relative">
                            <input type="text" name="company_name" id="company_name"
                                placeholder="회사 입력"
                                autocomplete="off"
                                data-target-url="/api/member/company/search"
                                data-search-type="company_name"
                                data-result-name="fk_company_no"
                                class="input-search mt-1 p-2 border border-gray-300 rounded-md w-full required"/>
                            <span class="hidden error text-red-600 text-sm">회사를 입력하세요.</span>
                        </div>
                        <input type="hidden" name="fk_company_no"/>
                    </div>
                    
                    <!-- 근무형식 -->
                    <div class="w-full max-w-md mb-4">
                        <label for="recruit_work_type" class="block text-sm font-medium text-gray-700">근무형식<span class="text-red-500">*</span></label>
                        <select name="recruit_work_type" class="mt-1 p-2 border border-gray-300 rounded-md w-full required"
                            id="recruit_work_type">
                            <option value="1">대면근무</option>
                            <option value="2">대면재택혼합근무</option>
                            <option value="3">재택근무</option>
                        </select>
                        <span class="error text-red-500 text-sm mt-1 hidden">근무형식을 목록에서 선택하세요.</span>
                    </div>

                    <!-- 지역 -->
                    <div class="w-full max-w-md mb-4">
                        <label for="region_name" class="block text-sm font-medium text-gray-700">지역<span class="text-red-500">*</span></label>
                        <input type="text" name="region_name" id="region_name"
                            placeholder="지역 입력"
                            autocomplete="off"
                            data-target-url="/api/member/region/search"
                            data-search-type="region_name"
                            data-result-name="fk_region_no"
                            class="input-search mt-1 p-2 border border-gray-300 rounded-md w-full" />
                        <input type="hidden" name="fk_region_no" class="required"/>
                        <span class="hidden error text-red-600 text-sm">지역을 목록에서 선택하세요.</span>
                    </div>
                    
                    <!-- 고용형태 -->
                    <div class="w-full max-w-md mb-4">
                        <label for="recruit_job_type" class="block text-sm font-medium text-gray-700">고용형태<span class="text-red-500">*</span></label>
                        <select name="recruit_job_type" class="mt-1 p-2 border border-gray-300 rounded-md w-full required"
                            id="recruit_job_type">
                            <option value="1">정규직</option>
                            <option value="2">시간제</option>
                            <option value="3">자영업/개인사업</option>
                            <option value="4">프리랜서</option>
                            <option value="5">계약직</option>
                            <option value="6">인턴</option>
                            <option value="7">수습생</option>
                            <option value="8">시즌</option>
                        </select>
                        <span class="error text-red-500 text-sm mt-1 hidden">고용형태를 목록에서 선택하세요.</span>
                    </div>

                    <!-- 채용공고 시작 버튼 -->
                    <div class="w-full max-w-md flex justify-between mt-6 space-x-2">
                        <button type="button" id="submitRecruitStep1" class="w-full py-2 px-4 bg-orange-400 text-lg text-white font-semibold rounded-full hover:bg-orange-500 duration-200 hover:cursor-pointer">채용공고 시작</button>
                    </div>

                </div>
            </form>

        </div>
    </div>

    <!-- 푸터 -->
	<jsp:include page="/WEB-INF/views/common/footerBeforeLogin.jsp" />

</body>
</html>