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
        
    	$(".options-dropdown").hide();
    	
		/////////////////////////////////////////////////////////////////////////////////////////
		// 글 작성 Modal 
        const writeModal = document.getElementById("writeModal");
        const editModal = document.getElementById("editModal");
        writeModal.style.display = "none";
        editModal.style.display = "none";
        
        $("button.write-button").click(function() {

        	var visibilityStatus = document.getElementById("visibilityStatus");
            var boardVisibilityInput = $("input[name='board_visibility']");
            
            visibilityStatus.textContent = "전체공개";
            boardVisibilityInput.val("1"); 
            
            writeModal.style.display = "block";
        });
        
        $("span#closeModalButton").click(function() {
        	writeModal.style.display = "none";
        	writeQuill.setText('');
        });

        $(window).click(function(e) {
            if (e.target == writeModal) {
            	writeModal.style.display = "none";
            	writeQuill.setText('');
            }
        });
        
        
		/////////////////////////////////////////////////////////////////////////////////////////
     	// Quill 에디터
     	
     	// 글 작성 Quill 에디터
        var writeQuill = new Quill('#writeModal .editor-container', { 
            theme: 'snow',
            modules: {
                toolbar: false
            },
            placeholder: '나누고 싶은 생각이 있으세요?' 
        });
        writeQuill.root.innerHTML = '';
        writeQuill.on('text-change', function() {
            var boardContent = writeQuill.root.innerHTML;  
            $("input[name='board_content']").val(boardContent);  
        });
     	
     	// 글 수정 Quill 에디터
        var editQuill = new Quill('#editModal .editor-container', { 
            theme: 'snow',
            modules: {
                toolbar: false
            },
            placeholder: '나누고 싶은 생각이 있으세요?' 
        });
        editQuill.on('text-change', function() {
            var boardContent = editQuill.root.innerHTML;  
            $("input[name='board_content']").val(boardContent);  
        });
        
        
		/////////////////////////////////////////////////////////////////////////////////////////
		// 공개범위 바꾸기 (전체공개/친구공개) - 글 작성
		$("button#modal-profile-info").click(function() {
			var visibilityStatus = document.getElementById("visibilityStatus");
			var boardVisibilityInput = $("input[name='board_visibility']");
			
		    if (visibilityStatus.textContent === "전체공개") {
		        visibilityStatus.textContent = "친구공개";
		        boardVisibilityInput.val("2");
		    } else {
		        visibilityStatus.textContent = "전체공개";
		        boardVisibilityInput.val("1");
		    }
		});

		// 공개범위 바꾸기 (전체공개/친구공개) - 글 수정
		$("button#modal-profile-info2").click(function() {
			var visibilityStatus = document.getElementById("visibilityStatus2");
			var boardVisibilityInput = $("input[name='board_visibility']");
			
		    if (visibilityStatus.textContent === "전체공개") {
		        visibilityStatus.textContent = "친구공개";
		        boardVisibilityInput.val("2");
		    } else {
		        visibilityStatus.textContent = "전체공개";
		        boardVisibilityInput.val("1");
		    }
		});
		
		/////////////////////////////////////////////////////////////////////////////////////////
		// 글 작성
		$("button#write-update").click(function() {
			const boardContent = writeQuill.root.innerHTML.replace(/\s+/g, "").replace(/<p><br><\/p>/g, "");
			//alert(boardContent);

			if (boardContent === "<p></p><p></p>" || boardContent === "<p></p>" || boardContent === "") {
		        alert("내용을 입력해주세요.");
		        writeQuill.setText('');
		        return;
		    }
			else {
				alert("글이 성공적으로 업데이트 되었습니다.");
				
				const frm = document.addFrm;
		      	frm.method = "post";
		      	frm.action = "<%= ctxPath%>/board/add";
		      	frm.submit();
			}
		});
		
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
	    
		/////////////////////////////////////////////////////////////////////////////////////////
	 	// 글 삭제
	    $(".delete-post").click(function () {
	    	const board_no = $(this).attr("value");
	        //alert("글 삭제 (board_no: " + board_no + ")");

	        const confirmDelete = confirm("글을 삭제하시겠습니까?");
		    if (!confirmDelete) {
		        return; 
		    } else {
		    
				$.ajax({
					url: '${pageContext.request.contextPath}/board/deleteBoard',
					type: 'post',
					dataType: 'json',
					data: {"board_no": board_no},
					success: function(json) {
						if(json.n == 1) {
							alert("글이 성공적으로 삭제되었습니다.");
							location.reload();
						}
			        },
			        error: function(request, status, error){
						console.log("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
				 	}
				});
		    }
	    });
	 	
		/////////////////////////////////////////////////////////////////////////////////////////
	 	// 글 수정
		let board_content = "";
	    $(".edit-post").click(function () {
	        const board_no = $(this).attr("value");
	        const visibilityOrigin = $(".board-visibility-origin").val();
	        board_content = $(this).closest('.board-member-profile').find(".board-content").val();
	        
	        $("input[name='board_no']").val(board_no);
	        
	        const visibilityStatus = document.getElementById("visibilityStatus2");
	        const boardVisibilityInput = $("input[name='board_visibility']");
            
            if (visibilityOrigin === "1") {
                visibilityStatus.textContent = "전체공개";  
            } else if (visibilityOrigin === "2") {
                visibilityStatus.textContent = "친구공개";  
            }
            
            boardVisibilityInput.val(visibilityOrigin); 
            
	        //alert("글 수정 (board_no: " + board_no + ")");
            //alert("board-visibility-origin 값: " + visibilityOrigin);
	        //alert("board_content : " + board_content);  
	        
	        editQuill.root.innerHTML = board_content; 
	        editModal.style.display = "block";
	    });
		
	    $("span#closeModalButton").click(function() {
	    	editModal.style.display = "none";
	    	editQuill.setText('');
        });

        $(window).click(function(e) {
            if (e.target == editModal) {
            	editModal.style.display = "none";
            	editQuill.setText('');
            }
        });
	 	
        $("button#edit-update").click(function() {
			const boardContent = editQuill.root.innerHTML.replace(/\s+/g, "").replace(/<p><br><\/p>/g, "");
			//alert(boardContent);

			if (boardContent === "<p></p><p></p>" || boardContent === "<p></p>" || boardContent === "") {
		        alert("내용을 입력해주세요.");
		        editQuill.root.innerHTML = board_content;
		        return;
		    }
			else {
				alert("글이 성공적으로 수정되었습니다.");
				
				const frm = document.editFrm;
		      	frm.method = "post";
		      	frm.action = "<%= ctxPath%>/board/editBoard";
		      	frm.submit();
			}
		});
        
        
		/////////////////////////////////////////////////////////////////////////////////////////
	 	// 게시글 허용범위
	    $(".set-board-range").click(function () {
	    	let board_no = $(this).attr("value");
	        alert("게시글 허용범위 (board_no: " + board_no + ")");
	    });
	    
		
		/////////////////////////////////////////////////////////////////////////////////////////
	    // 댓글 허용범위
	    $(".set-comment-range").click(function () {
	    	let board_no = $(this).attr("value");
	        alert("댓글 허용범위 (board_no: " + board_no + ")");
	        // 설정 팝업
	    });
	    
	    
		/////////////////////////////////////////////////////////////////////////////////////////
	 	// 정렬방식
		$(".dropdown-content a").click(function() {
	        var selectedValue = $(this).text();  
	        $(".dropbtn").text(selectedValue + " ▼");  
	    });
		
	    $(".dropbtn").click(function (e) {
	        e.stopPropagation(); 
	        $(".dropdown-content").toggle();
	    });
		
	    $(document).click(function () {
	        $(".dropdown-content").hide();
	    });

	    
		/////////////////////////////////////////////////////////////////////////////////////////
		// 추천기능
		$("button.reactions-menu__reaction-index").click(function() {
			
			const reaction_target_no = $(this).closest(".reactions-menu").data("value");
			//alert(board_no)
			
			const reaction_status = $(this).val();
			//alert($(this).val());
	        
			$.ajax({
				url: '${pageContext.request.contextPath}/board/reactionSelect',
				type: 'post',
				dataType: 'json',
				data: {"fk_member_id": fk_member_id,
					   "reaction_target_no": reaction_target_no},
				success: function(response) {
		            location.reload(); 
		        },
		        error: function(request, status, error){
					console.log("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
			 	}
			});
			
			/*
			$.ajax({
				url: '${pageContext.request.contextPath}/board/reactionBoard',
				type: 'post',
				dataType: 'json',
				data: {"reaction_target_no": reaction_target_no,
					   "reaction_status": reaction_status},
				success: function(response) {
		            alert("반응 추가 완료");
		            location.reload(); 
		        },
		        error: function(request, status, error){
					console.log("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
			 	}
			});*/
		});
		
	});

    
 	// 이미지 미리보기 및 목록에 추가하는 함수
    function previewImage(event) {
        const fileInput = event.target;
        const file = fileInput.files[0];

        const fileNameElement = document.createElement("span");
        fileNameElement.textContent = file.name; 
        fileNameElement.style.display = "block"; 

        const previewItem = document.createElement("div");
        previewItem.style.marginBottom = "5px"; 
        previewItem.appendChild(fileNameElement);

        const previewList = document.getElementById("image-preview-list");
        previewList.appendChild(previewItem);

        document.getElementById("image-preview-container").style.display = "block";
    }

 	
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

			<div id="write" class="border-board">
			
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
	                                        <strong>업데이트 쓰기</strong>
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
			
			<div class="feed-divider">
			    <hr class="divider-line">
			    <div class="sort-options">
			        정렬 방식:
			        <div class="dropdown">
			            <button class="dropbtn">최신순 ▼</button>
			            <div class="dropdown-content">
			                <a href="#" data-value="latest">최신순</a>
			                <a href="#" data-value="likes">좋아요순</a>
			            </div>
			        </div>
			    </div>
			</div>	<!-- div.feed-divider 끝 -->
			
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
	                        	<c:choose>
	                        		<c:when test="${membervo.member_id != board.fk_member_id}">
			                            <button type="button" class="follow-button">
                            				<i class="fa-solid fa-plus"></i>&nbsp;팔로우
		                            	</button>
	                            	</c:when>
                            	</c:choose>
	                            <button type="button" class="more-options"><!--<i class="fa-solid fa-ellipsis"></i>-->...</button>
	                            <input type="hidden" class="board-content" value="${board.board_content}" data-board-content="${board.board_content}" />
	                            <input type="hidden" class="board-visibility-origin" value="${board.board_visibility}" data-board-content="${board.board_visibility}" />
	                            
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
	                    <!-- 사진 또는 동영상 등 첨부파일 
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
	                    </div>-->
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
	                                <span class="reactions-menu reactions-menu--active reactions-menu--humor-enabled reactions-menu--v2" data-value="${board.board_no}" style="">
									    <button aria-label="반응: 추천" class="reactions-menu__reaction-index reactions-menu__reaction" value="1" tabindex="-1" type="button">
									      	<span class="reactions-menu__reaction-description">추천</span>
									    	<img class="reactions-icon reactions-menu__icon reactions-icon__consumption--large data-test-reactions-icon-type-LIKE data-test-reactions-icon-theme-light" src="https://static.licdn.com/aero-v1/sc/h/8fz8rainn3wh49ad6ef9gotj1" alt="like" data-test-reactions-icon-type="LIKE" data-test-reactions-icon-theme="light" data-test-reactions-icon-style="consumption" data-test-reactions-icon-size="large">
									    </button>
									    <button aria-label="반응: 축하" class="reactions-menu__reaction-index reactions-menu__reaction" value="2" tabindex="-1" type="button">
								      		<span class="reactions-menu__reaction-description">축하</span>
									    	<img class="reactions-icon reactions-menu__icon reactions-icon__consumption--large data-test-reactions-icon-type-PRAISE data-test-reactions-icon-theme-light" src="https://static.licdn.com/aero-v1/sc/h/1mbfgcprj3z93pjntukfqbr8y" alt="celebrate" data-test-reactions-icon-type="PRAISE" data-test-reactions-icon-theme="light" data-test-reactions-icon-style="consumption" data-test-reactions-icon-size="large">
									    </button>
									    <button aria-label="반응: 응원" class="reactions-menu__reaction-index reactions-menu__reaction" value="3" tabindex="-1" type="button">
									      	<span class="reactions-menu__reaction-description">응원</span>
									    	<img class="reactions-icon reactions-menu__icon reactions-icon__consumption--large data-test-reactions-icon-type-APPRECIATION data-test-reactions-icon-theme-light" src="https://static.licdn.com/aero-v1/sc/h/cv29x2jo14dbflduuli6de6bf" alt="support" data-test-reactions-icon-type="APPRECIATION" data-test-reactions-icon-theme="light" data-test-reactions-icon-style="consumption" data-test-reactions-icon-size="large">
									    </button>
									    <button aria-label="반응: 마음에 쏙듬" class="reactions-menu__reaction-index reactions-menu__reaction" value="4" tabindex="-1" type="button">
									      	<span class="reactions-menu__reaction-description">마음에 쏙듬</span>
									    	<img class="reactions-icon reactions-menu__icon reactions-icon__consumption--large data-test-reactions-icon-type-EMPATHY data-test-reactions-icon-theme-light" src="https://static.licdn.com/aero-v1/sc/h/6f5qp9agugsqw1swegjxj86me" alt="love" data-test-reactions-icon-type="EMPATHY" data-test-reactions-icon-theme="light" data-test-reactions-icon-style="consumption" data-test-reactions-icon-size="large">
									    </button>
									    <button aria-label="반응: 통찰력" class="reactions-menu__reaction-index reactions-menu__reaction" value="5" tabindex="-1" type="button">
								      		<span class="reactions-menu__reaction-description">통찰력</span>
									    	<img class="reactions-icon reactions-menu__icon reactions-icon__consumption--large data-test-reactions-icon-type-INTEREST data-test-reactions-icon-theme-light" src="https://static.licdn.com/aero-v1/sc/h/9ry9ng73p660hsehml9i440b2" alt="insightful" data-test-reactions-icon-type="INTEREST" data-test-reactions-icon-theme="light" data-test-reactions-icon-style="consumption" data-test-reactions-icon-size="large">
									    </button>
									    <button aria-label="반응: 웃음" class="reactions-menu__reaction-index reactions-menu__reaction" value="6" tabindex="-1" type="button">
									      	<span class="reactions-menu__reaction-description">웃음</span>
									    	<img class="reactions-icon reactions-menu__icon reactions-icon__consumption--large data-test-reactions-icon-type-ENTERTAINMENT data-test-reactions-icon-theme-light" src="https://static.licdn.com/aero-v1/sc/h/qye2jwjc8dw20nuv6diudrsi" alt="funny" data-test-reactions-icon-type="ENTERTAINMENT" data-test-reactions-icon-theme="light" data-test-reactions-icon-style="consumption" data-test-reactions-icon-size="large">
									    </button>
								    </span>
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
               
                
        <!-- ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ -->
        <!-- 글 작성 Modal -->
        <div id="writeModal" class="modal">
            <div class="modal-content">
                <div class="content-top">
                    <button type="button" class="modal-profile-info" id="modal-profile-info">
                        <div class="modal-profile-img">
                            <img class="modal-profile" src="<%= ctxPath%>/images/쉐보레전면.jpg">	<!-- DB에서 가져오기 -->
                        </div>
                        <div class="modal-name">
                            <h3 class="modal-profile-name">${membervo.member_name}</h3> 	<!-- DB에서 가져오기 -->
                            <span id="visibilityStatus">전체공개</span>
                        </div>
                    </button>
                    <span class="close" id="closeModalButton">&times;</span>
                </div> <!-- div.modal-content 끝 -->
                <div class="content-bottom">
                    <!-- Quill 에디터 적용 부분 -->
                    <div class="editor-container">
					    <div>
					        <div class="editor-content ql-container">
					            <div class="ql-editor" data-placeholder="글을 작성하세요...">
					                <p></p>
					            </div>
					            <div class="ql-clipboard" contenteditable="true" tabindex="-1"></div>
					        </div>
					    </div>
					</div>
					
				    <!-- 이미지 미리보기 표시 영역 -->
		            <div id="image-preview-container" style="">
		                <div id="image-preview-list"></div> <!-- 첨부된 이미지 목록 -->
		            </div>
					
                    <div class="ql-category">
	                    <div>
	                    	<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" id="image-medium" class="hidden-svg" aria-hidden="true" role="none" data-supported-dps="24x24" fill="currentColor" type="image" onclick="document.getElementById('file-image').click();">
							  	<path d="M19 4H5a3 3 0 00-3 3v10a3 3 0 003 3h14a3 3 0 003-3V7a3 3 0 00-3-3zm1 13a1 1 0 01-.29.71L16 14l-2 2-6-6-4 4V7a1 1 0 011-1h14a1 1 0 011 1zm-2-7a2 2 0 11-2-2 2 2 0 012 2z"></path>
							</svg>
                    		<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" id="video-medium" class="hidden-svg" aria-hidden="true" role="none" data-supported-dps="24x24" fill="currentColor" type="video" onclick="document.getElementById('file-video').click();">
								<path d="M19 4H5a3 3 0 00-3 3v10a3 3 0 003 3h14a3 3 0 003-3V7a3 3 0 00-3-3zm-9 12V8l6 4z"></path>
							</svg>
	                    </div>
						<div>
							<button type="button" id="write-update">업데이트</button>					
						</div>
						<form name="addFrm" enctype="multipart/form-data">
				            <input type="hidden" name="fk_member_id" value="${membervo.member_id}" /> 	
				            <input type="hidden" name="board_content" value="" />
				            <input type="hidden" name="board_visibility" value="" />
				            <input type="file" name="board_image" id="file-image" style="display:none;" onchange="previewImage(event)" />
				            <input type="file" name="board_video" id="file-video" style="display:none;" />
			            </form>
			        </div> <!-- div.ql-category 끝 -->
                </div> <!-- div.content-bottom 끝 -->
            </div> <!-- div.modal-content 끝 -->
        </div> <!-- div.modal 끝 -->
        <!-- ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ -->
        
        
        <!-- ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ -->
        <!-- 글 수정 Modal -->
        <div id="editModal" class="modal">
            <div class="modal-content">
                <div class="content-top">
                    <button type="button" class="modal-profile-info" id="modal-profile-info2">
                        <div class="modal-profile-img">
                            <img class="modal-profile" src="<%= ctxPath%>/images/쉐보레전면.jpg">	<!-- DB에서 가져오기 -->
                        </div>
                        <div class="modal-name">
                            <h3 class="modal-profile-name">${membervo.member_name}</h3> 	<!-- DB에서 가져오기 -->
                            <span id="visibilityStatus2">전체공개</span>
                        </div>
                    </button>
                    <span class="close" id="closeModalButton">&times;</span>
                </div> <!-- div.modal-content 끝 -->
                <div class="content-bottom">
                    <!-- Quill 에디터 적용 부분 -->
                    <div class="editor-container">
					    <div>
					        <div class="editor-content ql-container">
					            <div class="ql-editor" data-placeholder="글을 작성하세요...">
					                <p></p>
					            </div>
					            <div class="ql-clipboard" contenteditable="true" tabindex="-1"></div>
					        </div>
					    </div>
					</div>
					
				    <!-- 이미지 미리보기 표시 영역 -->
		            <div id="image-preview-container" style="">
		                <div id="image-preview-list"></div> <!-- 첨부된 이미지 목록 -->
		            </div>
					
                    <div class="ql-category">
	                    <div>
	                    	<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" id="image-medium" class="hidden-svg" aria-hidden="true" role="none" data-supported-dps="24x24" fill="currentColor" type="image" onclick="document.getElementById('file-image').click();">
							  	<path d="M19 4H5a3 3 0 00-3 3v10a3 3 0 003 3h14a3 3 0 003-3V7a3 3 0 00-3-3zm1 13a1 1 0 01-.29.71L16 14l-2 2-6-6-4 4V7a1 1 0 011-1h14a1 1 0 011 1zm-2-7a2 2 0 11-2-2 2 2 0 012 2z"></path>
							</svg>
                    		<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" id="video-medium" class="hidden-svg" aria-hidden="true" role="none" data-supported-dps="24x24" fill="currentColor" type="video" onclick="document.getElementById('file-video').click();">
								<path d="M19 4H5a3 3 0 00-3 3v10a3 3 0 003 3h14a3 3 0 003-3V7a3 3 0 00-3-3zm-9 12V8l6 4z"></path>
							</svg>
	                    </div>
						<div>
							<button type="button" id="edit-update">수정하기</button>					
						</div>
						<form name="editFrm" enctype="multipart/form-data">
				            <input type="hidden" name="fk_member_id" value="${membervo.member_id}" /> 
				            <input type="hidden" name="board_no" value="" />	
				            <input type="hidden" name="board_content" value="" />
				            <input type="hiddn" name="board_visibility" value="" />
				            <input type="file" name="board_image" id="file-image" style="display:none;" onchange="previewImage(event)" />
				            <input type="file" name="board_video" id="file-video" style="display:none;" />
			            </form>
			        </div> <!-- div.ql-category 끝 -->
                </div> <!-- div.content-bottom 끝 -->
            </div> <!-- div.modal-content 끝 -->
        </div> <!-- div.modal 끝 -->
        <!-- ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ -->
        
        
        
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
