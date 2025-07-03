//이 페이지는 컨텐츠를 불러오는 기능을 하는 자바스크립트 파일입니다.
// 각 메뉴를 클릭 했을 때 해당하는 페이지의 내용물을 바꿉니다.

// 대시보드 로드
async function loadDashboard(contentDiv) {
  contentDiv.innerHTML = `<div class="card p-4 space-y-3">
      <h2 class="text-lg font-semibold text-gray-800">오늘의 작업</h2>
      <p class="text-sm text-gray-600">
        이러한 작업을 정기적으로 완료하는 페이지는 4배 더 빠르게 성장합니다.
      </p>
      <div class="border rounded-lg p-3 flex justify-between items-center">
        <div>
          <h3 class="font-semibold text-gray-700">웹사이트 URL 추가</h3>
          <p class="text-sm text-gray-500">
            URL을 추가하여 더 많은 페이지 방문자를 웹사이트로 유도하세요.
          </p>
        </div>
        <button class="text-gray-400 hover:text-gray-600">
          <i class="fas fa-times"></i>
        </button>
      </div>
      <div class="border rounded-lg p-3 flex justify-between items-center">
        <div>
          <h3 class="font-semibold text-gray-700">업무 설명 추가</h3>
          <p class="text-sm text-gray-500">
            검색 결과에서 페이지가 발견되도록 간단한 설명을 추가하세요.
          </p>
        </div>
        <button class="text-gray-400 hover:text-gray-600">
          <i class="fas fa-times"></i>
        </button>
      </div>
      <button
        class="mt-2 w-full bg-blue-600 text-white py-2 rounded-full hover:bg-blue-700 transition duration-150 font-semibold"
      >
        + 만들기
      </button>
    </div>

    <div class="card p-4">
      <div class="flex justify-between items-center mb-4">
        <h2 class="text-lg font-semibold text-gray-800">
          최근 게시물 관리
        </h2>
        <div class="flex items-center space-x-2 text-gray-500">
          <button class="hover:text-gray-700">
            <i class="fas fa-chevron-left"></i>
          </button>
          <button class="hover:text-gray-700">
            <i class="fas fa-chevron-right"></i>
          </button>
        </div>
      </div>
      <p class="text-sm text-gray-600 mb-4">
        페이지의 콘텐츠를 관리하고 스폰서하여 도달 범위를 넓히세요.
        <a href="#" class="text-blue-600 hover:underline">자세히 보기</a>
      </p>

      <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
        <div class="border rounded-lg overflow-hidden">
          <div class="p-3">
            <p class="text-xs text-gray-500 mb-1">
              스폰서 업데이트로 노출 수 77,000회 더 늘리세요.
            </p>
            <button
              class="bg-blue-100 text-blue-700 text-xs font-semibold px-2 py-1 rounded-full hover:bg-blue-200"
            >
              스폰서
            </button>
          </div>
          <div class="bg-gray-100 p-3">
            <div class="flex items-center mb-2">
              <div class="w-8 h-8 bg-gray-400 rounded-full mr-2"></div>
              <span class="font-semibold text-sm">쌍용 파이널 테스트</span>
            </div>
            <p class="text-sm mb-2">게시물 테스트</p>
            <img
              src="https://placehold.co/300x150/e2e8f0/94a3b8?text=[%EC%9D%B4%EB%AF%B8%EC%A7%80]"
              alt="게시물 이미지"
              class="w-full h-32 object-cover rounded"
            />
          </div>
          <div class="p-3 flex justify-between text-xs text-gray-500">
            <span><i class="far fa-thumbs-up"></i> 0</span>
            <span><i class="far fa-comment"></i> 0</span>
          </div>
        </div>
        <div class="border rounded-lg overflow-hidden">
          <div class="p-3">
            <p class="text-xs text-gray-500 mb-1">
              스폰서 업데이트로 노출 수 77,000회 더 늘리세요.
            </p>
            <button
              class="bg-blue-100 text-blue-700 text-xs font-semibold px-2 py-1 rounded-full hover:bg-blue-200"
            >
              스폰서
            </button>
          </div>
          <div class="bg-gray-100 p-3">
            <div class="flex items-center mb-2">
              <div class="w-8 h-8 bg-gray-400 rounded-full mr-2"></div>
              <span class="font-semibold text-sm">쌍용 파이널 테스트</span>
            </div>
            <p class="text-sm mb-2">테스트 입니다</p>
          </div>
          <div class="p-3 flex justify-between text-xs text-gray-500">
            <span><i class="far fa-thumbs-up"></i> 0</span>
            <span><i class="far fa-comment"></i> 0</span>
          </div>
        </div>
      </div>
      <button
        class="mt-4 text-blue-600 hover:underline text-sm font-semibold w-full text-center py-2"
      >
        모두 표시
      </button>
    </div>

    <div class="card p-4">
      <h2 class="text-lg font-semibold text-gray-800 mb-4">실적 파악</h2>
      <p class="text-sm text-gray-600 mb-4">
        지난 7일 활동을 활용하여 페이지를 최적화하세요.
      </p>
      <div class="grid grid-cols-2 sm:grid-cols-4 gap-4 text-center">
        <div>
          <p class="text-2xl font-bold text-blue-600">7</p>
          <p class="text-sm text-gray-600">검색 결과 노출</p>
          <p class="text-xs text-green-600">+38% 지난 7일</p>
        </div>
        <div>
          <p class="text-2xl font-bold text-blue-600">0</p>
          <p class="text-sm text-gray-600">새 팔로워</p>
          <p class="text-xs text-gray-500">-</p>
        </div>
        <div>
          <p class="text-2xl font-bold text-blue-600">11</p>
          <p class="text-sm text-gray-600">게시물 노출</p>
          <p class="text-xs text-red-600">-91.5% 지난 7일</p>
        </div>
        <div>
          <p class="text-2xl font-bold text-blue-600">2</p>
          <p class="text-sm text-gray-600">페이지 방문자</p>
          <p class="text-xs text-gray-500">-</p>
        </div>
      </div>
    </div>

    <div class="card p-4">
      <div class="flex justify-between items-center mb-4">
        <h2 class="text-lg font-semibold text-gray-800">대화 참여</h2>
        <div class="flex items-center space-x-2 text-gray-500">
          <button class="hover:text-gray-700">
            <i class="fas fa-chevron-left"></i>
          </button>
          <button class="hover:text-gray-700">
            <i class="fas fa-chevron-right"></i>
          </button>
        </div>
      </div>
      <p class="text-sm text-gray-600 mb-4">
        최근 대화에 참여하여 브랜드 인지도와 커뮤니티를 구축하세요.
      </p>
      <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">
        <div class="border rounded-lg overflow-hidden">
          <div class="p-3">
            <div class="flex items-center mb-2">
              <div
                class="w-8 h-8 bg-green-500 rounded-sm mr-2 flex items-center justify-center text-white font-bold"
              >
                N
              </div>
              <span class="font-semibold text-sm">NVIDIA AI</span>
            </div>
            <p class="text-sm mb-2">
              Register for the NVIDIA Agent Toolkit Hackathon
              <a href="#" class="text-blue-600 hover:underline">더보기</a>
            </p>
            <img
              src="https://placehold.co/300x150/dbeafe/3b82f6?text=[%ED%94%BC%EB%93%9C+%EC%9D%B4%EB%AF%B8%EC%A7%80+1]"
              alt="피드 이미지 1"
              class="w-full h-32 object-cover rounded"
            />
          </div>
          <div
            class="p-3 flex justify-between text-xs text-gray-500 border-t"
          >
            <span><i class="far fa-thumbs-up"></i> 0</span>
            <span><i class="far fa-comment"></i> 0</span>
          </div>
        </div>
        <div class="border rounded-lg overflow-hidden">
          <div class="p-3">
            <div class="flex items-center mb-2">
              <div
                class="w-8 h-8 bg-green-500 rounded-sm mr-2 flex items-center justify-center text-white font-bold"
              >
                N
              </div>
              <span class="font-semibold text-sm">NVIDIA AI</span>
            </div>
            <p class="text-sm mb-2">
              Kaggle Grandmaster Pro Tips: Learn how Chris Deotte won 1st
              place in Kaggle's Playground Backpack Price...
              <a href="#" class="text-blue-600 hover:underline">더보기</a>
            </p>
            <img
              src="https://placehold.co/300x150/d1fae5/10b981?text=[%ED%94%BC%EB%93%9C+%EC%9D%B4%EB%AF%B8%EC%A7%80+2]"
              alt="피드 이미지 2"
              class="w-full h-32 object-cover rounded"
            />
          </div>
          <div
            class="p-3 flex justify-between text-xs text-gray-500 border-t"
          >
            <span><i class="far fa-thumbs-up"></i> 0</span>
            <span><i class="far fa-comment"></i> 0</span>
          </div>
        </div>
        <div class="border rounded-lg overflow-hidden">
          <div class="p-3">
            <div class="flex items-center mb-2">
              <div
                class="w-8 h-8 bg-green-500 rounded-sm mr-2 flex items-center justify-center text-white font-bold"
              >
                N
              </div>
              <span class="font-semibold text-sm">NVIDIA AI</span>
            </div>
            <p class="text-sm mb-2">
              Protein misfolding is often implicated in disease due to
              the...
              <a href="#" class="text-blue-600 hover:underline">더보기</a>
            </p>
          </div>
          <div
            class="p-3 flex justify-between text-xs text-gray-500 border-t"
          >
            <span><i class="far fa-thumbs-up"></i> 0</span>
            <span><i class="far fa-comment"></i> 0</span>
          </div>
        </div>
      </div>
      <button
        class="mt-4 text-blue-600 hover:underline text-sm font-semibold w-full text-center py-2"
      >
        피드 표시
      </button>
    </div>`;
  console.log("대시보드");
}

