package com.spring.app.board.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import com.spring.app.alarm.domain.AlarmData;
import com.spring.app.alarm.domain.AlarmVO;
import com.spring.app.alarm.service.AlarmService;
import com.spring.app.board.model.BoardDAO;
import com.spring.app.follow.domain.FollowEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.board.domain.BoardVO;
import com.spring.app.board.service.BoardService;
import com.spring.app.common.FileManager;
import com.spring.app.file.domain.FileVO;
import com.spring.app.member.domain.MemberVO;
import com.spring.app.reaction.domain.ReactionVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping(value="/api/board/*")
public class ApiBoardController {

	@Autowired
	BoardService service;
	
	@Autowired  
	private FileManager fileManager;
    @Autowired
    private BoardDAO boardDAO;
    @Autowired
    private BoardService boardService;


	@Autowired
	private AlarmService alarmService;

	// 글 삭제
	@PostMapping("deleteBoard")
	@ResponseBody
	public Map<String, Integer> deleteBoard(HttpServletRequest request, @RequestParam String board_no, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String fk_member_id = loginuser.getMember_id();
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("fk_member_id", fk_member_id);
		paraMap.put("board_no", board_no);
		
		int n = service.deleteBoard(paraMap);
		//int n2 = service.deleteFile(paraMap);
		
		if (n != 1) {
			mav.addObject("message", "삭제 과정에서 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.");
			mav.addObject("loc", "javascript:history.back()");
			mav.setViewName("msg");
		}
		
		Map<String, Integer> map = new HashMap<>();
		map.put("n", n);
		
		return map; 
	}
	
	
	// 글 허용범위
	@PostMapping("updateBoardVisibility")
	@ResponseBody
	public Map<String, Integer> updateBoardVisibility(HttpServletRequest request, @RequestParam String board_no, @RequestParam String board_visibility, @RequestParam String board_comment_allowed, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String fk_member_id = loginuser.getMember_id();
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("fk_member_id", fk_member_id);
		paraMap.put("board_no", board_no);
		paraMap.put("board_visibility", board_visibility);
		paraMap.put("board_comment_allowed", board_comment_allowed);
		
		int n = service.updateBoardVisibility(paraMap);
		
		if (n != 1) {
			mav.addObject("message", "게시글 설정 과정에서 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.");
			mav.addObject("loc", "javascript:history.back()");
			mav.setViewName("msg");
		}
		
		Map<String, Integer> map = new HashMap<>();
		map.put("n", n);
		
		return map; 
	}
	
	
	// 게시물 반응
	@PostMapping("reactionBoard")
	@ResponseBody
	public Map<String, Integer> reactionBoard(HttpServletRequest request, @RequestParam String reaction_target_no, @RequestParam String reaction_status, ModelAndView mav) {
	
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String fk_member_id = loginuser.getMember_id();
	
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("fk_member_id", fk_member_id);
		paraMap.put("reaction_target_no", reaction_target_no);
		paraMap.put("reaction_status", reaction_status);

		//알림 설정

		AlarmData alarmData = new AlarmData();
		alarmData.setBoardId(reaction_target_no);
		//알림에 들어갈 게시글 내용
		BoardVO board = boardDAO.findOneBoardByBoardNo(reaction_target_no);
		alarmData.setBoardContent(board.getBoard_content());

		alarmService.insertAlarm(loginuser, board.getFk_member_id(), AlarmVO.NotificationType.LIKE, alarmData);


		//알림 설정 끝
	
		ReactionVO reactionvo = service.selectReaction(paraMap);
		if (reactionvo != null) {	// 이미 반응 누른 경우, 유니크키 때문에 update 처리 
			
			int n = service.updateReactionBoard(paraMap);
			
			if (n != 1) {
				mav.addObject("message", "추천 과정에서 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.");
				mav.addObject("loc", "javascript:history.back()");
				mav.setViewName("msg");
			}
			
			Map<String, Integer> map = new HashMap<>();
			map.put("n", n);
			
			return map; 
		} else {
			
			int n = service.reactionBoard(paraMap);
			
			if (n != 1) {
				mav.addObject("message", "추천 과정에서 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.");
				mav.addObject("loc", "javascript:history.back()");
				mav.setViewName("msg");
			}
			
			Map<String, Integer> map = new HashMap<>();
			map.put("n", n);
			
			return map;
		}
		
	}
	
