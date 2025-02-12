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

<script type="text/javascript">
    
    $(document).ready(function() {
        	
    	// Modal 
        const modal = document.getElementById("writeModal");
        modal.style.display = "none";
        
        $("button.write-button").click(function() {
        	// 모달을 열 때 공개 범위를 전체공개로 초기화
            var visibilityStatus = document.getElementById("visibilityStatus");
            var boardVisibilityInput = $("input[name='board_visibility']");
            
         	// 공개 범위 초기화: 전체공개
            visibilityStatus.textContent = "전체공개";
            boardVisibilityInput.val("1"); // 전체공개를 1로 설정
            
            modal.style.display = "block";
        });
        
        $("span#closeModalButton").click(function() {
            modal.style.display = "none";
            quill.setText('');
        });

        $(window).click(function(event) {
            if (event.target == modal) {
                modal.style.display = "none";
                quill.setText('');
            }
        });
        
  		/////////////////////////////////////////////////////////////////////////////////////////
        
     	// Quill 에디터
        var quill = new Quill('.editor-container', { 
            theme: 'snow',
            modules: {
                toolbar: false
            },
            placeholder: '나누고 싶은 생각이 있으세요?' 
        });
		
     	// Quill 에디터 내용이 변경될 때마다 <input> 값 업데이트
        quill.on('text-change', function() {
            var boardContent = quill.root.innerHTML;  // HTML 내용
            $("input[name='board_content']").val(boardContent);  // HTML을 그대로 입력 필드에 설정
        });
     
        
		/////////////////////////////////////////////////////////////////////////////////////////
		
		// 공개범위 바꾸기 (전체공개/친구공개)
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
		
		/////////////////////////////////////////////////////////////////////////////////////////

		// "업데이트" 버튼
		$("button#write-update").click(function() {
			alert("글이 성공적으로 업데이트 되었습니다.");
			
			const frm = document.addFrm;
	      	frm.method = "post";
	      	frm.action = "<%= ctxPath%>/board/add";
	      	frm.submit();
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


<div id="container">
    <div id="inner-container">

        <!-- 프로필 사진 -->
        <div id="profile-side">               
            <div id="profile">

                <div class="myprofile">
                    <a href="" aria-label="배경화면">
                        <!-- 프로필사진 -->
                        <img class="myprofile-background" src="<%= ctxPath%>/images/feed/dog.jpg">    <!-- DB에서 가져오기 -->
                    </a>

                    <a href="" aria-label="프로필사진">
                        <!-- 프로필사진 -->
                        <img class="myprofile-profile" src="<%= ctxPath%>/images/feed/profile.jpg">   <!-- DB에서 가져오기 -->
                    </a> 

                    <div class="myprofile-info">
                        <div id="myprofile-name">
                            <h3>${membervo.member_name}</h3>     <!-- DB에서 가져오기 -->
                        </div>
                    </div>
                </div>

                <div class="follow">

                </div>
            </div>
        </div>

        <!-- 공백용 -->
        <div id="blank"></div>
        
        <!-- 피드 -->
        <div id="feed">
            <div class="writeFeed">
                
                <div class="feed-write-top">
                    <div class="feed-wirte">
                        <!-- 프로필사진 -->
                        <img class="feed-profile" src="<%= ctxPath%>/images/feed/profile.jpg">  

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
                
                <!-- 글 작성 카테고리 ??? -->
                <div class="feed-category">
                    <div class="feed-image">
                        <img class="feed-img" src="<%= ctxPath%>/images/feed/feed-image.png">  
                        <span class="category-name">사진</span>
                    </div>
                    <div class="feed-video">
                        <img class="feed-img" src="<%= ctxPath%>/images/feed/feed-video.png">  
                        <span class="category-name">동영상</span>
                    </div>
                </div>

            </div> <!-- div#writeFeed 끝-->
            
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
	
			<!-- 여기에 피드 동적으로 div 생성하기 -->
            <c:forEach var="board" items="${boardvo}">
		        <div class="feed-post">
		        	<div class="feed-header">
		        		<img class="feed-profile" src="<%= ctxPath%>/images/feed/profile.jpg"> 
		        		<p class="feed-post-name">${board.member_name}${memvervo.member_id}</p> 
		        		<button class="more-options"><img class="more-options-img" src="<%= ctxPath%>/images/feed/more.png" /></button>
		        		<!-- 옵션 드롭다운 메뉴 -->
			            <div class="options-dropdown">
			                <ul>
			                    <c:choose>
						            <c:when test="${membervo.member_id == board.fk_member_id}">
						                <li class="delete-post" value="${board.board_no}">글 삭제</li>
						                <li class="set-board-range" value="${board.board_no}">게시글 허용범위</li>
						                <li class="set-comment-range" value="${board.board_no}">댓글 허용범위</li>
						            </c:when>
						            <c:otherwise>
						                <li class="interest-none" value="${board.board_no}">관심없음</li>
						            </c:otherwise>
						        </c:choose>
			                </ul>
			            </div> <!-- div.options-dropdown 끝 -->
		        	</div> <!-- div.feed-header 끝 -->
		            <p>${board.board_content}</p>
		            <!-- 여기에 추가적인 board 데이터를 출력할 수 있음 -->
		        </div> <!-- div.feed-post 끝 -->
		    </c:forEach>
		    
        </div>	<!-- div#feed 끝 -->
        
        
        <!-- Modal -->
        <div id="writeModal" class="modal">

            <div class="modal-content">
            
                <div class="content-top">
                    <button type="button" class="modal-profile-info" id="modal-profile-info">
                        <div class="modal-profile-img">
                            <img class="modal-profile" src="<%= ctxPath%>/images/feed/profile.jpg">	<!-- DB에서 가져오기 -->
                        </div>
                        <div class="modal-name">
                            <h3 class="modal-profile-name">박채은 </h3> 	<!-- DB에서 가져오기 -->
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
                    
                    <div class="ql-category">
                    
	                    <div>
	                    	<img class="modal-img" src="<%= ctxPath%>/images/feed/feed-image.png"> 
                    		<img class="modal-img" src="<%= ctxPath%>/images/feed/feed-video.png"> 
	                    </div>
						
						<div>
							<button type="button" id="write-update">업데이트</button>					
						</div>
						
						<form name="addFrm">
				            <input type="hidden" name="fk_member_id" value="user001" /> 	<!-- session으로 가져오기 -->
				            <input type="hidden" name="board_content" value="" />
				            <input type="hidden" name="board_visibility" value="" />
			            </form>
			            
			        </div>
                    
                </div> <!-- div.content-bottom 끝 -->

            </div> <!-- div.modal-content 끝 -->
            
            
        </div> <!-- div.modal 끝 -->

    </div> <!-- div#inner-container 끝 -->

</div> <!-- div#container 끝 -->
</body>
</html>
