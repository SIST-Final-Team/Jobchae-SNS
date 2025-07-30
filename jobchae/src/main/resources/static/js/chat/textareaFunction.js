


	// textarea 설정
	function adjustTextareaHeight(textarea) {
    	textarea.style.height = 'auto';
    	let lineHeight = parseFloat(getComputedStyle(textarea).lineHeight);

    	// lineHeight가 숫자가 아닌 경우 기본값 설정 (예: 20px)
    	if (isNaN(lineHeight)) {
    	    lineHeight = 20;
    	}

    	const maxHeightInPixels = 7 * lineHeight; // 7줄 높이
    	const scrollHeight = textarea.scrollHeight;

    	// 내용이 7줄 높이를 초과하면 스크롤바 표시, 그렇지 않으면 스크롤바 숨김
    	if (scrollHeight > maxHeightInPixels) {
        	textarea.style.overflowY = 'auto';
    	} else {
        	textarea.style.overflowY = 'hidden';
    	}

    	// 높이 조정
    	textarea.style.height = Math.min(scrollHeight, maxHeightInPixels) + 'px';
	}//end of function adjustTextareaHeight(textarea) {}...