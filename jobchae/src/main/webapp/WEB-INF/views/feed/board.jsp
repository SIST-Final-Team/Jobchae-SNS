<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String ctxPath = request.getContextPath();
%>    
<jsp:include page="/WEB-INF/views/header/header.jsp" />

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/feed/board.css" />

<!-- Quill 에디터 CSS 추가 -->
<link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">

<script src="https://cdn.quilljs.com/1.3.6/quill.min.js"></script>

<style type="text/tailwindcss">
        html {
            font-size: 0.9rem;
        }
        .h1 {
            @apply text-[1.35rem] font-bold;
        }
        .border-normal {
            @apply border-1 border-gray-300 rounded-lg bg-white;
        }
        .border-search-board {
            @apply border-1 border-gray-300 rounded-lg bg-white;

            &>div:not(:last-child) {
                @apply border-b-4 border-gray-200 space-y-2;
            }

            &>div:not(.py-0) {
                @apply py-4;
            }
            
            &>div>*:not(.px-0) {
                @apply px-4;
            }

            .button-more {
                @apply rounded-b-lg py-2 text-center font-bold text-lg w-full cursor-pointer hover:bg-gray-100 transition-all duration-200;
            }
        }
        .border-board {
            @apply space-y-4;

            &>div {
                @apply border-1 border-gray-300 rounded-lg space-y-2 bg-white;
            }

            &>div {
                @apply pt-4;
                @apply pb-2;
            }
            
            &>div>*:not(.px-0) {
                @apply px-4;
            }

            .button-more {
                @apply rounded-b-lg py-2 text-center font-bold text-lg w-full cursor-pointer hover:bg-gray-100 transition-all duration-200;
            }
        }
		.border-write {
            @apply space-y-4;

            &>div {
                @apply border-1 border-gray-300 rounded-lg space-y-2 bg-white;
            }

            &>div {
                @apply pt-4;
                @apply pb-2;
            }
            
            &>div>*:not(.px-0) {
                @apply px-4;
            }

            .button-more {
                @apply rounded-b-lg py-2 text-center font-bold text-lg w-full cursor-pointer hover:bg-gray-100 transition-all duration-200;
            }
        }
        .nav-selected {
            @apply relative before:inline-block before:absolute before:w-0.5 before:h-10 before:bg-green-800 before:mr-2 before:left-0 before:top-1/2 before:-translate-y-1/2;
        }
        .nav {
            @apply list-none pb-2 [&>li]:px-4 [&>li]:hover:bg-gray-100 [&>li]:cursor-pointer [&>li>a]:block [&>li>a]:py-2;
        }
        .border-list {
            @apply my-0.5 space-y-4 py-4;
            @apply first:border-1 first:border-gray-300 first:rounded-t-lg;
            @apply not-first:border-1 not-first:border-gray-300;
            @apply last:border-1 last:border-gray-300 last:rounded-b-lg;
        }
        .button-gray:not(.button-selected) {
            @apply border-1 rounded-full border-gray-400 px-3 py-0.5 font-bold text-gray-700 text-lg;
            @apply hover:bg-gray-100 hover:inset-ring-1 hover:inset-ring-gray-400 transition-all duration-200;
            @apply hover:cursor-pointer;
        }
        .button-orange:not(.button-selected) {
            @apply border-1 rounded-full border-orange-500 px-3 py-0.5 font-bold text-orange-500 text-lg;
            @apply hover:bg-gray-100 hover:inset-ring-1 hover:inset-ring-orange-500 transition-all duration-200;
            @apply hover:cursor-pointer;
        }
        .button-selected {
            @apply border-1 border-orange-400 rounded-full px-3 py-0.5 font-bold text-white text-lg bg-orange-400;
            @apply hover:bg-orange-500 hover:border-orange-500 transition-all duration-200;
            @apply hover:cursor-pointer;
        }
        .board-member-profile {
            @apply flex gap-4;

            /* 프로필 이미지 */
            div:first-child>a>img {
                @apply w-15 h-15 object-cover;
            }

            div:nth-child(2) span {
                @apply block text-gray-600 text-sm;
            }

            div:nth-child(2) span:first-child {
                @apply font-bold text-lg text-black;
            }

            /* 프로필 정보 및 팔로우 버튼 */
            div:nth-child(3) {
                @apply flex items-start;

                button {
                    @apply px-4 py-1 text-lg rounded-full;
                }

                button:hover {
                    @apply bg-gray-100 cursor-pointer;
                }

                /* 팔로우 버튼 */
                .follow-button {
                    @apply text-orange-500 font-bold;
                }
                
                /* 팔로우 버튼 */
                .unfollow-button {
                    @apply text-black;
                }
            }
        }

        .file-image {
            @apply grid grid-flow-row-dense grid-flow-col gap-1 p-0.5;

            :hover {
                @apply cursor-pointer;
            }

            button:first-child {
                @apply max-h-[50rem] m-auto col-span-3;
            }
            button:not(:first-child) {
                @apply m-auto;
            }
            
            button:not(:first-child)>img {
                @apply object-cover aspect-[3/2];
            }
            button.more-image {
                @apply relative;
            }
            button.more-image>img {
                @apply brightness-50;
            }
            button.more-image>span {
                @apply absolute text-white;
                @apply top-1/2 -translate-y-1/2 left-1/2 -translate-x-1/2;
            }
        }

        .reaction-images {
            @apply flex items-center;
            img {
                @apply w-6 rounded-full border-2 border-white;
            }
            img:not(img:last-child) {
                @apply -mr-2;
            }
        }

        .button-underline {
            @apply flex hover:cursor-pointer hover:underline hover:text-orange-500;
        }

        .button-board-action {
            @apply w-full h-10 rounded-md font-bold hover:cursor-pointer hover:bg-gray-100;
        }

		.button-board-attach {
            @apply w-full h-10 rounded-md font-bold hover:cursor-pointer hover:bg-gray-100;
        }

