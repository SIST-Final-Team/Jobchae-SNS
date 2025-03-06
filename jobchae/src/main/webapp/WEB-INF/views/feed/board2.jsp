<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
    
	let currentX = 0;
	let uploadedFiles = [];
	let boardList = $(".feed-item");
	
    $(document).ready(function() {
        
    	$(".options-dropdown").hide();
    	$(".options-dropdown2").hide();
    	$(".comment-input-container").hide();
    	
	    	
		/////////////////////////////////////////////////////////////////////////////////////////
		// 글 작성 Modal 
        const writeModal = document.getElementById("writeModal");
        const editModal = document.getElementById("editModal");
        const rangeModal = document.getElementById("rangeModal");
        const reactionModal = document.getElementById("reactionModal");
        const ignoredModal = document.getElementById("ignoredModal");
        writeModal.style.display = "none";
        editModal.style.display = "none";
        rangeModal.style.display = "none";
        reactionModal.style.display = "none";
        ignoredModal.style.display = "none";
        
        
        
        const prevBtn = document.getElementById("prevBtn");
        const nextBtn = document.getElementById("nextBtn");
        prevBtn.style.display = "none";
        nextBtn.style.display = "none";
        
        const prevBtn2 = document.getElementById("prevBtn2");
        const nextBtn2 = document.getElementById("nextBtn2");
        prevBtn2.style.display = "none";
        nextBtn2.style.display = "none";
        
        
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
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
        	$(".carousel-track").empty();
        });

        $(window).click(function(e) {
            if (e.target == writeModal) {
            	writeModal.style.display = "none";
            	writeQuill.setText('');
            	$(".carousel-track").empty();
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
				const files = document.getElementById("file-image").files;
				console.log("업로드된 파일들: ", files);
				
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
	    	const fk_member_id = document.getElementById("loginuserID").value;
	    	const board_fk_member_id = $(this).siblings(".board-fk_member_id").val();
	    	const bookmark_target_no = $(this).attr("value");
	    	
	    	//console.log("fk_member_id " + fk_member_id)
	    	//console.log("board_fk_member_id " + board_fk_member_id)
	    	
	    	if (fk_member_id != board_fk_member_id) {
	    		$.ajax({
					url: '${pageContext.request.contextPath}/api/board/selectBookmarkBoard',
					type: 'post',
					dataType: 'json',
					data: {"fk_member_id": fk_member_id,
						   "bookmark_target_no": bookmark_target_no},
					success: function(json) {

						//alert("북마크 상태: " + json.status);
						if (json.status == 1) {
							$("li.bookmark-post[value='" + bookmark_target_no + "']").text("북마크 해제");
						} else {
							$("li.bookmark-post[value='" + bookmark_target_no + "']").text("북마크");
						}
					
					},
			        error: function(request, status, error){
						console.log("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
				 	}
				});
	    	}
	    	
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
					url: '${pageContext.request.contextPath}/api/board/deleteBoard',
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
	 	// 게시글, 댓글 허용범위
	    $(".set-board-range").click(function () {
	    	const board_no = $(this).attr("value");
	    	const visibilityOrigin = $(this).closest('.board-member-profile').find(".board-visibility-origin").val();
	    	const board_comment_allowed_origin = $(this).closest('.board-member-profile').find(".board-comment-allowed-origin").val();
	        //alert("게시글 허용범위 (board_no: " + board_no + ")");
	        //alert("게시글 허용범위 (visibilityOrigin: " + visibilityOrigin + ")");
	
	    	$("input[name='board_no']").val(board_no);
	    	$("input[name='rangeModal_board_visibility']").val(visibilityOrigin);
	    	$("input[name='rangeModal_board_comment-allowed']").val(board_comment_allowed_origin);
	    	
	    	$("input[name='board_visibility']").each(function () {
	            $(this).prop("checked", $(this).val() === visibilityOrigin);
	        });
	    	
	    	$("input[name='comment_visibility']").each(function () {
	            $(this).prop("checked", $(this).val() === board_comment_allowed_origin);
	        });
	    	
	    	$("#rangeModal").show();
	    });

		$("#rangeModal input[name='board_visibility']").change(function () {
		    const selectedValue = $(this).val();
		    $("input[name='rangeModal_board_visibility']").val(selectedValue);
		});
	 
		$("#rangeModal input[name='comment_visibility']").change(function () {
		    const selectedValue = $(this).val();
		    $("input[name='rangeModal_board_comment-allowed']").val(selectedValue);
		});
		
		$("button#saveRange").click(function() {
			const board_no = $("input[name='board_no']").val();
		    const board_visibility = $("input[name='board_visibility']:checked").val();
		    const board_comment_allowed = $("input[name='comment_visibility']:checked").val();
			//alert(board_no + " " + board_visibility + " " + board_comment_allowed);
			
		    $.ajax({
				url: '${pageContext.request.contextPath}/api/board/updateBoardVisibility',
				type: 'post',
				dataType: 'json',
				data: {"board_no": board_no,
					   "board_visibility": board_visibility,
					   "board_comment_allowed": board_comment_allowed},
				success: function(json) {
					if(json.n == 1) {
						alert("게시글 설정이 변경되었습니다.");
						location.reload();
					}
		        },
		        error: function(request, status, error){
					console.log("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
			 	}
			});
		    
		});
		
		$(".close").click(function() {
		    $("#rangeModal").hide();
		});
		
		$(window).click(function(e) {
            if (e.target == rangeModal) {
            	rangeModal.style.display = "none";
            }
        });
		
		///////////////////////////////////////////////////////////////////////////////////////// 
		// 북마크
		$(".bookmark-post").click(function() {
			const fk_member_id = document.getElementById("loginuserID").value;
			const bookmark_target_no = $(this).attr("value");
			//alert(fk_member_id + " " + bookmark_target_no);
			
			const text = $(this).text();  
   			//alert("클릭한 텍스트: " + text);
   			
   			if (text == "북마크") {
   				$.ajax({
   					url: '${pageContext.request.contextPath}/api/board/addBookmarkBoard',
   					type: 'post',
   					dataType: 'json',
   					data: {"fk_member_id": fk_member_id,
   						   "bookmark_target_no": bookmark_target_no},
   					success: function(json) {
   						if(json.n == 1) {
   							alert("해당 게시글이 북마크에 추가되었습니다.");
   						 	location.reload();
   						}
   			        },
   			        error: function(request, status, error){
   						console.log("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
   				 	}
   				});
   			} else {
   				$.ajax({
   					url: '${pageContext.request.contextPath}/api/board/deleteBookmarkBoard',
   					type: 'post',
   					dataType: 'json',
   					data: {"fk_member_id": fk_member_id,
   						   "bookmark_target_no": bookmark_target_no},
   					success: function(json) {
   						if(json.n == 1) {
   							alert("북마크가 정상적으로 해제되었습니다.");
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
	 	// 정렬방식
		$(".dropdown-content a").click(function() {
	        var selectedValue = $(this).text();  
	        $(".dropbtn").text(selectedValue + " ▼");  
	        
	        if (selectedValue == "최신순") {
				location.reload();
        	} else {
        	    const reactionCounts = document.querySelectorAll('#reactionCount');

        	    const reactionData = Array.from(reactionCounts).map(span => {
        	        const reactionCount = span.textContent.trim();
        	        return {
        	            board_no: span.getAttribute('value'),
        	            reaction_count: reactionCount === '' || reactionCount === null ? 0 : reactionCount
        	        };
        	    });

        	    reactionData.sort((a, b) => b.reaction_count - a.reaction_count);
        	    console.log(reactionData);
        	}
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
		$("button.button-board-action-reaction").click(function() {
			const reaction_target_no = $(this).val();
			let reaction_status = null;
			//alert(reaction_target_no);
			
			
			// 반응이 있을 때
		    $(this).find("span").each(function() {
		        const reactionstatus = $(this).data("value");
		        if (reactionstatus) {
		        	reaction_status = $(this).data("value");
		        }
		    });
		    //alert(reaction_status);
		    
		    if (reaction_status == null) {
		    	$.ajax({
					url: '${pageContext.request.contextPath}/api/board/reactionBoard',
					type: 'post',
					dataType: 'json',
					data: {"reaction_target_no": reaction_target_no,
						   "reaction_status": 1},
					success: function(json) {
						if(json.n == 1) {
						 	location.reload();
						}
			        },
			        error: function(request, status, error){
						console.log("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
				 	}
				});
		    } else {
		    	$.ajax({
					url: '${pageContext.request.contextPath}/api/board/deleteReactionBoard',
					type: 'post',
					dataType: 'json',
					data: {"reaction_target_no": reaction_target_no},
					success: function(json) {
						if(json.n == 1) {
						 	location.reload();
						}
			        },
			        error: function(request, status, error){
						console.log("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
				 	}
				});
		    }
		   
		});
		
		
		$("button.reactions-menu__reaction-index").click(function() {
			
			const reaction_target_no = $(this).closest(".reactions-menu").data("value");
			const reaction_status = $(this).val();
			//alert(reaction_target_no + " " + reaction_status);
			
			$.ajax({
				url: '${pageContext.request.contextPath}/api/board/reactionBoard',
				type: 'post',
				dataType: 'json',
				data: {"reaction_target_no": reaction_target_no,
					   "reaction_status": reaction_status},
				success: function(json) {
					if(json.n == 1) {
					 	location.reload();
					}
		        },
		        error: function(request, status, error){
					console.log("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
			 	}
			});
		});
		
		$("span#reactionCount").click(function() {
			const reaction_target_no = $(this).attr("value");
			$("input[name='reaction_target_no']").val(reaction_target_no);
			
			$.ajax({
				url: '${pageContext.request.contextPath}/api/board/getReactionCounts',
				type: 'post',
				dataType: 'json',
				data: {"reaction_target_no": reaction_target_no},
				success: function(json) {
					$("#reaction-all").text(json["7"]);
					$("#reaction-like").text(json["1"]);
					$("#reaction-praise").text(json["2"]);
					$("#reaction-empathy").text(json["3"]);
					$("#reaction-appreciation").text(json["4"]);
					$("#reaction-interest").text(json["5"]);
					$("#reaction-entertainment").text(json["6"]);
		        },
		        error: function(request, status, error){
					console.log("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
			 	}
			});
			
			$.ajax({
				url: '${pageContext.request.contextPath}/api/board/getReactionMembers',
				type: 'post',
				dataType: 'json',
				data: {"reaction_target_no": reaction_target_no,
					   "reaction_status" : "7"},
				success: function(json) {
					//console.log(json.membervo);
					$(".reaction-list").empty();
					
					json.membervo.forEach(function(member) {
						let member_name = member.member_name;
						var html = "<div class='reaction-item'><img src='profile1.jpg' alt='Profile Image' class='avatar'><div class='user-info'><p class='user-name'>" + member_name + "</p></div></div>";
		        		$(".reaction-list").append(html);
					});
		        },
		        error: function(request, status, error){
					console.log("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
			 	}
			});
			
			reactionModal.style.display = "block";
			const firstButton = document.querySelector(".reaction-tabs button");
		    firstButton.classList.add("active");
		});
		
		$("span#closeModalButton").click(function() {
			reactionModal.style.display = "none";
			const activeButton = document.querySelector(".reaction-tabs .active");
            if (activeButton) {
                activeButton.classList.remove("active");
            }
        });
		
		$(window).click(function(e) {
            if (e.target == reactionModal) {
            	reactionModal.style.display = "none";
            	const activeButton = document.querySelector(".reaction-tabs .active");
                if (activeButton) {
                    activeButton.classList.remove("active");
                }
            }
        });
		
		
		const buttons = document.querySelectorAll(".reaction-tabs button");

        buttons.forEach((button) => {
	        button.addEventListener("click", function () {
	          document.querySelector(".reaction-tabs .active")?.classList.remove("active");
	          this.classList.add("active");
	          
	          const reaction_target_no = $("input[name='reaction_target_no']").val();
	          const reaction_status = this.value;
	          //alert(reaction_status + " " + reaction_target_no);
	          
	          $.ajax({
					url: '${pageContext.request.contextPath}/api/board/getReactionMembers',
					type: 'post',
					dataType: 'json',
					data: {"reaction_target_no": reaction_target_no,
						   "reaction_status" : reaction_status},
					success: function(json) {
						//console.log(json.membervo);
						$(".reaction-list").empty();
						
						json.membervo.forEach(function(member) {
							let member_name = member.member_name; //여기
							var html = "<div class='reaction-item'><img src='profile1.jpg' alt='Profile Image' class='avatar'><div class='user-info'><p class='user-name'>" + member_name + "</p></div></div>";
			        		$(".reaction-list").append(html);
						});
			        },
			        error: function(request, status, error){
						console.log("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
				 	}
				});
	          
	        });
        });
		
		/////////////////////////////////////////////////////////////////////////////////////////
		// Modal 이미지 미리보기
		$("button#prevBtn").click(function() {
			if (currentX < 0) {
				currentX += 208;
				$(".carousel-track").css("transform", "translateX(" + currentX + "px)");
			}
		});
		
		$("button#nextBtn").click(function() {
			currentX -= 208;
			$(".carousel-track").css("transform", "translateX(" + currentX + "px)");
		});
		
		
		///////////////////////////////////////////////////////////////////////////////////////// 
		// 게시글 시간
		$(".time").each(function () {
	        const timeString = $(this).attr("data-time");
	        $(this).text(timeAgo(timeString));
	    });

		// 댓글 시간
		$(".comment-date").each(function () {
	        const timeString = $(this).attr("data-time");
	        $(this).text(timeAgo(timeString));
	    });
		
		function timeAgo(dateString) {
	        const now = new Date();
	        const past = new Date(dateString);
	        const diff = Math.floor((now - past) / 1000); 

	        if (diff < 60) return "방금"; 
	        if (diff < 3600) return Math.floor(diff / 60) + "분 전"; 
	        if (diff < 86400) return Math.floor(diff / 3600) + "시간 전";
	        if (diff < 2592000) return Math.floor(diff / 86400) + "일 전";
	        if (diff < 31536000) return Math.floor(diff / 2592000) + "달 전";
	        return Math.floor(diff / 31536000) + "년 전"; 
	    }
		
		
		///////////////////////////////////////////////////////////////////////////////////////// 
		// 댓글 
		$(".comment-options").click(function(event) {
			event.stopPropagation();
			let dropdown = $(this).closest(".comment-item").find(".options-dropdown2");
			$(".options-dropdown2").not(dropdown).hide(); 
	        dropdown.toggle(); 
		});
		
		$(document).click(function () {
	        $(".options-dropdown2").hide();
	    });
		
		$(".button-board-action-comment").click(function() { 
			var commentInputContainer = $(this).closest('div').next('.comment-input-container');
			//console.log(commentInputContainer);
			commentInputContainer.slideToggle();
		});


		$(".comment-submit-button").click(function() {
			const fk_board_no = $(this).closest('.comment-input-container').find('input[type="hidden"]').first().val();  
			//alert("클릭" + fk_board_no);
			
			const fk_member_id = document.getElementById("loginuserID").value;
			
			const comment_content = $(this).closest('.comment-input-container').find('#commentInput').val().trim(); 
			//alert(comment_content);
			
			const mentionedNameText = $('#mentionedName').text().trim();
			//alert(mentionedNameText);
			
			const comment_no = $("input[name='hidden-comment-reply-no']").val();
			//alert(comment_no);
			
			if (mentionedNameText !== "") { // 대댓글이라면
				if (comment_content == "") {
					alert("댓글 내용을 입력해주세요.");
					$(this).closest('.comment-input-container').find('#commentInput').val('');
					return;
				} else {
					$.ajax({
						url: '${pageContext.request.contextPath}/api/board/addCommentReply',
						type: 'post',
						dataType: 'json',
						data: {"fk_board_no": fk_board_no,
							   "fk_member_id": fk_member_id,
							   "comment_content" : comment_content,
							   "comment_no": comment_no},
						success: function(json) {
							if(json.n == 1) {
								$(this).closest('.comment-input-container').find('#commentInput').val('');
								alert("댓글이 등록되었습니다.");
								location.reload();
							}
				        },
				        error: function(request, status, error){
							console.log("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
					 	}
					});
				}
			} else {
				if (comment_content == "") {
					alert("댓글 내용을 입력해주세요.");
					$(this).closest('.comment-input-container').find('#commentInput').val('');
					return;
				} else {
					$.ajax({
						url: '${pageContext.request.contextPath}/api/board/addComment',
						type: 'post',
						dataType: 'json',
						data: {"fk_board_no": fk_board_no,
							   "fk_member_id": fk_member_id,
							   "comment_content" : comment_content},
						success: function(json) {
							if(json.n == 1) {
								$(this).closest('.comment-input-container').find('#commentInput').val('');
								alert("댓글이 등록되었습니다.");
								location.reload();
							}
				        },
				        error: function(request, status, error){
							console.log("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
					 	}
					});
				}
			}
		});
		
		// 댓글 삭제
		$(".comment-delete").click(function() {
			const fk_board_no = $(this).closest('.comment-input-container').find('.hidden-board-no').val();  
			const fk_member_id = $(this).closest('.comment-input-container').find('.hidden-member-id').val();  
			const comment_no = $(this).closest('.comment-item').find('.hidden-comment-no').val();  
			//alert(fk_board_no + " " + fk_member_id + " " + comment_no);
		
			if (confirm("정말로 댓글을 삭제하시겠습니까?")) {
				$.ajax({
					url: '${pageContext.request.contextPath}/api/board/deleteComment',
					type: 'post',
					dataType: 'json',
					data: {"fk_board_no": fk_board_no,
						   "fk_member_id": fk_member_id,
						   "comment_no" : comment_no},
					success: function(json) {
						if(json.n == 1) {
							alert("댓글이 삭제되었습니다.");
							location.reload();
						}
			        },
			        error: function(request, status, error){
						console.log("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
				 	}
				});
			}
		});

		$(".comment-edit").click(function() { 
			const fk_board_no = $(this).closest('.comment-input-container').find('.hidden-board-no').val();  
			const fk_member_id = $(this).closest('.comment-input-container').find('.hidden-member-id').val();  
			const comment_no = $(this).closest('.comment-item').find('.hidden-comment-no').val(); 
			//alert(fk_board_no + " " + fk_member_id + " " + comment_no);
			
			const originalText = $(this).closest('.comment-item').find('.comment-content-text').text(); 
			const editText = $(this).closest('.comment-item').find('#edit-input').val();
		    //alert(originalText + " " + editText);
		    
		    $(this).closest('.comment-item').find('.comment-content-text').hide();
		    $(this).closest('.comment-item').find('#comment-edit-input').show();
		});

		$(".comment-edit-button").click(function() { 
			const comment_content = $(this).closest('.comment-item').find('#edit-input').val();
			//alert(comment_content);
			
			const fk_board_no = $(this).closest('.comment-input-container').find('.hidden-board-no').val();  
			const fk_member_id = $(this).closest('.comment-input-container').find('.hidden-member-id').val();  
			const comment_no = $(this).closest('.comment-item').find('.hidden-comment-no').val(); 
			//alert(fk_board_no + " " + fk_member_id + " " + comment_no);
			
			$.ajax({
				url: '${pageContext.request.contextPath}/api/board/editComment',
				type: 'post',
				dataType: 'json',
				data: {"fk_board_no": fk_board_no,
					   "fk_member_id": fk_member_id,
					   "comment_no" : comment_no,
					   "comment_content" : comment_content},
				success: function(json) {
					if(json.n == 1) {
						$(this).closest('.comment-item').find('.comment-content-text').show();
					    $(this).closest('.comment-item').find('#comment-edit-input').hide();
						alert("댓글이 수정되었습니다.");
						location.reload();
					}
		        },
		        error: function(request, status, error){
					console.log("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
			 	}
			});
		});
		
		
		// 관심없음
		$(".interest-none").click(function() {
			const fk_member_id = document.getElementById("loginuserID").value;
			const fk_board_no = $(this).attr("value");
			//alert(fk_member_id + " " + fk_board_no)
			
	    	$("input[name='ignored_fk_board_no']").val(fk_board_no);
	    	//alert($("input[name='ignored_fk_board_no']").val());
	    	
	    	$("input[name='reason']").first().prop("checked", true);
			ignoredModal.style.display = "block";
			
		});
		
		$("span#closeModalButton").click(function() {
			ignoredModal.style.display = "none";
        });
		
		$(window).click(function(e) {
            if (e.target == ignoredModal) {
            	ignoredModal.style.display = "none";
            }
        });
		
		$("#saveIgnored").click(function() {
			const fk_member_id = document.getElementById("loginuserID").value;
			const fk_board_no = $("input[name='ignored_fk_board_no']").val()
			//alert(fk_member_id + " " + fk_board_no)
			
			$.ajax({
				url: '${pageContext.request.contextPath}/api/board/ignoredBoard',
				type: 'post',
				dataType: 'json',
				data: {"fk_member_id": fk_member_id,
					   "fk_board_no": fk_board_no},
				success: function(json) {
					if(json.n == 1) {
						alert("관심없음 설정이 되었습니다.");
						location.reload();
					}
		        },
		        error: function(request, status, error){
					console.log("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
			 	}
			});
		});

    
    	// 대댓글 ㅇㅇ
    	$(".reply-button").click(function() {
    		const board_no = $(this).closest('.comment-item').find('.hidden-board-no').val(); 
    		const member_name = $(this).closest('.comment-item').find('.hidden-member_name').val(); 
    		const comment_no = $(this).closest('.comment-item').find('.hidden-comment-no').val(); 
    		alert(board_no + " " + member_name + " " + comment_no);
    		
    		$("input[name='hidden-comment-reply-no']").val(comment_no);
    		
    		$("#mentionedName").text(member_name);
    	});

    });
    
    function previewImage(event) {
        const files = event.target.files;
        const track = document.querySelector(".carousel-track");

        if (!track) {
            console.error("미리보기 요소를 찾을 수 없습니다.");
            return;
        }

        const dataTransfer = new DataTransfer(); 

        Array.from(files).forEach((file) => {
            if (file.type.startsWith("image/") || file.type.startsWith("video/")) {
                const reader = new FileReader();

                reader.onload = function (e) {
                    const previewBox = document.createElement("div");
                    previewBox.className = "preview-box";

                    let mediaElement;
                    if (file.type.startsWith("image/")) {
                        mediaElement = document.createElement("img");
                        mediaElement.src = e.target.result;
                        mediaElement.alt = file.name;
                    } else if (file.type.startsWith("video/")) {
                        mediaElement = document.createElement("video");
                        mediaElement.src = e.target.result;
                        mediaElement.controls = true;  
                        mediaElement.alt = file.name;
                    }

                    const closeButton = document.createElement("div");
                    closeButton.className = "close-btn";
                    closeButton.innerText = "×";

                    closeButton.addEventListener("click", () => {
                        previewBox.remove();
                        removeFile(file);
                        togglePrevButton();
                        updateCarouselPosition();
                    });

                    previewBox.appendChild(mediaElement);
                    previewBox.appendChild(closeButton);
                    track.appendChild(previewBox);

                    dataTransfer.items.add(file);

                    togglePrevButton();
                    updateCarouselPosition();
                };

                reader.onerror = function () {
                    console.error("파일 읽기 오류 발생");
                };

                reader.readAsDataURL(file);
            } else {
                alert("이미지와 비디오 파일만 업로드할 수 있습니다.");
            }
        });

        function removeFile(fileToRemove) {
            const newDataTransfer = new DataTransfer();
            Array.from(dataTransfer.files).forEach((file) => {
                if (file !== fileToRemove) {
                    newDataTransfer.items.add(file);
                }
            });
            event.target.files = newDataTransfer.files;
        }

        function togglePrevButton() {
            const previewCount = track.querySelectorAll(".preview-box").length;
            if (previewCount === 0) {
                prevBtn.style.display = "none";
                nextBtn.style.display = "none";
            } else if (previewCount < 4) {
                prevBtn.style.display = "block";
                nextBtn.style.display = "none";
            } else {
                prevBtn.style.display = "block";
                nextBtn.style.display = "block";
            }
        }

        function updateCarouselPosition() {
            const previewCount = track.querySelectorAll(".preview-box").length;
            if (previewCount > 3) {
                currentX = parseInt($(track).css("transform").split(",")[4]) || 0;
                currentX = currentX - 208;
                $(track).css("transform", "translateX(" + currentX + "px)");
            }
        }

        event.target.files = dataTransfer.files;
    }
    
    


</script>


<div class="container m-auto grid grid-cols-14 gap-6 xl:max-w-[1140px]">

		<!-- 좌측 프로필 -->
		<div class="left-side col-span-3 hidden md:block h-full relative">
		    <div class="border-normal sticky top-20">
		        
		        <div class="h-20 relative" style="background-image: url('<%= ctxPath%>/images/쉐보레전면.jpg'); background-size: cover; background-position: center;"></div>
		        
		        <div class="flex flex-col items-center p-4 -mt-10">
		            <img src="<%= ctxPath%>/images/쉐보레전면.jpg" alt="프로필 이미지" class="w-20 h-20 rounded-full border-2 border-white relative">
		            <h2 class="text-lg font-semibold mt-2">${membervo.member_name}</h2>
		            <p class="text-gray-500 text-sm">팔로워 0명</p>
		        </div>
		
		    </div>
		</div>

        
        <!-- 중앙 본문 -->
        <div class="center col-span-14 md:col-span-7 space-y-2 m-5">
			
			<input type="hidden" id="loginuserID" value="${membervo.member_id}">
			
			<div id="write" class="border-board">
			
				<div>
                    <!-- 멤버 프로필 -->                                                              
                    <div class="board-member-profile">
                        <div>
                            <a href="#"><img src="<%= ctxPath%>/images/쉐보레전면.jpg" style="border-radius: 50%;" /></a>
                        </div>
                        <div class="flex-1">
                        	<!-- 글 작성 -->
	                        <button class="write-button button-board-action">                   
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
			                <a data-value="latest">최신순</a>
			                <a data-value="likes">좋아요순</a>
			            </div>
			        </div>
			    </div>
			</div>	<!-- div.feed-divider 끝 -->
			
            <div id="update" class="border-board">
                <!-- 게시물 동적으로 생성 -->
                <c:forEach var="boardvo" items="${boardvoList}">              
                	
                	<div>
	                    <!-- 멤버 프로필 -->                                                              
	                    <div class="board-member-profile">
	                        <div>
	                            <a href="#"><img src="<%= ctxPath%>/images/쉐보레전면.jpg" style="border-radius: 50%;" /></a>
	                        </div>
	                        <div class="flex-1">
	                            <a href="#">
	                                <c:choose>
					        			<c:when test="${membervo.member_id == boardvo.fk_member_id}">
					        				<p class="feed-post-name">${boardvo.member_name} · 나</p> 
					        			</c:when>
					        			<c:otherwise>
					        				<p class="feed-post-name">${boardvo.member_name}</p> 
					        			</c:otherwise>
					        		</c:choose>
	                                <span>팔로워 ${boardvo.countFollow}명</span>
	                            </a>
	                            <span class="time" data-time="${boardvo.board_register_date}"></span>
	                        </div>
	                        <div style="position: relative;">
	                        	<c:choose>
	                        		<c:when test="${membervo.member_id != boardvo.fk_member_id}">
			                            <button type="button" class="follow-button">
                            				<!--  <i class="fa-solid fa-plus"></i>&nbsp;팔로우-->
		                            	</button>
	                            	</c:when>
                            	</c:choose> 
	                            <button type="button" class="more-options" value="${boardvo.board_no}"><!--<i class="fa-solid fa-ellipsis"></i>-->...</button>
	                            <input type="hidden" class="board-fk_member_id" value="${boardvo.fk_member_id}" data-board-content="${boardvo.fk_member_id}" />
	                            <input type="hidden" class="board-content" value="${boardvo.board_content}" data-board-content="${boardvo.board_content}" />
	                            <input type="hidden" class="board-visibility-origin" value="${boardvo.board_visibility}" data-board-content="${boardvo.board_visibility}" />
	                            <input type="hidden" class="board-comment-allowed-origin" value="${boardvo.board_comment_allowed}" data-board-content="${boardvo.board_comment_allowed}" />
	                            
				        		<!-- 옵션 드롭다운 메뉴 -->
					            <div class="options-dropdown">
					                <ul>
					                    <c:choose>
								            <c:when test="${membervo.member_id == boardvo.fk_member_id}">
								                <li class="delete-post" value="${boardvo.board_no}">글 삭제</li>
								            	<li class="edit-post" value="${boardvo.board_no}">글 수정</li>
								                <li class="set-board-range" value="${boardvo.board_no}">허용범위</li>
								            </c:when>
								            <c:otherwise>
								            	<li class="bookmark-post" value="${boardvo.board_no}"></li>
								                <li class="interest-none" value="${boardvo.board_no}">관심없음</li>
								                <li class="report-board" value="${boardvo.board_no}">게시글 신고</li>
								            </c:otherwise>
								        </c:choose>
					                </ul>
					            </div> <!-- div.options-dropdown 끝 -->
	                        </div>
	                    </div>
	                    <!-- 글 내용 -->
	                    <div>
	                        <p>${boardvo.board_content}</p>
	                    </div>
	             

						<!-- 첨부파일 미리보기 -->
	                    <div class="px-0">
						    <div class="file-image">
						        <!-- 5장 미만 -->
						        <c:if test="${not empty boardvo.fileList and boardvo.fileList.size() < 5}">
						            <c:forEach var="file" items="${boardvo.fileList}">
						                <button type="button">
						                    <!-- 파일 확장자 추출 -->
        									<c:set var="fileExtension" value="${file.file_name.substring(file.file_name.lastIndexOf('.') + 1)}" />
        									
        									<!-- 이미지 파일인 경우 -->
									        <c:if test="${fileExtension == 'jpg' || fileExtension == 'jpeg' || fileExtension == 'png' || fileExtension == 'gif' || fileExtension == 'bmp' || fileExtension == 'webp'}">
									            <img src="<%= ctxPath%>/resources/files/${file.file_name}" />
									        </c:if>
									        
									        <!-- 비디오 파일인 경우 -->
									        <c:if test="${fileExtension == 'mp4' || fileExtension == 'avi' || fileExtension == 'mov' || fileExtension == 'mkv'}">
									            <video width="100%" controls>
									                <source src="<%= ctxPath%>/resources/files/${file.file_name}" type="video/mp4">
									            </video>
									        </c:if>
						                </button>
						            </c:forEach>
						        </c:if>
						
						        <!-- 5장 이상 -->
						        <c:if test="${not empty boardvo.fileList and boardvo.fileList.size() >= 5}">
						            <c:forEach var="file" items="${boardvo.fileList}" varStatus="status">
						                <!-- 첫 3장은 그대로 출력 -->
						                <c:if test="${status.index < 3}">
						                    <button type="button">
						                        <img src="<%= ctxPath%>/resources/files/${file.file_name}"/>
						                    </button>
						                </c:if>
						
						                <!-- 4번째 이미지는 +n 형식으로 출력 -->
						                <c:if test="${status.index == 3}">
						                    <button type="button" class="more-image">
						                        <img src="<%= ctxPath%>/resources/files/${file.file_name}"/>
						                        <span class="flex items-center">
						                            <span><i class="fa-solid fa-plus"></i></span>
						                            <span class="text-4xl">${boardvo.fileList.size() - 3}</span>
						                        </span>
						                    </button>
						                </c:if>
						            </c:forEach>
						        </c:if>
						    </div>
						</div>
	                    
	                    
	                    
	                    <!-- 반응 및 댓글 수(아무 반응 및 댓글이 없으면 표시하지 않음, 댓글만 있으면 댓글만 표시 등) -->
	                    <div>
	                        <ul class="flex gap-4 text-gray-600">
	                            <li class="flex-1">
	                                <button type="button" class="button-underline">
	                                
                                    	<c:forEach var="reactionCount" items="${reactionCountList}">
	                                		<c:if test="${reactionCount.reaction_count > 0 and boardvo.board_no == reactionCount.reaction_target_no}">
		                                		<div class="reaction-images">
													<img src="<%= ctxPath%>/images/emotion/like_small.svg"/>
			                                        <img src="<%= ctxPath%>/images/emotion/celebrate_small.svg"/>
			                                        <img src="<%= ctxPath%>/images/emotion/insightful_small.svg"/>
		                                        </div>
		                                        <span id="reactionCount" value="${boardvo.board_no}">
													${reactionCount.reaction_count}
			                                    </span>
	                                		</c:if>
								        </c:forEach>
								        
	                                </button>
	                            </li>
	                            <li>
	                                <button type="button" class="button-underline">
	                                    <span>댓글&nbsp;</span>
	                                    <span id="commentCount">${boardvo.countComment}</span>
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
	                            	<input type="hidden" name="" value="dd"/>
	                                <button type="button" class="button-board-action button-board-action-reaction" value="${boardvo.board_no}">
	                                	<div style="display: flex; align-items: center; justify-content: center; gap: 5px;">
		                                    <i class="fa-regular fa-thumbs-up"></i>
		                                    <c:set var="matched" value="false" />
		                                    
		                                    <!-- 반응 있을 때 -->
									        <c:forEach var="reactionvo" items="${reactionvoList}">
									            <c:if test="${boardvo.board_no == reactionvo.reaction_target_no}">
									                <c:choose>
									                    <c:when test="${reactionvo.reaction_status == 1}"><img class="reactions-icon artdeco-button__icon reactions-react-button__icon reactions-icon__consumption--small data-test-reactions-icon-type-LIKE data-test-reactions-icon-theme-light" src="https://static.licdn.com/aero-v1/sc/h/8ekq8gho1ruaf8i7f86vd1ftt" alt="like" data-test-reactions-icon-type="LIKE" data-test-reactions-icon-theme="light" data-test-reactions-icon-style="consumption" data-test-reactions-icon-size="small"><span data-value="1" style="color: #0A66C2; ">추천</span></c:when>
									                    <c:when test="${reactionvo.reaction_status == 2}"><img class="reactions-icon artdeco-button__icon reactions-react-button__icon reactions-icon__consumption--small data-test-reactions-icon-type-PRAISE data-test-reactions-icon-theme-light" src="https://static.licdn.com/aero-v1/sc/h/b1dl5jk88euc7e9ri50xy5qo8" alt="celebrate" data-test-reactions-icon-type="PRAISE" data-test-reactions-icon-theme="light" data-test-reactions-icon-style="consumption" data-test-reactions-icon-size="small"><span data-value="2" style="color: #44712E;">축하</span></c:when>
									                    <c:when test="${reactionvo.reaction_status == 3}"><img class="reactions-icon artdeco-button__icon reactions-react-button__icon reactions-icon__consumption--small data-test-reactions-icon-type-APPRECIATION data-test-reactions-icon-theme-light" src="https://static.licdn.com/aero-v1/sc/h/3wqhxqtk2l554o70ur3kessf1" alt="support" data-test-reactions-icon-type="APPRECIATION" data-test-reactions-icon-theme="light" data-test-reactions-icon-style="consumption" data-test-reactions-icon-size="small"><span data-value="3" style="color: #715E86;">응원</span></c:when>
									                    <c:when test="${reactionvo.reaction_status == 4}"><img class="reactions-icon artdeco-button__icon reactions-react-button__icon reactions-icon__consumption--small data-test-reactions-icon-type-EMPATHY data-test-reactions-icon-theme-light" src="https://static.licdn.com/aero-v1/sc/h/cpho5fghnpme8epox8rdcds22" alt="love" data-test-reactions-icon-type="EMPATHY" data-test-reactions-icon-theme="light" data-test-reactions-icon-style="consumption" data-test-reactions-icon-size="small"><span data-value="4" style="color: #B24020;">마음에 쏙듬</span></c:when>
									                    <c:when test="${reactionvo.reaction_status == 5}"><img class="reactions-icon artdeco-button__icon reactions-react-button__icon reactions-icon__consumption--small data-test-reactions-icon-type-INTEREST data-test-reactions-icon-theme-light" src="https://static.licdn.com/aero-v1/sc/h/lhxmwiwoag9qepsh4nc28zus" alt="insightful" data-test-reactions-icon-type="INTEREST" data-test-reactions-icon-theme="light" data-test-reactions-icon-style="consumption" data-test-reactions-icon-size="small"><span data-value="5" style="color: #915907;">통찰력</span></c:when>
									                    <c:when test="${reactionvo.reaction_status == 6}"><img class="reactions-icon artdeco-button__icon reactions-react-button__icon reactions-icon__consumption--small data-test-reactions-icon-type-ENTERTAINMENT data-test-reactions-icon-theme-light" src="https://static.licdn.com/aero-v1/sc/h/41j9d0423ck1snej32brbuuwg" alt="funny" data-test-reactions-icon-type="ENTERTAINMENT" data-test-reactions-icon-theme="light" data-test-reactions-icon-style="consumption" data-test-reactions-icon-size="small"><span data-value="6" style="color: #1A707E;">웃음</span></c:when>
									                    <c:otherwise>기타</c:otherwise>
									                </c:choose>
									                <c:set var="matched" value="true" />
									            </c:if>
									        </c:forEach>
									        
									        <!-- 반응 없을 때 -->
									        <c:if test="${!matched}">
								        		<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" id="thumbs-up-outline-small" width="16" height="16" aria-hidden="true" role="none" data-supported-dps="16x16" fill="currentColor">
  													<path d="M12.91 7l-2.25-2.57a8.21 8.21 0 01-1.5-2.55L9 1.37A2.08 2.08 0 007 0a2.08 2.08 0 00-2.06 2.08v1.17a5.81 5.81 0 00.31 1.89l.28.86H2.38A1.47 1.47 0 001 7.47a1.45 1.45 0 00.64 1.21 1.48 1.48 0 00-.37 2.06 1.54 1.54 0 00.62.51h.05a1.6 1.6 0 00-.19.71A1.47 1.47 0 003 13.42v.1A1.46 1.46 0 004.4 15h4.83a5.61 5.61 0 002.48-.58l1-.42H14V7zM12 12.11l-1.19.52a3.59 3.59 0 01-1.58.37H5.1a.55.55 0 01-.53-.4l-.14-.48-.49-.21a.56.56 0 01-.34-.6l.09-.56-.42-.42a.56.56 0 01-.09-.68L3.55 9l-.4-.61A.28.28 0 013.3 8h5L7.14 4.51a4.15 4.15 0 01-.2-1.26V2.08A.09.09 0 017 2a.11.11 0 01.08 0l.18.51a10 10 0 001.9 3.24l2.84 3z"></path>
												</svg>
												<span>추천</span>
									        </c:if>
								        </div>
	                                </button>
	                                <span class="reactions-menu reactions-menu--active reactions-menu--humor-enabled reactions-menu--v2" data-value="${boardvo.board_no}">
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
	                                <button type="button" class="button-board-action button-board-action-comment">
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
	                    </div> <!-- 추천 댓글 퍼가기 등 버튼 -->
	                    
	                    <div class="comment-input-container" id="commentInputContainer">
	                    	<div class="comment-profile">
	                    		<input type="hidden" value="${boardvo.board_no}" />
	                    		
		                    	<div class="profile-image"><img src="<%= ctxPath%>/images/쉐보레전면.jpg" alt="프로필 사진" /></div>
		                    	<div class="comment-input" >
		                    		<span id="mentionedName" style="color: #084B99; font-weight: bold; margin-right: 5px;"></span>
							        <input type="text" placeholder="댓글 남기기" id="commentInput">
						            <button class="comment-submit-button">댓글</button>
						            <input type="text" name="hidden-comment-reply-no" value="" />
							    </div>	
	                    	</div>
	                    	
	                    	
	                    	<div class="comment-list-container">
	                    		<div class="comment-sort">
	                    			<select id="sortOption">
						                <option value="recent">최신순</option>
						                <option value="relevant">관련순</option>
						            </select>
	                    		</div>
	                    	</div>
	                    	
	                    	<ul class="comment-list"> 
	                    		<c:if test="${not empty commentvoList}">
		                    		<c:forEach var="commentvo" items="${commentvoList}">  
		                    			<c:if test="${boardvo.board_no == commentvo.fk_board_no}">
			                    			<li class="comment-item">
												<div class="profile-image"><img src="<%= ctxPath%>/images/쉐보레전면.jpg" alt="프로필 사진"></div>
												<div class="comment-content">
													<div class="comment-info">
														<input type="hidden" value="${commentvo.fk_board_no}"  class="hidden-board-no">
														<input type="hidden" value="${commentvo.comment_no}"   class="hidden-comment-no">
														<input type="hidden" value="${commentvo.fk_member_id}" class="hidden-member-id">
														<input type="hidden" value="${commentvo.member_name}" class="hidden-member_name">
														
														<span class="comment-author">${commentvo.member_name}</span>
														<!--<span class="comment-relationship">팔로워 0명</span>-->
														<span class="comment-date" data-time="${commentvo.comment_register_date}">5일</span> 
														<button class="comment-options">...</button>
													</div>
													<div class="comment-text">
													
														<span class="comment-content-text">${commentvo.comment_content}</span>
														
														<div class="comment-input" id="comment-edit-input" style="display:none;" >
															<input type="text" id="edit-input" value="${commentvo.comment_content}" style="width: 100%; "/>
															<button class="comment-edit-button">수정</button>
														</div>
													</div>
													
													<div class="comment-actions">
														<button class="like-button">추천</button>
									                    <span>|</span>
									                    <button class="reply-button">답장</button> <!-- ㅇㅇ -->
									                </div>
									                
									                
												</div>     
												
												<!-- 옵션 드롭다운 메뉴 -->
												<c:if test="${membervo.member_id == commentvo.fk_member_id}">
										            <div class="options-dropdown2">
										                <ul>
											                <li class="comment-delete" value="${boardvo.board_no}">댓글 삭제</li>
											                <li class="comment-edit" value="${boardvo.board_no}">댓글 수정</li>
										                </ul>
									            	</div> 
												</c:if>
												<c:if test="${membervo.member_id != commentvo.fk_member_id}">
										            <div class="options-dropdown2">
										                <ul>
											                <li class="delete-post2" value="${boardvo.board_no}">댓글 신고</li>
										                </ul>
									            	</div> 
												</c:if>
												<!-- div.options-dropdown 끝 -->
				                    		</li>
				                    		
			                    		</c:if>
		                    		</c:forEach>
	                    		</c:if>
	                    	</ul>
	                    	
	                    	
	                    	
	                    </div> <!-- div.comment-input-container 끝 -->

                    </div>
               	</c:forEach>
           	</div> <!-- div#update 끝 -->
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
                            <h3 class="modal-profile-name">${membervo.member_name}</h3> 	
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

					
					<!-- 이미지 미리보기 영역 -->
					<div id="carousel-container">
					    <button id="prevBtn" class="carousel-btn">〈</button>
					
					    <div id="image-preview-container">
					        <div class="carousel-track">
					        </div>
					    </div>
					
					    <button id="nextBtn" class="carousel-btn">〉</button>
					</div>

					
			
                    <div class="ql-category">
	                    <div>
	                    	<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" id="image-medium" class="hidden-svg" aria-hidden="true" role="none" data-supported-dps="24x24" fill="currentColor" type="image" onclick="document.getElementById('file-image').click();">
							  	<path d="M19 4H5a3 3 0 00-3 3v10a3 3 0 003 3h14a3 3 0 003-3V7a3 3 0 00-3-3zm1 13a1 1 0 01-.29.71L16 14l-2 2-6-6-4 4V7a1 1 0 011-1h14a1 1 0 011 1zm-2-7a2 2 0 11-2-2 2 2 0 012 2z"></path>
							</svg>
                    		<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" id="video-medium" class="hidden-svg" aria-hidden="true" role="none" data-supported-dps="24x24" fill="currentColor" type="video" onclick="document.getElementById('file-video').click();">
								<path d="M19 4H5a3 3 0 00-3 3v10a3 3 0 003 3h14a3 3 0 003-3V7a3 3 0 00-3-3zm-9 12V8l6 4z"></path>
							</svg>
							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" id="sticky-note-medium" class="hidden-svg" aria-hidden="true" role="none" data-supported-dps="24x24" fill="currentColor" onclick="document.getElementById('file-attachment').click();">
							  <path d="M3 3v15a3 3 0 003 3h9v-6h6V3zm9 8H6v-1h6zm6-3H6V7h12zm-2 8h5l-5 5z"></path>
							</svg>
	                    </div>
						<div>
							<button type="button" id="write-update">업데이트</button>					
						</div>
						<form name="addFrm" enctype="multipart/form-data">
				            <input type="hidden" name="fk_member_id" value="${membervo.member_id}" /> 	
				            <input type="hidden" name="board_content" value="" />
				            <input type="hidden" name="board_visibility" value="" />
				            <input type="file" name="attach" id="file-image" style="display:none;" accept="image/*, video/*" onchange="previewImage(event)" multiple/>
				            <!-- <input type="file" name="board_attachment" id="file-attachment" style="display:none;" accept=".pdf,.doc,.docx,.xlsx,.pptx,.txt,.csv" /> -->
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
					
				    <!-- 이미지 미리보기 영역 -->
					<div id="carousel-container2">
					    <button id="prevBtn2" class="carousel-btn">〈</button>
					
					    <div id="image-preview-container2">
					        <div class="carousel-track">
					        </div>
					    </div>
					
					    <button id="nextBtn2" class="carousel-btn">〉</button>
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
				            <input type="hidden" name="board_visibility" value="" />
				            <input type="file" name="board_image" id="file-image" style="display:none;" onchange="previewImage(event)" />
				            <input type="file" name="board_video" id="file-video" style="display:none;" />
				            <input type="file" name="board_attachment" id="file-attachment" style="display:none;" />
			            </form>
			        </div> <!-- div.ql-category 끝 -->
                </div> <!-- div.content-bottom 끝 -->
            </div> <!-- div.modal-content 끝 -->
        </div> <!-- div.modal 끝 -->
        <!-- ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ -->
        
        
        <!-- ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ -->
        <!-- 허용범위 Modal -->
		<div id="rangeModal" class="modal">
		    <div class="modal-content">
		        <span class="close" id="closeRangeModal">&times;</span>
		        <h1 style="font-weight: bold;">게시글 허용범위 설정</h1>
		
		        <input type="hidden" name="board_no" value="">
		        <input type="hidden" name="rangeModal_board_visibility" value="">
		        <input type="hidden" name="rangeModal_board_comment-allowed" value="">
		
		        <div class="option-group">
		            <label class="option-card">
		                <input type="radio" name="board_visibility" value="1">
		                <div class="option-content">
		                    <strong>🌐 전체공개</strong>
		                    <p>모든 사람이 볼 수 있어요.</p>
		                </div>
		            </label>
		            <label class="option-card">
		                <input type="radio" name="board_visibility" value="2">
		                <div class="option-content">
		                    <strong>👥 친구공개</strong>
		                    <p>내 친구만 볼 수 있어요.</p>
		                </div>
		            </label>
		        </div>
		
		        <hr class="divider">
		
		        <h1 style="font-weight: bold;">댓글 허용범위 설정</h1>
		
		        <div class="option-group">
		            <label class="option-card">
		                <input type="radio" name="comment_visibility" value="1">
		                <div class="option-content">
		                    <strong>💬 모두</strong>
		                    <p>누구나 댓글을 작성할 수 있어요.</p>
		                </div>
		            </label>
		            <label class="option-card">
		                <input type="radio" name="comment_visibility" value="2">
		                <div class="option-content">
		                    <strong>🧑‍🤝‍🧑 친구만</strong>
		                    <p>내 친구만 댓글을 작성할 수 있어요.</p>
		                </div>
		            </label>
		            <label class="option-card">
		                <input type="radio" name="comment_visibility" value="3">
		                <div class="option-content">
		                    <strong>🚫 비허용</strong>
		                    <p>댓글을 허용하지 않아요.</p>
		                </div>
		            </label>
		        </div>
		
		        <button type="button" id="saveRange" class="save-btn">저장</button>
		    </div>
		</div>

        <!-- ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ -->
		        
        <!-- ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ -->
        <!-- 반응 Modal -->
		<div id="reactionModal" class="modal">
    		<div class="reactionmodal-content">
			
				<!-- 모달 헤더 -->
				<div class="reactionmodal-header">
					<h2>반응</h2>
					<input type="hidden" name="reaction_target_no" value="">
					<span class="close" id="closeModalButton">&times;</span>
				</div>
	
				<!-- 반응 카테고리 -->
				<div class="reaction-tabs">
					<button class="active" value="7">전체 <span id="reaction-all"></span></button>
					<button value="1" class="reaction-modal-button">
						<img class="reactions-icon social-details-reactors-tab__icon reactions-icon__consumption--medium data-test-reactions-icon-type-LIKE data-test-reactions-icon-theme-light" src="https://static.licdn.com/aero-v1/sc/h/2uxqgankkcxm505qn812vqyss" alt="like" data-test-reactions-icon-type="LIKE" data-test-reactions-icon-theme="light" data-test-reactions-icon-style="consumption" data-test-reactions-icon-size="medium"> 
						<span id="reaction-like"></span>
					</button>
					<button value="2" class="reaction-modal-button">
						<img class="reactions-icon social-details-reactors-tab__icon reactions-icon__consumption--medium data-test-reactions-icon-type-PRAISE data-test-reactions-icon-theme-light" src="https://static.licdn.com/aero-v1/sc/h/cm8d2ytayynyhw5ieaare0tl3" alt="celebrate" data-test-reactions-icon-type="PRAISE" data-test-reactions-icon-theme="light" data-test-reactions-icon-style="consumption" data-test-reactions-icon-size="medium"> 
						<span id="reaction-praise"></span>
					</button>
					<button value="3" class="reaction-modal-button">
						<img class="reactions-icon social-details-reactors-tab__icon reactions-icon__consumption--medium data-test-reactions-icon-type-APPRECIATION data-test-reactions-icon-theme-light" src="https://static.licdn.com/aero-v1/sc/h/e1vzxs43e7ryd6jfvu7naocd2" alt="support" data-test-reactions-icon-type="APPRECIATION" data-test-reactions-icon-theme="light" data-test-reactions-icon-style="consumption" data-test-reactions-icon-size="medium"> 
						<span id="reaction-empathy"></span>
					</button>
					<button value="4" class="reaction-modal-button">
						<img class="reactions-icon social-details-reactors-tab__icon reactions-icon__consumption--medium data-test-reactions-icon-type-EMPATHY data-test-reactions-icon-theme-light" src="https://static.licdn.com/aero-v1/sc/h/f58e354mjsjpdd67eq51cuh49" alt="love" data-test-reactions-icon-type="EMPATHY" data-test-reactions-icon-theme="light" data-test-reactions-icon-style="consumption" data-test-reactions-icon-size="medium"> 
						<span id="reaction-appreciation"></span>
					</button>
					<button value="5" class="reaction-modal-button">
						<img class="reactions-icon social-details-reactors-tab__icon reactions-icon__consumption--medium data-test-reactions-icon-type-INTEREST data-test-reactions-icon-theme-light" src="https://static.licdn.com/aero-v1/sc/h/6gz02r6oxefigck4ye888wosd" alt="insightful" data-test-reactions-icon-type="INTEREST" data-test-reactions-icon-theme="light" data-test-reactions-icon-style="consumption" data-test-reactions-icon-size="medium"> 
						<span id="reaction-interest"></span>
					</button>
					<button value="6" class="reaction-modal-button">
						<img class="reactions-icon social-details-reactors-tab__icon reactions-icon__consumption--medium data-test-reactions-icon-type-ENTERTAINMENT data-test-reactions-icon-theme-light" src="https://static.licdn.com/aero-v1/sc/h/6namow3mrvcg3dyuevtpfwjm0" alt="funny" data-test-reactions-icon-type="ENTERTAINMENT" data-test-reactions-icon-theme="light" data-test-reactions-icon-style="consumption" data-test-reactions-icon-size="medium"> 
						<span id="reaction-entertainment"></span>
					</button>
				</div>

				<!-- 반응 목록 -->
				<div class="reaction-list"></div>
			</div>
	  	</div>
        <!-- ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ -->
        
        
        <!-- ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ -->
        <!-- 관심없음 Modal -->
	    <div id="ignoredModal" class="modal">
		    <div class="modal-content" style="width: 600px; height: 400px;">
	
				<!-- 모달 헤더 -->
				<div class="ignoredModal-header">
					<input type="hidden" name="ignored_fk_board_no" value="">
					
					<h2>앞으로 표시하지 않기</h2>
					<span class="close" id="closeModalButton">&times;</span>
				</div>

				<hr class="border-gray-300 mx-4">

				<!--모달 내용 -->
				<div class="ignoredModal-body">
					<p>홈 개선에 도움이 필요한 이유를 알려주세요.</p>
					<ul class="reason-list">
					    <li><label><input type="radio" name="reason" value="writer"> 글쓴이에게 관심 없음</label></li>
					    <li><label><input type="radio" name="reason" value="topic"> 이 주제에 관심 없음</label></li>
					    <li><label><input type="radio" name="reason" value="too_much"> 관련 글을 너무 많이 봤음</label></li>
					    <li><label><input type="radio" name="reason" value="seen_before"> 전에 이 글을 봤음</label></li>
					    <li><label><input type="radio" name="reason" value="too_old"> 글이 너무 오래 됐음</label></li>
					    <li><label><input type="radio" name="reason" value="etc"> 기타</label></li>
					</ul>
				</div>
		    	
		    	<div style="display: flex; justify-content: flex-end; margin-right: 20px;">
			    	<button type="button" id="saveIgnored" class="save-btn">전송</button>
		    	</div>
		    	
		    </div>
		</div>    
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