// 게시물 로드
async function loadPost(contentDiv) {
  contentDiv.innerHTML = `<div class="grid grid-cols-1 md:grid-cols-3 gap-6">
          <div class="md:col-span-2 space-y-6">
            <div class="card p-4">
              <h2 class="text-xl font-semibold text-gray-800">
                페이지 업데이트
              </h2>
              <p class="text-sm text-gray-600 mb-4">
                페이지의 소셜 콘텐츠 및 유료 콘텐츠 관리
              </p>

              <div class="mb-4 border-b border-gray-200">
                <nav class="flex space-x-1 -mb-px" aria-label="Tabs">
                  <button class="tab-active py-3 px-4 text-sm">발행함</button>
                  <button
                    class="tab-inactive hover:border-gray-300 py-3 px-4 text-sm"
                  >
                    페이지 광고
                  </button>
                  <button
                    class="tab-inactive hover:border-gray-300 py-3 px-4 text-sm"
                  >
                    직원 광고
                  </button>
                </nav>
              </div>

              <div class="border border-gray-200 rounded-lg p-3 mb-6">
                <div class="flex items-center">
                  <img
                    src="https://placehold.co/40x40/e0e0e0/777777?text=로고"
                    alt="프로필 아이콘"
                    class="w-10 h-10 rounded-md mr-3"
                  />
                  <input
                    type="text"
                    placeholder="글 올리기"
                    class="w-full border-gray-300 rounded-full shadow-sm focus:border-blue-500 focus:ring-blue-500 p-2 text-sm"
                  />
                </div>
                <div class="flex justify-around mt-3 text-sm text-gray-500">
                  <button
                    class="flex items-center hover:bg-gray-100 p-2 rounded-md transition-colors"
                  >
                    <i class="fas fa-video mr-1 text-green-500"></i> 동영상
                  </button>
                  <button
                    class="flex items-center hover:bg-gray-100 p-2 rounded-md transition-colors"
                  >
                    <i class="fas fa-image mr-1 text-blue-500"></i> 사진
                  </button>
                  <button
                    class="flex items-center hover:bg-gray-100 p-2 rounded-md transition-colors"
                  >
                    <i class="fas fa-file-alt mr-1 text-red-500"></i> 글쓰기
                  </button>
                </div>
              </div>

              <div
                class="bg-blue-50 p-3 rounded-md mb-6 flex justify-between items-center"
              >
                <p class="text-xs text-gray-700">
                  스폰서 업데이트로 등록해서 노출수를 72,000회 더 늘리세요.
                  <i class="fas fa-question-circle text-gray-400"></i>
                </p>
                <button
                  class="text-blue-600 font-semibold hover:underline text-xs px-3 py-1 border border-blue-600 rounded-full hover:bg-blue-100 transition-colors"
                >
                  스폰서
                </button>
              </div>

              <div class="border border-gray-200 rounded-lg mb-6">
                <div class="p-3">
                  <div class="flex justify-between items-start mb-2">
                    <div class="flex items-center">
                      <img
                        src="https://placehold.co/48x48/e0e0e0/777777?text=S"
                        alt="게시물 작성자 프로필"
                        class="w-10 h-10 rounded-md mr-2"
                      />
                      <div>
                        <p class="font-semibold text-sm text-gray-800">
                          쌍용 파이널 테스트
                        </p>
                        <p class="text-xs text-gray-500">팔로워 20명</p>
                        <p class="text-xs text-gray-500">
                          3개월 • <i class="fas fa-globe-americas text-xs"></i>
                        </p>
                      </div>
                    </div>
                    <div class="text-gray-500 flex items-center">
                      <span
                        class="text-xs mr-2 bg-gray-100 px-2 py-0.5 rounded-full"
                        >고정함</span
                      >
                      <button
                        class="hover:bg-gray-100 p-1 rounded-full text-xs"
                      >
                        <i class="fas fa-ellipsis-h"></i>
                      </button>
                    </div>
                  </div>
                  <p class="text-sm text-gray-700 my-3">게시물 테스트</p>
                </div>
                <div
                  class="px-3 pb-2 flex items-center justify-start space-x-1 feed-item-action border-t border-gray-200 pt-2"
                >
                  <button><i class="far fa-thumbs-up mr-1"></i> 추천</button>
                  <button><i class="far fa-comment-dots mr-1"></i> 댓글</button>
                  <button><i class="fas fa-share mr-1"></i> 퍼가기</button>
                </div>
                <div class="bg-gray-50 p-3 border-t border-gray-200">
                  <div class="flex items-center">
                    <img
                      src="https://placehold.co/32x32/cccccc/333333?text=로고"
                      alt="댓글 프로필"
                      class="w-8 h-8 rounded-full mr-2"
                    />
                    <input
                      type="text"
                      placeholder="쌍용 파이널 테스트님으로 댓글 남기기"
                      class="w-full border-gray-300 rounded-full shadow-sm focus:border-blue-500 focus:ring-blue-500 p-2 text-xs"
                    />
                    <button class="ml-2 text-gray-400 hover:text-gray-600">
                      <i class="far fa-smile text-base"></i>
                    </button>
                    <button class="ml-2 text-gray-400 hover:text-gray-600">
                      <i class="far fa-image text-base"></i>
                    </button>
                  </div>
                </div>
                <div
                  class="p-3 flex justify-between items-center text-xs text-gray-500 border-t border-gray-200"
                >
                  <div>
                    <p class="font-semibold text-gray-700">노출수</p>
                    <p>Organic impressions: 369</p>
                  </div>
                  <button
                    class="text-blue-600 hover:underline font-semibold flex items-center"
                  >
                    결과 미리 보기
                    <i class="fas fa-chevron-down ml-1 text-xs"></i>
                  </button>
                </div>
              </div>

              <div class="border border-gray-200 rounded-lg">
                <div class="p-3">
                  <div class="flex justify-between items-start mb-2">
                    <div class="flex items-center">
                      <img
                        src="https://placehold.co/48x48/e0e0e0/777777?text=S"
                        alt="게시물 작성자 프로필"
                        class="w-10 h-10 rounded-md mr-2"
                      />
                      <div>
                        <p class="font-semibold text-sm text-gray-800">
                          쌍용 파이널 테스트
                        </p>
                        <p class="text-xs text-gray-500">팔로워 20명</p>
                        <p class="text-xs text-gray-500">
                          2개월 • <i class="fas fa-globe-americas text-xs"></i>
                        </p>
                      </div>
                    </div>
                    <div class="text-gray-500">
                      <button
                        class="hover:bg-gray-100 p-1 rounded-full text-xs"
                      >
                        <i class="fas fa-ellipsis-h"></i>
                      </button>
                    </div>
                  </div>
                  <p class="text-sm text-gray-700 my-3">
                    두 번째 게시물 내용입니다.
                  </p>
                  <div class="flex space-x-1 mb-3">
                    <span class="text-lg">👍</span>
                    <span class="text-lg">💖</span>
                    <span class="text-lg">😂</span>
                    <span class="text-lg">😮</span>
                  </div>
                </div>
                <div
                  class="px-3 pb-2 flex items-center justify-start space-x-1 feed-item-action border-t border-gray-200 pt-2"
                >
                  <button><i class="far fa-thumbs-up mr-1"></i> 추천</button>
                  <button><i class="far fa-comment-dots mr-1"></i> 댓글</button>
                  <button><i class="fas fa-share mr-1"></i> 퍼가기</button>
                </div>
                <div class="bg-gray-50 p-3 border-t border-gray-200">
                  <div class="flex items-center">
                    <img
                      src="https://placehold.co/32x32/cccccc/333333?text=로고"
                      alt="댓글 프로필"
                      class="w-8 h-8 rounded-full mr-2"
                    />
                    <input
                      type="text"
                      placeholder="쌍용 파이널 테스트님으로 댓글 남기기"
                      class="w-full border-gray-300 rounded-full shadow-sm focus:border-blue-500 focus:ring-blue-500 p-2 text-xs"
                    />
                  </div>
                </div>
                <div
                  class="p-3 flex justify-between items-center text-xs text-gray-500 border-t border-gray-200"
                >
                  <div>
                    <p class="font-semibold text-gray-700">노출수</p>
                    <p>Organic impressions: 225</p>
                  </div>
                  <button
                    class="text-blue-600 hover:underline font-semibold flex items-center"
                  >
                    결과 미리 보기
                    <i class="fas fa-chevron-down ml-1 text-xs"></i>
                  </button>
                </div>
              </div>
            </div>
          </div>

          <div class="md:col-span-1 space-y-6">
            <div class="card p-4">
              <div class="flex justify-between items-center mb-2">
                <h3 class="font-semibold text-gray-800">글 하이라이트</h3>
                <i class="fas fa-question-circle text-gray-400"></i>
              </div>
              <select
                class="w-full border-gray-300 rounded-md shadow-sm p-2 text-xs mb-4 focus:border-blue-500 focus:ring-blue-500"
              >
                <option>최근 30일</option>
                <option>최근 7일</option>
                <option>어제</option>
              </select>
              <img
                src="https://placehold.co/300x150/e2e8f0/94a3b8?text=[하이라이트+그래프]"
                alt="하이라이트 없음"
                class="w-full rounded-md mb-3 object-contain h-32"
                onerror="this.src='https://placehold.co/300x150/e2e8f0/94a3b8?text=이미지+로드+실패';"
              />
              <h4 class="font-semibold text-center text-gray-700">
                하이라이트 없음
              </h4>
              <p class="text-xs text-gray-500 text-center">
                강조할 최근 업데이트가 없습니다.
              </p>
            </div>

            <div class="card p-3">
              <div class="flex items-center">
                <img
                  src="https://placehold.co/32x32/60A5FA/FFFFFF?text=쌍"
                  alt="프로필 이미지"
                  class="w-8 h-8 rounded-full mr-2"
                />
                <div>
                  <p class="font-semibold text-xs text-gray-800">메시지</p>
                  <p class="text-xxs text-gray-500">쌍용 파이널 테스트</p>
                </div>
              </div>
            </div>

            <div class="px-2 py-4 space-y-1 text-center sticky top-60">
              <div
                class="flex flex-wrap gap-x-3 gap-y-1 text-xs text-gray-500 justify-center"
              >
                <a href="#" class="hover:underline">회사 소개</a>
                <a href="#" class="hover:underline">웹 접근성</a>
                <a href="#" class="hover:underline">고객 센터</a>
              </div>
              <div
                class="flex flex-wrap gap-x-3 gap-y-1 text-xs text-gray-500 justify-center"
              >
                <a href="#" class="hover:underline">개인 정보와 약관</a>
                <a href="#" class="hover:underline">Ad Choices</a>
              </div>
              <div
                class="flex flex-wrap gap-x-3 gap-y-1 text-xs text-gray-500 justify-center"
              >
                <a href="#" class="hover:underline">광고</a>
                <a href="#" class="hover:underline"
                  >비즈니스 서비스 <i class="fas fa-chevron-down text-xxs"></i
                ></a>
              </div>
              <div
                class="flex flex-wrap gap-x-3 gap-y-1 text-xs text-gray-500 justify-center"
              >
                <a href="#" class="hover:underline">LinkedIn 앱 다운로드</a>
                <a href="#" class="hover:underline">더 보기</a>
              </div>
              <p class="text-xs text-gray-500 text-center mt-3">
                <img
                  src="https://upload.wikimedia.org/wikipedia/commons/c/ca/LinkedIn_logo_initials.png"
                  alt="LinkedIn 로고"
                  class="inline h-4 mr-1"
                  onerror="this.style.display='none'"
                />
                LinkedIn Corporation © <span id="currentYear"></span>년
              </p>
            </div>
          </div>
        </div>`;
  console.log("게시물");
}