</style>
    
<script type="text/javascript">
    
    $(document).ready(function() {
        	
		/////////////////////////////////////////////////////////////////////////////////////////
	 	
    	// 글 옵션
	    $(".more-options").click(function (e) {
	        e.stopPropagation(); 
	        let dropdown = $(this).siblings(".options-dropdown");
	        $(".options-dropdown").not(dropdown).hide(); 
	        dropdown.toggle(); 
	    });
		
	    $(document).click(function () {
	        $(".options-dropdown").hide();
	    });
	    
	 	// 글 삭제
	    $(".delete-post").click(function () {
	    	
	    	const board_no = $(this).attr("value");
	        //alert("글 삭제 (board_no: " + board_no + ")");

	        const confirmDelete = confirm("글을 삭제하시겠습니까?");
		    if (!confirmDelete) {
		        return; 
		    }
		    
			$.ajax({
				url: '${pageContext.request.contextPath}/board/delete',
				type: 'post',
				data: {"board_no": board_no},
				success: function(response) {
		            alert("글이 삭제되었습니다.");
		            location.reload(); 
		        },
		        error: function(request, status, error){
					alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
			 	}
			});
	    });
	 	
	 	// 글 수정
	    $(".edit-post").click(function () {
	    	let board_no = $(this).attr("value");
	        alert("게시글 수정 (board_no: " + board_no + ")");
	    });
	 
	 	// 게시글 허용범위
	    $(".set-board-range").click(function () {
	    	let board_no = $(this).attr("value");
	        alert("게시글 허용범위 (board_no: " + board_no + ")");
	    });
	    
	    // 댓글 허용범위
	    $(".set-comment-range").click(function () {
	    	let board_no = $(this).attr("value");
	        alert("댓글 허용범위 (board_no: " + board_no + ")");
	        // 설정 팝업
	    });
	 	
	 	
	});

</script>


