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
        
        const modal = document.getElementById("writeModal");
        modal.style.display = "none";
        
        $("button.write-button").click(function() {
            modal.style.display = "block";
        });
        
        $("span#closeModalButton").click(function() {
            modal.style.display = "none";
        });

        // 모달 창 외부를 클릭하면 모달이 닫히도록 처리
        $(window).click(function(event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        });
        
        // Quill 에디터 초기화
        var quill = new Quill('.ql-editor', {
            theme: 'snow',
            modules: {
                toolbar: false // 툴바를 비활성화하여 텍스트만 입력 가능
            }
        });
    });
</script>

<style>
    /* Quill 에디터의 보더 선 없애기 */
    .ql-editor {
        border: none;
        box-shadow: none;
    }
</style>

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
            
                <div class="content-top">
                    <button type="button">
                        <div>
                            <img class="modal-profile" src="<%= ctxPath%>/images/feed/profile.jpg">	<!-- DB에서 가져오기 -->
                        </div>
                        <div>
                            <h3>박채은</h3> <!-- DB에서 가져오기 -->
                        </div>
                    </button>
                    
                    <span class="close" id="closeModalButton">&times;</span>
                </div> <!-- modal-content -->
                
                <div class="content-bottom">
                    <h2>모달 창 내용</h2>
                    <!-- Quill 에디터 적용 부분 -->
                    <div class="editor-container">
                        <div>
                            <div class="editor-content ql-container">
                                <div class="ql-editor" data-gramm="false" contenteditable="true" data-placeholder="나누고 싶은 생각이 있으세요?" aria-placeholder="나누고 싶은 생각이 있으세요?" aria-label="콘텐츠 제작용 텍스트 에디터" role="textbox" aria-multiline="true" aria-describedby="ember549-text-editor-placeholder" data-test-ql-editor-contenteditable="true">
                                    <p></p>
                                </div>
                                <div class="ql-clipboard" contenteditable="true" tabindex="-1"></div>
                            </div>
                        </div>
                    </div>
                </div> <!-- content-bottom -->
                
            </div> <!-- modal-content -->

        </div> <!-- modal -->

    </div> <!-- inner-container -->

</div> <!-- container -->
</body>
</html>