// 분석 로드
async function loadAnalytics(contentDiv) {
  contentDiv.innerHTML = `<div class="card">
                <div class="p-4">
                    <h2 class="text-xl font-semibold text-gray-800 mb-1">분석</h2>
                    <div class="mb-4 border-b border-gray-200">
                        <nav class="flex space-x-1 -mb-px" aria-label="Tabs">
                            <button class="tab-active py-3 px-4 text-sm">내용</button>
                            <button class="tab-inactive hover:border-gray-300 py-3 px-4 text-sm">방문자</button>
                            <button class="tab-inactive hover:border-gray-300 py-3 px-4 text-sm">팔로워</button>
                            <button class="tab-inactive hover:border-gray-300 py-3 px-4 text-sm">리드</button>
                            <button class="tab-inactive hover:border-gray-300 py-3 px-4 text-sm">경쟁사</button>
                        </nav>
                    </div>

                    <div class="flex justify-between items-center mb-6">
                        <div class="relative">
                            <select class="appearance-none bg-white border border-gray-300 text-gray-700 py-2 px-4 pr-8 rounded-md leading-tight focus:outline-none focus:bg-white focus:border-gray-500 text-sm">
                                <option>2025년 4월 7일 - 2025년 5월 6일</option>
                                <option>지난 30일</option>
                                <option>지난 7일</option>
                                <option>사용자 지정</option>
                            </select>
                            <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                                <i class="fas fa-chevron-down text-xs"></i>
                            </div>
                        </div>
                        <button class="bg-blue-600 hover:bg-blue-700 text-white font-semibold py-2 px-4 rounded-md text-sm flex items-center">
                            <i class="fas fa-download mr-2"></i> 다운로드
                        </button>
                    </div>

                    <div class="mb-8">
                        <h3 class="text-lg font-semibold text-gray-800 mb-3">하이라이트</h3>
                        <div class="grid grid-cols-2 md:grid-cols-4 gap-4">
                            <div class="stat-card border border-gray-200 rounded-lg">
                                <p class="stat-value">263</p>
                                <p class="stat-label">노출</p>
                                <p class="stat-change stat-change-positive"><i class="fas fa-arrow-up text-xs"></i> 1,043.5%</p>
                            </div>
                            <div class="stat-card border border-gray-200 rounded-lg">
                                <p class="stat-value">0</p>
                                <p class="stat-label">반응</p>
                                <p class="stat-change stat-change-neutral">0%</p>
                            </div>
                            <div class="stat-card border border-gray-200 rounded-lg">
                                <p class="stat-value">0</p>
                                <p class="stat-label">댓글</p>
                                <p class="stat-change stat-change-neutral">0%</p>
                            </div>
                            <div class="stat-card border border-gray-200 rounded-lg">
                                <p class="stat-value">0</p>
                                <p class="stat-label">퍼감</p>
                                <p class="stat-change stat-change-neutral">0%</p>
                            </div>
                        </div>
                    </div>

                    <div class="mb-8">
                        <div class="flex justify-between items-center mb-3">
                            <h3 class="text-lg font-semibold text-gray-800">통계</h3>
                            <div class="relative">
                                <select class="appearance-none bg-white border border-gray-300 text-gray-700 py-1 px-3 pr-6 rounded-md leading-tight focus:outline-none focus:bg-white focus:border-gray-500 text-xs">
                                    <option>노출</option>
                                    <option>반응</option>
                                    <option>클릭률</option>
                                </select>
                                <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-1 text-gray-700">
                                    <i class="fas fa-chevron-down text-xxs"></i>
                                </div>
                            </div>
                        </div>
                        <div class="border border-gray-200 rounded-lg p-4 h-64 flex items-center justify-center text-gray-400">
                            <p class="text-2xl">그래프 테스트</p>
                        </div>
                        <div class="flex space-x-4 mt-3 text-xs text-gray-600">
                            <div class="flex items-center">
                                <span class="w-3 h-3 bg-green-500 rounded-sm mr-1.5"></span>
                                <span>소셜</span>
                                <span class="font-semibold ml-2">263</span>
                            </div>
                            <div class="flex items-center">
                                <span class="w-3 h-3 border-2 border-dashed border-blue-500 rounded-sm mr-1.5"></span>
                                <span>스폰서</span>
                                <span class="font-semibold ml-2">0</span>
                            </div>
                        </div>
                    </div>

                    <div>
                        <div class="flex justify-between items-center mb-3">
                            <h3 class="text-lg font-semibold text-gray-800 flex items-center">
                                콘텐츠 참여 <i class="fas fa-info-circle text-gray-400 text-xs ml-1.5"></i>
                            </h3>
                            <div class="flex items-center space-x-2">
                                <span class="text-xs text-gray-500">표시:</span>
                                <div class="relative">
                                    <select class="appearance-none bg-white border border-gray-300 text-gray-700 py-1 px-2 pr-5 rounded-md leading-tight focus:outline-none focus:bg-white focus:border-gray-500 text-xs">
                                        <option>10</option>
                                        <option>25</option>
                                        <option>50</option>
                                    </select>
                                    <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-1 text-gray-700">
                                        <i class="fas fa-chevron-down text-xxs"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                         <p class="text-xs text-gray-500 mb-2">기간: 2025년 4월 23일 - 2025년 5월 7일 <i class="fas fa-chevron-down text-xxs ml-1 cursor-pointer"></i></p>
                        <div class="border border-gray-200 rounded-lg p-6 text-center text-gray-500">
                            <p>지정된 시간 범위에 표시할 수 있는 업데이트가 없습니다.</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="px-2 py-4 mt-4 text-center">
                <div class="flex flex-wrap gap-x-3 gap-y-1 text-xs text-gray-500 justify-center">
                    <a href="#" class="hover:underline">회사 소개</a>
                    <a href="#" class="hover:underline">웹 접근성</a>
                    <a href="#" class="hover:underline">고객 센터</a>
                    <a href="#" class="hover:underline">개인 정보와 약관</a>
                    <a href="#" class="hover:underline">Ad Choices</a>
                    <a href="#" class="hover:underline">광고</a>
                    <a href="#" class="hover:underline">비즈니스 서비스 <i class="fas fa-chevron-down text-xxs"></i></a>
                    <a href="#" class="hover:underline">LinkedIn 앱 다운로드</a>
                    <a href="#" class="hover:underline">더 보기</a>
                </div>
                <p class="text-xs text-gray-500 text-center mt-3">
                    <img src="https://upload.wikimedia.org/wikipedia/commons/c/ca/LinkedIn_logo_initials.png" alt="LinkedIn 로고" class="inline h-4 mr-1" onerror="this.style.display='none'">
                    LinkedIn Corporation © <span id="currentYear"></span>년
                </p>
            </div>`;
  console.log("분석");
}