	// 게시물 반응 삭제
	@PostMapping("deleteReactionBoard")
	@ResponseBody
	public Map<String, Integer> deleteReactionBoard(HttpServletRequest request, @RequestParam String reaction_target_no, ModelAndView mav) {
	
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String fk_member_id = loginuser.getMember_id();
	
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("fk_member_id", fk_member_id);
		paraMap.put("reaction_target_no", reaction_target_no);
	
		int n = service.deleteReactionBoard(paraMap);
	
		if (n != 1) {
			mav.addObject("message", "추천 삭제 과정에서 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.");
			mav.addObject("loc", "javascript:history.back()");
			mav.setViewName("msg");
		}
		
		Map<String, Integer> map = new HashMap<>();
		map.put("n", n);
		
		return map; 
	}
	
	
	// 게시물 반응 개수 조회하기
	@PostMapping("getReactionCounts")
	@ResponseBody
	public Map<String, String> getReactionCounts(HttpServletRequest request, @RequestParam String reaction_target_no) {
		
		Map<String, String> reactionCounts = service.getReactionCounts(reaction_target_no);
		//System.out.println("Reaction Counts: " + reactionCounts);
		
		// Map.Entry를 기준으로 내림차순 정렬
	    Map<String, String> sortedReactionCounts = reactionCounts.entrySet()
	        .stream()
	        .filter(entry -> !entry.getKey().equals("7"))
	        .sorted((entry1, entry2) -> Integer.parseInt(entry2.getValue()) - Integer.parseInt(entry1.getValue()))
	        .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue, (e1, e2) -> e1, LinkedHashMap::new));

	    // 콘솔에 출력
	    //sortedReactionCounts.forEach((key, value) -> 
	    //    System.out.println("Reaction Type: " + key + ", Count: " + value)
	    //);
	    
		return reactionCounts;
	}

	@PostMapping("getReactionMembers")
	@ResponseBody
	public Map<String, Object> getReactionMembers(HttpServletRequest request, @RequestParam String reaction_target_no, @RequestParam String reaction_status) {

		//System.out.println("reaction_target_no: " + reaction_target_no);
		//System.out.println("reaction_status: " + reaction_status);

		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("reaction_target_no", reaction_target_no);
		paraMap.put("reaction_status", reaction_status);

		List<MemberVO> reaction_membervoList = service.getReactionMembers(paraMap);
		
		/*
		for (MemberVO member : reaction_membervoList) {
		    System.out.println("Member ID: " + member.getMember_id());
		    System.out.println("Member Name: " + member.getMember_name());
		    System.out.println("Member Profile: " + member.getMember_profile());
		    System.out.println("-------------------------------");
		}
		*/
		
	// 게시물 반응별 유저 조회하기
		
		Map<String, Object> map = new HashMap<>();
		map.put("membervo", reaction_membervoList);
		return map;
	}
		
	
	// 게시글 정렬
	@GetMapping("feed")
	@ResponseBody
	public Map<String, Object> feed(HttpServletRequest request, @RequestParam String sort) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String login_userid = loginuser.getMember_id();
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("login_userid", login_userid);
		paraMap.put("sort", sort);
		List<BoardVO> boardvoList = service.getAllBoards(paraMap);
		
		//for (BoardVO boardvo : boardvoList) {
		    //System.out.println("Board No: " + boardvo.getBoard_register_date());
		//}
		//System.out.println();
		
		
		// 피드 순회하면서 첨부파일 있는 피드 조회
		for (BoardVO boardvo : boardvoList) {
			String board_no = boardvo.getBoard_no();
	        List<FileVO> filevoList = service.getFiles(board_no);
	        boardvo.setFileList(filevoList); 
	        //System.out.println(board_no + " : " + boardvo.getFileList().size());
	        
	        // 팔로워 수 구하기
	        String following_id = boardvo.getFk_member_id();
	        int followerCount = service.getFollowerCount(following_id);
	        boardvo.setCountFollow(String.valueOf(followerCount)); 
	        //System.out.println("boardvo.getCountFollow() " + boardvo.getCountFollow());
	        
	        // 반응 많은 순 상위 1~3개 추출하기
	        //List<String> reactionCounts = service.getReactionCountsByBoard(board_no);
	        //System.out.println("board_no Reaction Counts: " + reactionCounts);
		}
		
		MemberVO membervo = service.getUserInfo(login_userid);
		
		Map<String, Object> map = new HashMap<>();
		map.put("boardvoList", boardvoList);
		map.put("membervo", membervo);
		return map;
	}
	
	// 북마크 조회하기
	@PostMapping("selectBookmarkBoard")
	@ResponseBody
	public Map<String, Integer> selectBookmarkBoard(HttpServletRequest request, @RequestParam String fk_member_id, @RequestParam String bookmark_target_no) {

		//System.out.println("fk_member_id : " + fk_member_id);
		//System.out.println("bookmark_target_no : " + bookmark_target_no);
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("fk_member_id", fk_member_id);
		paraMap.put("bookmark_target_no", bookmark_target_no);
		boolean isBookmarked = service.selectBookmarkBoard(paraMap);
		//System.out.println("isBookmarked : " + isBookmarked);
		
		Map<String, Integer> map = new HashMap<>();
		
		if (isBookmarked) {
			map.put("status", 1);	// 이미 북마크된 상태
		} else {
			map.put("status", 0);
		}
		
		return map; 
	}
	
	// 게시글 북마크 추가하기
	@PostMapping("addBookmarkBoard")
	@ResponseBody
	public Map<String, Integer> addBookmarkBoard(HttpServletRequest request, @RequestParam String fk_member_id, @RequestParam String bookmark_target_no) {

		//System.out.println("fk_member_id : " + fk_member_id);
		//System.out.println("bookmark_target_no : " + bookmark_target_no);
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("fk_member_id", fk_member_id);
		paraMap.put("bookmark_target_no", bookmark_target_no);
		int n = service.addBookmarkBoard(paraMap);
		
		Map<String, Integer> map = new HashMap<>();
		map.put("n", n);
		
		return map; 
	}
	
	// 게시글 북마크 삭제하기
	@PostMapping("deleteBookmarkBoard")
	@ResponseBody
	public Map<String, Integer> deleteBookmarkBoard(HttpServletRequest request, @RequestParam String fk_member_id, @RequestParam String bookmark_target_no) {

		//System.out.println("fk_member_id : " + fk_member_id);
		//System.out.println("bookmark_target_no : " + bookmark_target_no);
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("fk_member_id", fk_member_id);
		paraMap.put("bookmark_target_no", bookmark_target_no);
		int n = service.deleteBookmarkBoard(paraMap);
		
		Map<String, Integer> map = new HashMap<>();
		map.put("n", n);
		
		return map; 
	}
	
	// 댓글 등록하기
	@PostMapping("addComment")
	@ResponseBody
	public Map<String, Integer> addComment(HttpServletRequest request, @RequestParam String fk_board_no, @RequestParam String fk_member_id, @RequestParam String comment_content) {

		//System.out.println("fk_board_no : " + fk_board_no);
		//System.out.println("fk_member_id : " + fk_member_id);
		//System.out.println("comment_content : " + comment_content);
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("fk_board_no", fk_board_no);
		paraMap.put("fk_member_id", fk_member_id);
		paraMap.put("comment_content", comment_content);
		int n = service.addComment(paraMap);

		//알림 삽입 시작
		HttpSession session = request.getSession();

		AlarmData alarmData = new AlarmData();
		alarmData.setBoardId(fk_board_no);
		//알림에 들어갈 게시글 내용
		BoardVO board = boardDAO.findOneBoardByBoardNo(fk_board_no);
		alarmData.setBoardContent(board.getBoard_content());
		//알림에 들어갈 댓글 내용
		alarmData.setCommentContent(comment_content);

		alarmService.insertAlarm((MemberVO)session.getAttribute("loginuser"), board.getFk_member_id(), AlarmVO.NotificationType.COMMENT, alarmData);

		//알림 삽입 끝
		Map<String, Integer> map = new HashMap<>();
		map.put("n", n);
		return map; 
	}
	
	// 댓글 삭제하기
	@PostMapping("deleteComment")
	@ResponseBody
	public Map<String, Integer> deleteComment(HttpServletRequest request, @RequestParam String fk_board_no, @RequestParam String fk_member_id, @RequestParam String comment_no, @RequestParam String comment_depth) {

		//System.out.println("fk_board_no : " + fk_board_no);
		//System.out.println("fk_member_id : " + fk_member_id);
		//System.out.println("comment_no : " + comment_no);
		//System.out.println("comment_depth : " + comment_depth);
		
		int n = 0;
		if ("0".equals(comment_depth)) {
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("fk_board_no", fk_board_no);
			paraMap.put("fk_member_id", fk_member_id);
			paraMap.put("comment_no", comment_no);
			
			service.deleteComment(paraMap);
			n = 1;
		} else {
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("fk_board_no", fk_board_no);
			paraMap.put("fk_member_id", fk_member_id);
			paraMap.put("comment_no", comment_no);
			n = service.deleteReplyComment(paraMap);
			System.out.println(n);
		}
		
		Map<String, Integer> map = new HashMap<>();
		map.put("n", n);
		return map; 
	}
	
	
	// 댓글 수정하기
	@PostMapping("editComment")
	@ResponseBody
	public Map<String, Integer> editComment(HttpServletRequest request, @RequestParam String fk_board_no, @RequestParam String fk_member_id, @RequestParam String comment_no, @RequestParam String comment_content) {

		//System.out.println("fk_board_no : " + fk_board_no);
		//System.out.println("fk_member_id : " + fk_member_id);
		//System.out.println("comment_no : " + comment_no);
		//System.out.println("comment_content : " + comment_content);
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("fk_board_no", fk_board_no);
		paraMap.put("fk_member_id", fk_member_id);
		paraMap.put("comment_no", comment_no);
		paraMap.put("comment_content", comment_content);
		int n = service.editComment(paraMap);
		
		Map<String, Integer> map = new HashMap<>();
		map.put("n", n);
		return map; 
	}
	
	
	// 관심없음 등록하기
	@PostMapping("ignoredBoard")
	@ResponseBody
	public Map<String, Integer> ignoredBoard(HttpServletRequest request, @RequestParam String fk_member_id, @RequestParam String fk_board_no) {

		//System.out.println("fk_board_no : " + fk_board_no);
		//System.out.println("fk_member_id : " + fk_member_id);
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("fk_board_no", fk_board_no);
		paraMap.put("fk_member_id", fk_member_id);
		int n = service.ignoredBoard(paraMap);
		
		Map<String, Integer> map = new HashMap<>();
		map.put("n", n);
		return map; 
	}
	
	
	// 대댓글 등록하기
	@PostMapping("addCommentReply")
	@ResponseBody
	public Map<String, Integer> addCommentReply(HttpServletRequest request, @RequestParam String fk_board_no, @RequestParam String fk_member_id, @RequestParam String comment_content, @RequestParam String comment_no) {

		//System.out.println("fk_board_no : " + fk_board_no);
		//System.out.println("fk_member_id : " + fk_member_id);
		//System.out.println("comment_content : " + comment_content);
		//System.out.println("comment_no : " + comment_no);
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("fk_board_no", fk_board_no);
		paraMap.put("fk_member_id", fk_member_id);
		paraMap.put("comment_content", comment_content);
		paraMap.put("comment_no", comment_no);
		int n = service.addCommentReply(paraMap);
		
		Map<String, Integer> map = new HashMap<>();
		map.put("n", n);
		return map; 
	}
	
	
	// 파일 조회하기
	@PostMapping("selectFileList")
	@ResponseBody
	public Map<String, Object> selectFileList(HttpServletRequest request, @RequestParam String file_target_no) {

		//System.out.println("file_target_no : " + file_target_no);
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("file_target_no", file_target_no);
		List<FileVO> filevoList = service.selectFileList(paraMap);
		
		
		Map<String, Object> map = new HashMap<>();
		map.put("filevoList", filevoList);
		return map; 
	}
	
	
	// 게시글 수정
	@PostMapping("editBoard")
	@ResponseBody
	public Map<String, Object> editBoard(HttpServletRequest request, @RequestParam String board_no, @RequestParam String fk_member_id, @RequestParam String board_content, @RequestParam String board_visibility, @RequestParam(required = false) List<String> fileNoList, ModelAndView mav) {
		
		//fileNoList는 삭제하면 안 되는 파일들
		
		//System.out.println("board_no : " + board_no);
		//System.out.println("fk_member_id : " + fk_member_id);
		//System.out.println("board_content : " + board_content);
		//System.out.println("board_visibility : " + board_visibility);
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("board_no", board_no);
		paraMap.put("fk_member_id", fk_member_id);
		paraMap.put("board_content", board_content);
		paraMap.put("board_visibility", board_visibility);
		int n = service.editBoard(paraMap); 
		
		List<FileVO> filevoList = service.selectFileList2(board_no);
		
		int n2 = 1;
		
		if (fileNoList != null) {
			// 삭제할 파일 목록 찾기
		    List<String> deleteFileList = new ArrayList<>();
		    for (FileVO file : filevoList) {
		        String fileNo = String.valueOf(file.getFile_no());
		        if (!fileNoList.contains(fileNo)) { 
		            deleteFileList.add(fileNo);
		        }
		    }
		    if (!deleteFileList.isEmpty()) {
		        n2 *= service.deleteFiles(deleteFileList);
		    }
		} else {	// 첨부파일을 다 삭제하려는 경우
			List<String> deleteFileList = new ArrayList<>();
		    for (FileVO file : filevoList) {
		        deleteFileList.add(String.valueOf(file.getFile_no()));
		    }
		    
		    if (!deleteFileList.isEmpty()) {
		    	n2 *= service.deleteFiles(deleteFileList);
		    }
		}
		
		if (n * n2 != 1) {
			mav.addObject("message", "오류가 발생했습니다. 잠시 후 다시 시도해 주세요.");
			mav.addObject("loc", "javascript:history.back()");
			mav.setViewName("msg");
		}
		
		Map<String, Object> map = new HashMap<>();
		map.put("n", n);
		return map; 
	}



	
	
}
