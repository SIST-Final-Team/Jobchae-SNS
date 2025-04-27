<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<jsp:include page="/WEB-INF/views/header/header.jsp" />


<div class="container m-auto grid grid-cols-10 lg:grid-cols-14 gap-6 xl:max-w-[1140px]">
    <!-- 메인 부분 -->
    <div class="center col-span-14 md:col-span-10 space-y-2 my-5">
        <div class="scroll-mt-22 border-board">

            <!-- 회사 프로필 -->
            <div class="pt-0! relative pb-4!" id="company-profile">
                <div class="w-full h-50 px-0 bg-gray-100">
                    <img src="" id="company-background-img" class="w-full h-50 object-cover rounded-t-md"/>
                    <button type="button" class="button btn-open-modal absolute top-4 right-4 w-10 h-10 rounded-full text-orange-500 hover:text-orange-600 flex justify-center text-center items-center bg-white text-md"
                            data-target-modal="CompanyBackground"><i class="fa-solid fa-camera"></i></button>
                </div>
                <div class="absolute top-22">
                    <button type="button" class="button btn-open-modal" data-target-modal="CompanyLogo">
                        <img id ="company-profile-logo" src="" class="bg-white w-40 h-40 rounded-md object-cover border-4 border-white shadow-lg"/>
                    </button>
                </div>
                <div class="text-end text-xl py-2 min-h-14">
                    <button type="button" class="btn-transparent btn-open-modal" data-target-modal="UpdateCompany"><i class="fa-solid fa-pen"></i></button>
                </div>

                <div>
                    <div class="text-3xl font-bold flex items-center">
                        <span id="companyName">company Name</span>
                        <i class="fas fa-check-circle text-orange-500 ml-2 text-lg" title="인증된 회사"></i>
                    </div>
                    <div class="text-sm text-gray-500">
                        <span id="companyIndustry">연구 서비스</span> · 
                        <span id="companyLocation">위치</span> · 
                        <span id="companyFollowerCount">팔로워</span> · 
                        <span id="companySize">직원 규모</span>
                    </div>
                </div>
                <div class="flex space-x-2 mt-2">
                    <!-- <button type="button" class="follow-button button-orange" data-following-id=""><i class='fa-solid fa-plus'></i>&nbsp;팔로우</button> -->
                    <!-- <button type="button" class="follow-button followed button-gray" data-following-id="">팔로우 중</button> -->
                    <a href="" id="webLinkButton" target="_blank" class="button-gray">홈페이지 방문 <i class="fas fa-external-link-alt text-xs ml-1"></i></a>
                    <button id="report-btn" class="button-gray">신고/차단</button>
                </div>
                <div id="company-nav" class="mt-4 text-lg text-gray-500 border-t border-gray-200">
                    <div id = "menu-list" class="lg:w-4/7">
                        <ul class="flex p-2">
                            <li class="menu-element mr-10 cursor-pointer" data-root="">홈</li>
                            <li class="menu-element mr-10 cursor-pointer" data-root="about">소개</li>
                            <li class="menu-element mr-10 cursor-pointer" data-root="posts">게시물</li>
                            <li class="menu-element mr-10 cursor-pointer" data-root="jobs">채용공고</li>
                            <li class="menu-element mr-10 cursor-pointer" data-root="people">사람</li>
                        </ul>
                    </div>
                </div>
            </div>

            <!-- 컨텐츠 부분(바뀌는 부분분) -->
            <div id="contentDiv">
                <!-- 회사 소개 -->
                <div class="py-0!">
                    <h1 class="h1 pt-4">소개</h1>
                    <div class="text-gray-700 whitespace-pre-line mb-4">
                    안녕하세요
                    </div>
                </div>

                <!-- 채용공고 -->
                <div class="space-y-0 pb-0!">
                    <h1 class="h1 mb-0">채용공고</h1>
                    <div class="text-gray-500 pb-2 text-lg">
                        현재 진행 중인 채용공고
                    </div>
                    <div id="jobs" class="border-board flex gap-4 overflow-x-auto pb-4 space-y-0! mb-0!">
                        <!-- 채용공고 아이템 템플릿 -->
                        <div class="min-w-100 min-h-120 flex flex-col border border-gray-200 rounded-lg shadow-sm p-4">
                            <div class="flex items-center mb-3">
                                <img src="" class="w-12 h-12 object-cover rounded-md mr-3"/>
                                <div>
                                    <h3 class="font-bold text-xl">채용 제목</h3>
                                    <p class="text-gray-600">회사명 · 위치</p>
                                </div>
                            </div>

                            <div class="flex-grow text-gray-700 mb-3">
                                <p class="font-semibold">주요 내용:</p>
                                <p class="line-clamp-3">채용 설명 내용이 여기에 표시됩니다.</p>
                            </div>

                            <div class="text-sm text-gray-500 mb-2">
                                <p>지원마감: 2025-05-30</p>
                                <p>경력: 신입</p>
                                <p>급여: 면접 후 결정</p>
                            </div>

                            <div class="text-center pt-2 border-t border-gray-200">
                                <a href="" class="button-orange w-full block">상세 보기</a>
                            </div>
                        </div>
                        
                        <!-- 채용공고 없을 때 표시할 템플릿 -->
                        <div class="w-full text-center p-8 border border-gray-200 rounded-lg">
                            <span class="font-bold">회사명의 진행 중인 채용공고가 없습니다.</span><br>
                            새 채용공고가 올라오면 여기에 표시됩니다.
                        </div>
                    </div>

                    <div class="px-0">
                        <hr class="border-gray-300">
                        <button type="button" class="button-more">
                            채용공고 모두 보기 <i class="fa-solid fa-arrow-right"></i>
                        </button>
                    </div>
                </div>

                <!-- 회사 게시물 -->
                <div class="pb-0!">
                    <h1 class="h1 mb-0">회사 소식</h1>
                    <div id="company-posts" class="space-y-4 mt-4">
                        <!-- 게시물 템플릿 -->
                        <div class="border border-gray-200 rounded-lg p-4">
                            <!-- 게시물 헤더 -->
                            <div class="board-member-profile">
                                <div>
                                    <img src="" class="aspect-square w-15 object-cover rounded-md"/>
                                </div>
                                <div class="flex-1">
                                    <a href="#">
                                        <span>회사명</span>
                                        <span>팔로워 1,000명</span>
                                    </a>
                                    <span>게시일</span>
                                </div>
                            </div>

                            <!-- 게시물 내용 -->
                            <div class="mt-3">
                                게시물 내용이 여기에 표시됩니다.
                            </div>

                            <!-- 이미지 영역 -->
                            <div class="mt-3">
                                <img src="" class="w-full rounded-lg"/>
                            </div>

                            <!-- 반응 및 댓글 -->
                            <div class="mt-3">
                                <ul class="flex gap-4 text-gray-600">
                                    <li class="flex-1">
                                        <button type="button" class="button-underline">
                                            <div class="reaction-images">
                                                <img src=""/>
                                            </div>
                                            <span id="reactionCount">0</span>
                                        </button>
                                    </li>
                                    <li>
                                        <button type="button" class="button-underline">
                                            <span>댓글&nbsp;</span>
                                            <span id="commentCount">0</span>
                                        </button>
                                    </li>
                                    <li>
                                        <button type="button" class="button-underline">
                                            <span>퍼감&nbsp;</span>
                                            <span id="embedCount">0</span>
                                        </button>
                                    </li>
                                </ul>
                            </div>

                            <hr class="border-gray-300 my-3">

                            <!-- 버튼 영역 -->
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
                        
                        <!-- 게시물 없을 때 표시할 템플릿 -->
                        <div class="w-full text-center p-8 border border-gray-200 rounded-lg">
                            <span class="font-bold">회사명의 소식이 없습니다.</span><br>
                            회사에서 새 소식을 올리면 여기에 표시됩니다.
                        </div>
                    </div>

                    <div class="px-0">
                        <hr class="border-gray-300 mt-4">
                        <button type="button" class="button-more">
                            소식 모두 보기 <i class="fa-solid fa-arrow-right"></i>
                        </button>
                    </div>
                </div>

                <!-- 회사 직원 -->
                <div class="pb-0!">
                    <h1 class="h1 mb-0">사람들</h1>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mt-4">
                        <div>
                            <h3 class="font-semibold text-gray-700 mb-2">여기서 근무하는 직원 (0명)</h3>
                            <p class="text-sm text-gray-500 mb-3">현재 회사명에서 근무 중인 사람들</p>
                            <div class="flex -space-x-2 mb-3">
                                <!-- 직원 프로필 이미지 템플릿 -->
                                <img class="inline-block h-10 w-10 rounded-full ring-2 ring-white" src="" alt="">
                                <!-- 추가 직원 수 표시 템플릿 -->
                                <span class="inline-flex items-center justify-center h-10 w-10 rounded-full ring-2 ring-white bg-gray-200 text-gray-600 font-semibold text-xs">+5</span>
                            </div>
                            <!-- 직원 이름 링크 템플릿 -->
                            <a href="" class="text-blue-600 hover:underline">직원명</a>
                            <span class="text-gray-600"> 외 0명</span>
                        </div>
                        <div>
                            <h3 class="font-semibold text-gray-700 mb-2">연관 회사</h3>
                            <p class="text-sm text-gray-500 mb-3">비슷한 산업에 있는 회사들</p>
                            <ul class="space-y-2">
                                <!-- 연관 회사 템플릿 -->
                                <li>
                                    <a href="" class="flex items-center hover:bg-gray-50 p-2 rounded-md">
                                        <img src="" class="w-10 h-10 rounded-md mr-3"/>
                                        <span class="font-medium">연관 회사명</span>
                                    </a>
                                </li>
                                <!-- 연관 회사 없을 때 표시할 템플릿 -->
                                <li class="text-gray-500">연관 회사가 없습니다.</li>
                            </ul>
                        </div>
                    </div>

                    <div class="px-0">
                        <hr class="border-gray-300 mt-4">
                        <button type="button" class="button-more">
                            직원 모두 보기 <i class="fa-solid fa-arrow-right"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 우측 광고 -->
    <div class="right-side lg:col-span-4 h-full relative hidden lg:block -z-1" id="rightSideDiv">
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

<!-- 회사 프로필 수정 모달 등 다른 모달도 필요한 경우 추가 -->
<!-- 회사 배경 이미지 변경, 로고 변경, 회사 정보 업데이트 모달 -->
</body>

<script>
    const contextPath = "${pageContext.request.contextPath}";
</script>
<script src="${pageContext.request.contextPath}/js/company/pageLoad.js"></script>
<script src="${pageContext.request.contextPath}/js/company/dashboard.js"></script>
<script src="${pageContext.request.contextPath}/js/company/loadFunction.js"></script>
</html>