// 피드 로드
async function loadFeed(contentDiv) {
  contentDiv.innerHTML = `<div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                <div class="md:col-span-2 space-y-6">
                    <div class="card p-4">
                        <h2 class="text-xl font-semibold text-gray-800">피드</h2>
                        <p class="text-sm text-gray-600 mb-4">브랜드 인지도 구축을 위해 관련 대화에 참여</p>

                        <div class="border border-gray-200 rounded-lg mb-6">
                            <div class="p-3">
                                <div class="flex items-start mb-2">
                                    <img src="https://placehold.co/40x40/76B900/FFFFFF?text=N" alt="NVIDIA AI 로고" class="w-10 h-10 rounded mr-3">
                                    <div>
                                        <p class="font-semibold text-sm text-gray-800">NVIDIA AI</p>
                                        <p class="text-xs text-gray-500">팔로워 1,254,712명 • 10시간</p>
                                    </div>
                                </div>
                                <p class="text-sm text-gray-700 mb-2">
                                    Squeezing a large data set from a parquet or CSV file into a pandas DataFrame? <a href="#" class="text-blue-600 hover:underline">더 보기</a>
                                </p>
                                <button class="text-xs text-blue-600 hover:underline mb-2">번역 표시</button>
                                <img src="https://placehold.co/600x400/e2e8f0/333333?text=게시물+이미지+(예시)" alt="피드 게시물 이미지" class="w-full rounded-md mb-3 max-h-96 object-contain bg-gray-100">
                            </div>
                            <div class="px-3 pb-2 flex items-center justify-start space-x-1 feed-item-action border-t border-gray-200 pt-2">
                               <button><i class="far fa-thumbs-up mr-1"></i> 추천</button>
                               <button><i class="far fa-comment-dots mr-1"></i> 댓글</button>
                               <button><i class="fas fa-share mr-1"></i> 퍼가기</button>
                            </div>
                            <div class="bg-gray-50 p-3 border-t border-gray-200">
                               <div class="flex items-center">
                                  <img src="https://placehold.co/32x32/cccccc/333333?text=로고" alt="댓글 프로필" class="w-8 h-8 rounded-full mr-2">
                                  <input type="text" placeholder="쌍용 파이널 테스트님으로 댓글 남기기" class="w-full border-gray-300 rounded-full shadow-sm focus:border-blue-500 focus:ring-blue-500 p-2 text-xs" />
                                  <button class="ml-2 text-gray-400 hover:text-gray-600"><i class="far fa-smile text-base"></i></button>
                                  <button class="ml-2 text-gray-400 hover:text-gray-600"><i class="far fa-image text-base"></i></button>
                               </div>
                            </div>
                        </div>

                        <div class="border border-gray-200 rounded-lg mb-6">
                            <div class="p-3">
                                <div class="flex items-start mb-2">
                                     <img src="https://placehold.co/40x40/1D4ED8/FFFFFF?text=F" alt="Five Star Freight Solutions 로고" class="w-10 h-10 rounded-md mr-3">
                                    <div>
                                        <p class="font-semibold text-sm text-gray-800">Five Star Freight Solutions</p>
                                        <p class="text-xs text-gray-500">9시간</p>
                                    </div>
                                </div>
                                <p class="text-sm text-gray-700 mb-2 break-all">
                                    https://www.linkedin.com/posts/activity-7326013165362647040-IRpH?utm_source=share&utm_medium=member_desktop/rcm-ACDAAA67DYMBm53pGs71L-FZ6md9VrMMY2f6Zpo
                                </p>
                                <button class="text-xs text-blue-600 hover:underline mb-2">번역 표시</button>
                            </div>
                             <div class="px-3 pb-2 flex items-center justify-start space-x-1 feed-item-action border-t border-gray-200 pt-2">
                               <button><i class="far fa-thumbs-up mr-1"></i> 추천</button>
                               <button><i class="far fa-comment-dots mr-1"></i> 댓글</button>
                               <button><i class="fas fa-share mr-1"></i> 퍼가기</button>
                            </div>
                        </div>

                         <div class="border border-gray-200 rounded-lg">
                            <div class="p-3">
                                <div class="flex items-start mb-2">
                                    <img src="https://placehold.co/40x40/76B900/FFFFFF?text=N" alt="NVIDIA AI 로고" class="w-10 h-10 rounded mr-3">
                                    <div>
                                        <p class="font-semibold text-sm text-gray-800">NVIDIA AI</p>
                                        <p class="text-xs text-gray-500">팔로워 1,254,712명 • 10시간</p>
                                    </div>
                                </div>
                                <p class="text-sm text-gray-700 mb-2">
                                    Hear from Abhishek Singh, Senior Software Engineer at NxtGen Cloud Technologies, share his transformative journey with NVIDIA Training at AI Summit India. <a href="#" class="text-blue-600 hover:underline">더 보기</a>
                                </p>
                                <button class="text-xs text-blue-600 hover:underline mb-2">번역 표시</button>
                                <div class="border rounded-lg overflow-hidden">
                                    <img src="https://placehold.co/600x338/333333/FFFFFF?text=Meet+NVIDIA+Training+Customers" alt="NVIDIA Training Customers" class="w-full h-auto object-cover">
                                    <div class="p-2 bg-gray-50 text-xs">
                                        <p class="font-semibold text-gray-700">Meet NVIDIA Training Customers: Interview with NxtGen Cloud Technologies</p>
                                        <p class="text-gray-500">googleusercontent.com/youtube.com</p>
                                    </div>
                                </div>
                            </div>
                            <div class="px-3 pb-2 flex items-center justify-between text-xs text-gray-500 border-t border-gray-200 pt-2">
                                <span class="flex items-center"><i class="fas fa-thumbs-up text-blue-500 mr-1"></i> 20</span>
                                <span>댓글 2</span>
                            </div>
                            <div class="px-3 pb-2 flex items-center justify-start space-x-1 feed-item-action border-t border-gray-200 pt-2">
                               <button><i class="far fa-thumbs-up mr-1"></i> 추천</button>
                               <button><i class="far fa-comment-dots mr-1"></i> 댓글</button>
                               <button><i class="fas fa-share mr-1"></i> 퍼가기</button>
                            </div>
                             <div class="bg-gray-50 p-3 border-t border-gray-200">
                               <div class="flex items-center">
                                  <img src="https://placehold.co/32x32/cccccc/333333?text=로고" alt="댓글 프로필" class="w-8 h-8 rounded-full mr-2">
                                  <input type="text" placeholder="쌍용 파이널 테스트님으로 댓글 남기기" class="w-full border-gray-300 rounded-full shadow-sm focus:border-blue-500 focus:ring-blue-500 p-2 text-xs" />
                               </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="md:col-span-1 space-y-6">
                    <div class="card p-4">
                        <h3 class="font-semibold text-gray-800 mb-3">페이지 팔로우 업데이트</h3>
                        <button class="w-full text-blue-600 hover:underline text-xs py-1.5 rounded-md hover:bg-gray-100 mb-3">
                            팔로잉 관리
                        </button>

                        <div class="flex items-center justify-between py-2 border-b border-gray-100">
                            <div class="flex items-center">
                                <img src="https://placehold.co/32x32/EA4335/FFFFFF?text=G" alt="Google DeepMind 로고" class="w-8 h-8 rounded-sm mr-2">
                                <div>
                                    <p class="font-semibold text-xs text-gray-800">Google DeepMind</p>
                                    <p class="text-xxs text-gray-500">연구 서비스 • London</p>
                                    <p class="text-xxs text-gray-500">팔로워 1,193,001명</p>
                                </div>
                            </div>
                            <button class="text-blue-600 hover:bg-blue-100 border border-blue-600 rounded-full px-3 py-0.5 text-xs font-semibold">
                                <i class="fas fa-plus"></i> 팔로우
                            </button>
                        </div>
                         <div class="flex items-center justify-between py-2 border-b border-gray-100">
                            <div class="flex items-center">
                                <img src="https://placehold.co/32x32/FFD017/000000?text=H" alt="Hugging Face 로고" class="w-8 h-8 rounded-sm mr-2">
                                <div>
                                    <p class="font-semibold text-xs text-gray-800">Hugging Face</p>
                                    <p class="text-xxs text-gray-500">소프트웨어 개발</p>
                                    <p class="text-xxs text-gray-500">팔로워 950,618명</p>
                                </div>
                            </div>
                            <button class="text-blue-600 hover:bg-blue-100 border border-blue-600 rounded-full px-3 py-0.5 text-xs font-semibold">
                                <i class="fas fa-plus"></i> 팔로우
                            </button>
                        </div>
                        <div class="flex items-center justify-between py-2">
                            <div class="flex items-center">
                                <img src="https://placehold.co/32x32/E62B1E/FFFFFF?text=T" alt="TED-Ed 로고" class="w-8 h-8 rounded-sm mr-2">
                                <div>
                                    <p class="font-semibold text-xs text-gray-800">TED-Ed</p>
                                    <p class="text-xxs text-gray-500">E-러닝 공급사 • NY</p>
                                    <p class="text-xxs text-gray-500">팔로워 381,373명</p>
                                </div>
                            </div>
                            <button class="text-blue-600 hover:bg-blue-100 border border-blue-600 rounded-full px-3 py-0.5 text-xs font-semibold">
                                <i class="fas fa-plus"></i> 팔로우
                            </button>
                        </div>
                        <button class="w-full text-blue-600 hover:underline text-xs py-1.5 mt-2 rounded-md hover:bg-gray-100">
                            모두 표시 <i class="fas fa-arrow-right text-xxs ml-1"></i>
                        </button>
                    </div>

                    <div class="card p-3 sticky top-6"> <div class="flex justify-between items-center mb-1">
                            <span class="text-xs text-gray-500">Sponsored</span>
                            <i class="fas fa-ellipsis-h text-gray-400"></i>
                        </div>
                        <div class="flex items-start mb-2">
                            <img src="https://placehold.co/40x40/6666FF/FFFFFF?text=J" alt="Jibin Park" class="w-10 h-10 rounded-md mr-2" onerror="this.src='https://placehold.co/40x40/6666FF/FFFFFF?text=J+오류';">
                            <div>
                                <p class="font-semibold text-xs text-gray-800">Jibin Park</p>
                                <p class="text-xs text-gray-500">안녕하세요. <span class="font-bold">규</span></p>
                            </div>
                        </div>
                        <p class="text-xs text-gray-700 mb-2">
                           스펙터 박지빈입니다. HR Tech 기업 릭터에서 면접자를 위한 세계 최초 AI 면접 분석 앱 TEO를 출시했습니다. 이제 직무 인터뷰에서 더 이상 메모하지 않으셔도 됩니다. 면접에 집중하세요.
                        </p>
                        <img src="https://placehold.co/300x100/d1fae5/10b981?text=[광고+이미지]" alt="광고 이미지" class="w-full rounded-md object-cover h-20 mb-2" onerror="this.src='https://placehold.co/300x100/d1fae5/10b981?text=광고+오류';">
                         <button class="w-full text-xs text-blue-600 hover:bg-blue-50 py-1.5 rounded-md border border-blue-600 font-semibold">
                            지금 바로 면접 분석하기
                        </button>
                    </div>

                    <div class="px-2 py-4 space-y-1 text-center sticky top-80"> <div class="flex flex-wrap gap-x-3 gap-y-1 text-xs text-gray-500 justify-center">
                            <a href="#" class="hover:underline">회사 소개</a>
                            <a href="#" class="hover:underline">웹 접근성</a>
                            <a href="#" class="hover:underline">고객 센터</a>
                        </div>
                        <div class="flex flex-wrap gap-x-3 gap-y-1 text-xs text-gray-500 justify-center">
                            <a href="#" class="hover:underline">개인 정보와 약관</a>
                            <a href="#" class="hover:underline">Ad Choices</a>
                        </div>
                        <div class="flex flex-wrap gap-x-3 gap-y-1 text-xs text-gray-500 justify-center">
                            <a href="#" class="hover:underline">광고</a>
                            <a href="#" class="hover:underline">비즈니스 서비스 <i class="fas fa-chevron-down text-xxs"></i></a>
                        </div>
                         <div class="flex flex-wrap gap-x-3 gap-y-1 text-xs text-gray-500 justify-center">
                            <a href="#" class="hover:underline">LinkedIn 앱 다운로드</a>
                            <a href="#" class="hover:underline">더 보기</a>
                        </div>
                        <p class="text-xs text-gray-500 text-center mt-3">
                            <img src="https://upload.wikimedia.org/wikipedia/commons/c/ca/LinkedIn_logo_initials.png" alt="LinkedIn 로고" class="inline h-4 mr-1" onerror="this.style.display='none'">
                            LinkedIn Corporation © <span id="currentYear"></span>년
                        </p>
                    </div>
                </div>
            </div>`;
  console.log("피드");
}

