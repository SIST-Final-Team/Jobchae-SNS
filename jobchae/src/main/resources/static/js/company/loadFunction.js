// 렌더링 시 필요한 함수들을 정의하는 페이지 입니다
//홈 정보 반환 함수

function loadHome() {
  let companyExplain = companyData.companyExplain; // 회사 설명을 가져옵니다.
  //홈페이지에 표시할 회사 설명이 100자 이상일 경우, 100자까지만 표시합니다.

  if (companyExplain.length > 100) {
    console.log("100자 초과"); // 콘솔에 출력합니다.
    companyExplain = companyExplain.substr(0, 100) + "..."; // 100자까지만 표시합니다.
  }
  const html = `<!-- 회사 소개 -->
                <div class="py-0!">
                    <h1 class="h1 pt-4">소개</h1>
                    <div class="text-gray-700 whitespace-pre-line mb-4">
                    ${companyExplain}
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
                </div>`;
  return html;
}

//소개 정보 반환 함수
function loadAbout() {
  let webLinkHtml; // 웹사이트 링크를 설정합니다.
  let industryHtml; // 업종을 설정합니다.
  let companySizeHtml; // 회사 규모를 설정합니다.
  //회사 웹페이지 링크가 null이 아닐 경우, 웹사이트 링크를 설정합니다.
  if (companyData.companyWebsite != null) {
    webLinkHtml = `<h1 class="h1 pt-4">웹사이트</h1>
                          <a href="${companyData.companyWebsite}" class="text-blue-600 hover:underline">${companyData.companyWebsite}</a>`; // 웹사이트 링크를 설정합니다.
  }
  //회사 업계가 null이 아닐 경우, 업종을 설정합니다.
  if (companyData.industry != null) {
    industryHtml = `<h1 class="h1 pt-4">업계</h1>
                        <div class="text-gray-700 whitespace-pre-line mb-4">
                            ${companyData.industry.industryName}
                      </div>`;
  }
  //회사 규모가 null이 아닐 경우, 회사 규모를 설정합니다.
  if (companyData.companySize != null) {
    companySizeHtml = `<h1 class="h1 pt-4">회사 규모</h1>
                          <div class="text-gray-700 whitespace-pre-line mb-4">
                              ${companySizeText}
                        </div>`;
  }

  const html = `<!-- 회사 소개 -->
                  <div class="py-0!">
                      <h1 class="pt-4 text-3xl font-bold">한눈에 보기</h1>
                      <div class="text-gray-700 whitespace-pre-line mb-4">
                            ${companyData.companyExplain}
                      </div>
                      ${webLinkHtml}
                      ${industryHtml}
                      ${companySizeHtml}
                  </div>`;
  return html; // 회사 소개 HTML을 반환합니다.
}
//채용공고 정보 반환 함수
function loadJobs() {
  const html = `<!-- 채용공고 -->
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
                  </div>`;
  return html; // 회사 소개 HTML을 반환합니다.
}
//게시물 정보 반환 함수
function loadPosts() {
  const html = `<!-- 회사 게시물 -->
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
                </div>`;
  return html; // 회사 소개 HTML을 반환합니다.
}
//사람들 정보 반환 함수
function loadPeople() {
  const html = `<!-- 회사 직원 -->
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
                </div>`;
  return html; // 회사 소개 HTML을 반환합니다.
}