<div class="container m-auto grid grid-cols-14 gap-6 xl:max-w-[1140px]">

		
        <!-- 좌측 네비게이션 -->
        <div class="left-side col-span-3 hidden md:block h-full relative">
            <div class="border-normal sticky top-20">
                <h1 class="h1 p-4">이 페이지에는</h1>
                <ul class="nav">
                    <li class="nav-selected"><a href="#update">업데이트</a></li>
                    <li><a href="#member">사람</a></li>
                    <li><a href="#company">회사</a></li>
                    <li><a href="#updateMore">업데이트 더보기</a></li>
                </ul>
            </div>
        </div>

        
        <!-- 중앙 본문 -->
        <div class="center col-span-14 md:col-span-7 space-y-2 m-5">

			<div id="write" class="border-write">
			
				<div>
                    <!-- 멤버 프로필 -->                                                              
                    <div class="board-member-profile">
                        <div>
                            <a href="#"><img src="<%= ctxPath%>/images/쉐보레전면.jpg" /></a>
                        </div>
                        <div class="flex-1">
                        	<!-- 글 작성 -->
	                        <button class="write-button">                   
	                            <span>
	                                <span>
	                                    <span class="write-span">
	                                        <strong><!---->업데이트 쓰기<!----></strong>
	                                    </span>
	                                </span>  
	                            </span>
	                        </button>
                        </div>
                    </div>


                    <hr class="border-gray-300 mx-4">
                    <!-- 추천 댓글 퍼가기 등 버튼 -->
                    <div class="py-0">
                        <ul class="grid grid-cols-2 gap-4 text-center">
                            <li>
                                <button type="button" class="button-board-attach flex justify-center items-center space-x-2">
									<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" id="image-medium" class="hidden-svg" aria-hidden="true" role="none" data-supported-dps="24x24" fill="currentColor" type="image">
									  <path d="M19 4H5a3 3 0 00-3 3v10a3 3 0 003 3h14a3 3 0 003-3V7a3 3 0 00-3-3zm1 13a1 1 0 01-.29.71L16 14l-2 2-6-6-4 4V7a1 1 0 011-1h14a1 1 0 011 1zm-2-7a2 2 0 11-2-2 2 2 0 012 2z"></path>
									</svg>
                                    <span>사진</span>
                                </button>
                            </li>
                            <li>
                                <button type="button" class="button-board-attach flex justify-center items-center space-x-2">
	                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" id="video-medium" class="hidden-svg" aria-hidden="true" role="none" data-supported-dps="24x24" fill="currentColor" type="video">
									  <path d="M19 4H5a3 3 0 00-3 3v10a3 3 0 003 3h14a3 3 0 003-3V7a3 3 0 00-3-3zm-9 12V8l6 4z"></path>
									</svg>
                                    <span>동영상</span>
                                </button>
                            </li>
                        </ul>
                    </div>
                </div>
			</div>
			
			
			
            <div id="update" class="border-board">
                <!-- 게시물 동적으로 생성 -->
                <c:forEach var="board" items="${boardvo}">
                	<div>
	                    <!-- 멤버 프로필 -->                                                              
	                    <div class="board-member-profile">
	                        <div>
	                            <a href="#"><img src="<%= ctxPath%>/images/쉐보레전면.jpg" /></a>
	                        </div>
	                        <div class="flex-1">
	                            <a href="#">
	                                <c:choose>
					        			<c:when test="${membervo.member_id == board.fk_member_id}">
					        				<p class="feed-post-name">${board.member_name} · 나</p> 
					        			</c:when>
					        			<c:otherwise>
					        				<p class="feed-post-name">${board.member_name}</p> 
					        			</c:otherwise>
					        		</c:choose>
	                                <span>팔로워 26,549명</span>
	                            </a>
	                            <span>1년</span>
	                        </div>
	                        <div style="position: relative;">
	                            <button type="button" class="follow-button">
	                            	<c:choose>
	                            		<c:when test="${membervo.member_id != board.fk_member_id}">
	                            			<i class="fa-solid fa-plus"></i>&nbsp;팔로우
	                            		</c:when>
	                            		<c:otherwise>
	                            		</c:otherwise>
	                            	</c:choose>
                            	</button>
	                            <button type="button"><i class="fa-solid fa-ellipsis"></i></button>
	                            
	                            <button class="more-options"><img class="more-options-img" src="<%= ctxPath%>/images/feed/more.png" /></button>
				        		<!-- 옵션 드롭다운 메뉴 -->
					            <div class="options-dropdown">
					                <ul>
					                    <c:choose>
								            <c:when test="${membervo.member_id == board.fk_member_id}">
								                <li class="delete-post" value="${board.board_no}">글 삭제</li>
								            	<li class="edit-post" value="${board.board_no}">글 수정</li>
								                <li class="set-board-range" value="${board.board_no}">게시글 허용범위</li>
								                <li class="set-comment-range" value="${board.board_no}">댓글 허용범위</li>
								            </c:when>
								            <c:otherwise>
								            	<li class="bookmark-post" value="${board.board_no}">북마크</li>
								                <li class="interest-none" value="${board.board_no}">관심없음</li>
								            </c:otherwise>
								        </c:choose>
					                </ul>
					            </div> <!-- div.options-dropdown 끝 -->
	                        </div>
	                    </div>
	                    <!-- 글 내용 -->
	                    <div>
	                        <p>${board.board_content}</p>
	                    </div>
	                    <!-- 사진 또는 동영상 등 첨부파일 -->
	                    <div class="px-0">
	                        <div class="file-image">
	                            <button type="button"><img src="<%= ctxPath%>/images/4.png"/></button>
	                            <button type="button"><img src="<%= ctxPath%>/images/6.png"/></button>
	                            <button type="button"><img src="<%= ctxPath%>/images/7.png"/></button>
	                            <button type="button" class="more-image"><img src="<%= ctxPath%>/images/240502-Gubi-Showroom-London-003-Print.jpg"/>
	                                <span class="flex items-center">
	                                    <span><i class="fa-solid fa-plus"></i></span>
	                                    <span class="text-4xl">3</span>
	                                </span>
	                            </button>
	                        </div>
	                    </div>
	                    <!-- 반응 및 댓글 수(아무 반응 및 댓글이 없으면 표시하지 않음, 댓글만 있으면 댓글만 표시 등) -->
	                    <div>
	                        <ul class="flex gap-4 text-gray-600">
	                            <li class="flex-1">
	                                <button type="button" class="button-underline">
	                                    <div class="reaction-images">
	                                        <img src="<%= ctxPath%>/images/emotion/like_small.svg"/>
	                                        <img src="<%= ctxPath%>/images/emotion/celebrate_small.svg"/>
	                                        <img src="<%= ctxPath%>/images/emotion/insightful_small.svg"/>
	                                    </div>
	                                    <span id="reactionCount">120</span>
	                                </button>
	                            </li>
	                            <li>
	                                <button type="button" class="button-underline">
	                                    <span>댓글&nbsp;</span>
	                                    <span id="commentCount">1,205</span>
	                                </button>
	                            </li>
	                            <li>
	                                <button type="button" class="button-underline">
	                                    <span>퍼감&nbsp;</span>
	                                    <span id="commentCount">4</span>
	                                </button>
	                            </li>
	                        </ul>
	                    </div>
	
	                    <hr class="border-gray-300 mx-4">
	                    <!-- 추천 댓글 퍼가기 등 버튼 -->
	                    <div class="py-0">
	                        <ul class="grid grid-cols-4 gap-4 text-center">
	                            <li>
	                                <button type="button" class="button-board-action">
	                                    <i class="fa-regular fa-thumbs-up"></i>
	                                    <span>추천</span>
	                                </button>
	                            </li>
	                            <li>
	                                <button type="button" class="button-board-action">
	                                    <i class="fa-regular fa-comment"></i>
	                                    <span>댓글</span>
	                                </button>
	                            </li>
	                            <li>
	                                <button type="button" class="button-board-action">
	                                    <i class="fa-solid fa-retweet"></i>
	                                    <span>퍼가기</span>
	                                </button>
	                            </li>
	                            <li>
	                                <button type="button" class="button-board-action">
	                                    <i class="fa-regular fa-paper-plane"></i>
	                                    <span>보내기</span>
	                                </button>
	                            </li>
	                        </ul>
	                    </div>
	                </div>
               	</c:forEach>
           	</div>
       	</div>
                
         
        <!-- 우측 광고 -->
        <div class="right-side col-span-4 h-full relative hidden lg:block">
            <div class="border-list sticky top-20 space-y-2 text-center relative bg-white">
                <div class="absolute top-5 right-5 bg-white rounded-sm text-[0.9rem]">
                    <span class="pl-1.5 font-bold">광고</span>
                    <button type="button" class="font-bold hover:bg-gray-100 cursor-pointer px-1.5 py-1 rounded-r-sm"><i class="fa-solid fa-ellipsis"></i></button>
                </div>
                <div>
                    <img src="<%= ctxPath%>/images/7.png"/>
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