// 활동 로드
async function loadActivity(contentDiv) {
  contentDiv.innerHTML = `<div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                <div class="md:col-span-2 space-y-6">
                    <div class="card p-4">
                        <h2 class="text-xl font-semibold text-gray-800">활동</h2>
                        <p class="text-sm text-gray-600 mb-4">페이지 주변의 활동 추적</p>

                        <div class="mb-4 border-b border-gray-200">
                            <nav class="flex space-x-1 -mb-px overflow-x-auto" aria-label="Tabs">
                                <button class="tab-active py-3 px-4 text-sm whitespace-nowrap">전체</button>
                                <button class="tab-inactive hover:border-gray-300 py-3 px-4 text-sm whitespace-nowrap">댓글</button>
                                <button class="tab-inactive hover:border-gray-300 py-3 px-4 text-sm whitespace-nowrap">태그</button>
                                <button class="tab-inactive hover:border-gray-300 py-3 px-4 text-sm whitespace-nowrap">반응</button>
                                <button class="tab-inactive hover:border-gray-300 py-3 px-4 text-sm whitespace-nowrap">퍼감</button>
                                <button class="tab-inactive hover:border-gray-300 py-3 px-4 text-sm whitespace-nowrap">분석</button>
                            </nav>
                        </div>

                        <div>
                            <div class="activity-item">
                                <img src="https://placehold.co/40x40/e2e8f0/64748b?text=방문" alt="방문자 아이콘" class="w-10 h-10 rounded-md mr-3">
                                <div class="flex-grow">
                                    <p class="text-sm text-gray-700">쌍용 파이널 테스트에 신규 방문자 1명 생김</p>
                                    <button class="text-xs text-blue-600 border border-blue-600 rounded-full px-3 py-0.5 mt-1 hover:bg-blue-50">방문자 분석 보기</button>
                                </div>
                                <span class="text-xs text-gray-500 ml-4 whitespace-nowrap">2일</span>
                            </div>
                            <div class="activity-item">
                                <img src="https://placehold.co/40x40/e2e8f0/64748b?text=방문" alt="방문자 아이콘" class="w-10 h-10 rounded-md mr-3">
                                <div class="flex-grow">
                                    <p class="text-sm text-gray-700">쌍용 파이널 테스트에 신규 방문자 1명 생김</p>
                                    <button class="text-xs text-blue-600 border border-blue-600 rounded-full px-3 py-0.5 mt-1 hover:bg-blue-50">방문자 분석 보기</button>
                                </div>
                                <span class="text-xs text-gray-500 ml-4 whitespace-nowrap">1주</span>
                            </div>
                            <div class="activity-item">
                                <img src="https://placehold.co/40x40/e2e8f0/64748b?text=방문" alt="방문자 아이콘" class="w-10 h-10 rounded-md mr-3">
                                <div class="flex-grow">
                                    <p class="text-sm text-gray-700">쌍용 파이널 테스트에 신규 방문자 2명 생김</p>
                                    <button class="text-xs text-blue-600 border border-blue-600 rounded-full px-3 py-0.5 mt-1 hover:bg-blue-50">방문자 분석 보기</button>
                                </div>
                                <span class="text-xs text-gray-500 ml-4 whitespace-nowrap">2주</span>
                            </div>
                            <div class="activity-item">
                                <img src="https://placehold.co/40x40/e2e8f0/64748b?text=방문" alt="방문자 아이콘" class="w-10 h-10 rounded-md mr-3">
                                <div class="flex-grow">
                                    <p class="text-sm text-gray-700">쌍용 파이널 테스트에 신규 방문자 5명 생김</p>
                                    <button class="text-xs text-blue-600 border border-blue-600 rounded-full px-3 py-0.5 mt-1 hover:bg-blue-50">방문자 분석 보기</button>
                                </div>
                                <span class="text-xs text-gray-500 ml-4 whitespace-nowrap">3주</span>
                            </div>
                            </div>
                    </div>
                </div>

                <div class="md:col-span-1 space-y-6">
                    <div class="card p-4">
                        <div class="flex justify-between items-center mb-2">
                            <h3 class="font-semibold text-gray-800">글 하이라이트</h3>
                            <i class="fas fa-question-circle text-gray-400"></i>
                        </div>
                        <select class="w-full border-gray-300 rounded-md shadow-sm p-2 text-xs mb-4 focus:border-blue-500 focus:ring-blue-500">
                            <option>최근 30일</option>
                            <option>최근 7일</option>
                            <option>어제</option>
                        </select>
                        <img src="https://placehold.co/300x150/e2e8f0/94a3b8?text=[하이라이트+그래프]" alt="하이라이트 없음" class="w-full rounded-md mb-3 object-contain h-32" onerror="this.src='https://placehold.co/300x150/e2e8f0/94a3b8?text=이미지+로드+실패';">
                        <h4 class="font-semibold text-center text-gray-700">하이라이트 없음</h4>
                        <p class="text-xs text-gray-500 text-center">강조할 최근 업데이트가 없습니다.</p>
                    </div>

                    <div class="px-2 py-4 space-y-1 text-center sticky top-60"> <div class="flex flex-wrap gap-x-3 gap-y-1 text-xs text-gray-500 justify-center">
                            <a href="#" class="hover:underline">회사 소개</a>
                            <a href="#" class="hover:underline">웹 접근성</a>
                            <a href="#" class="hover:underline">고객 센터</a>
                        </div>
                        <div class="flex flex-wrap gap-x-3 gap-y-1 text-xs text-gray-500 justify-center">
                            <a href="#" class="hover:underline">개인 정보와 약관</a>
                            <a href="#" class="hover:underline">Ad Choices</a>
                        </div>
                        <div class="flex flex-wrap gap-x-3 gap-y-1 text-xs text-gray-500 justify-center">
                            <a href="#" class="hover:underline">광고</a>
                            <a href="#" class="hover:underline">비즈니스 서비스 <i class="fas fa-chevron-down text-xxs"></i></a>
                        </div>
                         <div class="flex flex-wrap gap-x-3 gap-y-1 text-xs text-gray-500 justify-center">
                            <a href="#" class="hover:underline">LinkedIn 앱 다운로드</a>
                            <a href="#" class="hover:underline">더 보기</a>
                        </div>
                        <p class="text-xs text-gray-500 text-center mt-3">
                            <img src="https://upload.wikimedia.org/wikipedia/commons/c/ca/LinkedIn_logo_initials.png" alt="LinkedIn 로고" class="inline h-4 mr-1" onerror="this.style.display='none'">
                            LinkedIn Corporation © <span id="currentYear"></span>년
                        </p>
                    </div>
                </div>
            </div>
        </div>`;
  console.log("활동");
}

