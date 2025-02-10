<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>    
<jsp:include page="/WEB-INF/views/header/header.jsp" />

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/feed/board.css" />

<script type="text/javascript">
	
	$(document).ready(function() {
		
		$("button.write-button").click(function() {
			alert("dd");
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
                
                <div id="writeModal" class="modal">

                  <div class="modal-content">
                    <span class="close" id="closeModalButton">&times;</span>
                    <h2>모달 창 내용</h2>
                    <p>여기에 모달 내용이 들어갑니다.</p>
                  </div>

                </div>

            </div> <!-- inner-container -->

        </div> <!-- container -->
</body>
</html>