<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
                            <h3>박채은</h3>     <!-- DB에서 가져오기 -->
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

            </div>
        </div>
        
        
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
                </div> <!-- modal-content -->
                
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
				            <input type="text" name="fk_member_id" value="user001" />
				            <input type="text" name="board_content" value="" />
				            <input type="text" name="board_visibility" value="" />
			            </form>
			            
			        </div>
                    
                </div> <!-- content-bottom -->

            </div> <!-- modal-content -->
            
            
        </div> <!-- modal -->

    </div> <!-- inner-container -->

</div> <!-- container -->
</body>
</html>