// 메세지 로드
async function loadMessage(contentDiv) {
  contentDiv.innerHTML = `<div class="card p-4 space-y-3">메세지</div>`;
  console.log("메세지");
}

// 페이지 내용 로드
// 페이지 내용 로드 (수정)
async function loadPageContent(contentDiv) {
  const companyUpdateDialog = document.getElementById("companyUpdateDialog");

  // 모달을 열기 전에 최신 회사 정보를 불러와 폼에 채웁니다.
  await fetchCompanyInfoForUpdate();

  companyUpdateDialog.showModal();
  console.log("페이지 내용 수정 모달 열기");
}

// 채용 로드
async function loadHiring(contentDiv) {
  contentDiv.innerHTML = `<div class="card p-4 space-y-3">채용</div>`;
  console.log("채용");
}

// 프리미엄 로드
async function loadPremium(contentDiv) {
  contentDiv.innerHTML = `<div class="card p-4 space-y-3">프리미엄</div>`;
  console.log("프리미엄");
}

// 광고 로드
async function loadAdvertisement(contentDiv) {
  contentDiv.innerHTML = `<div class="card p-4 space-y-3">광고</div>`;
  console.log("광고");
}

// 설정 로드
async function loadSetting(contentDiv) {
  contentDiv.innerHTML = `<div class="card p-4 space-y-3">설정</div>`;
  console.log("설정");
}
