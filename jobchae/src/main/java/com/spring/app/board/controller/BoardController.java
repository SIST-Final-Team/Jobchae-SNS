package com.spring.app.board.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import com.spring.app.alarm.domain.AlarmData;
import com.spring.app.alarm.domain.AlarmVO;
import com.spring.app.alarm.service.AlarmService;
import com.spring.app.follow.domain.FollowEntity;
import com.spring.app.follow.service.FollowService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.board.domain.BoardVO;
import com.spring.app.board.service.BoardService;
import com.spring.app.common.FileManager;
import com.spring.app.file.domain.FileVO;
import com.spring.app.member.domain.MemberVO;
import com.spring.app.reaction.domain.ReactionVO;
import com.spring.app.comment.domain.CommentVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping(value="/board/*")
public class BoardController {

	@Autowired
	BoardService service;
	
	@Autowired  
	private FileManager fileManager;

	@Autowired
	private FollowService followService;

	@Autowired
	private AlarmService alarmService;

	@Autowired
	private SimpMessagingTemplate simpMessagingTemplate;
	
	// 피드 조회하기
	@GetMapping("feed")
	public ModelAndView requiredLogin_feed(HttpServletRequest request, HttpServletResponse reponse, ModelAndView mav, @RequestParam(required = false) String sort) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
//		MemberVO loginuser = new MemberVO(); // feat: 이준영, 기능 구현 중 오류발생하여 주석처리함
//		loginuser.setMember_id("user001");
//		session.setAttribute("loginuser", loginuser);
		String login_userid = loginuser.getMember_id();
		
		// 로그인된 사용자의 정보 얻어오기
		MemberVO membervo = service.getUserInfo(login_userid);
		
		if (sort == null || sort.isEmpty()) {
			sort = "latest"; // 기본값을 최신순으로 설정
		}
		//System.out.println("sort " + sort);
		
		// 피드 조회하기
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("login_userid", login_userid);
		paraMap.put("sort", sort);
		List<BoardVO> boardvoList = service.getAllBoards(paraMap);
		
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
	        
	        // 반응 많은 순 상위 1~3개 추출하기 시작
	        Map<String, String> topReactionsList = service.getTopReactionsForBoard(board_no);
	        
	        // 예시로 첫 번째 상태인 1의 반응 개수를 출력
	        //System.out.println(topReactionsList);
	        
	        
	        List<Map.Entry<String, String>> entryList = new ArrayList<>(topReactionsList.entrySet());
	        
	        // 값 기준으로 내림차순 정렬 (String을 Integer로 변환하여 비교)
	        entryList = entryList.stream()
	        	    .filter(entry -> Integer.parseInt(entry.getValue()) != 0)  
	        	    .sorted((entry1, entry2) -> Integer.compare(Integer.parseInt(entry2.getValue()), Integer.parseInt(entry1.getValue())))  
	        	    .collect(Collectors.toList());
	        
	        // 상위 1~3개만 추출
	        Map<String, String> topReactionList = entryList.stream()
	            .limit(3)  
	            .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue));

	        boardvo.setTopReactionList(topReactionList);
	        
	        //System.out.println(boardvo.getTopReactionList());
	        // 반응 많은 순 상위 1~3개 추출하기 끝
	        
	        // 댓글 수 구하기
	        int countComment = service.getCommentCount(board_no);
	        boardvo.setCountComment(String.valueOf(countComment));
	        //System.out.println("countComment : " + countComment);
	        
	        // 댓글 조회하기
	        //System.out.println(board_no);
	        List<CommentVO> commentvoList = service.getAllComments(board_no);
	        for (CommentVO commentvo : commentvoList) {
	        	// 답글 조회하기
	        	List<CommentVO> replyCommentsList = service.getRelplyComments(commentvo.getComment_no());
	        	commentvo.setReplyCommentsList(replyCommentsList);
	        	
	        	// 댓글에 대한 답글 수 구하기
	        	int replyCount = service.getReplyCount(commentvo.getComment_no());
	        	commentvo.setReplyCount(String.valueOf(replyCount));
	        	//System.out.println("replyCount : " + replyCount);
	        }
	        boardvo.setCommentvoList(commentvoList);
		}
		
		// 반응 조회하기
		List<ReactionVO> reactionvoList = service.getAllReaction(login_userid);
		
		// 피드별 반응 개수 조회하기
		List<Map<String, String>> reactionCountList = service.getReactionCount();
		
		/*
		for (Map<String, String> map : reactionCountList) {
			String reactionTargetNo = (String) map.get("reaction_target_no"); 
		    String reactionCount = (String) map.get("reaction_count"); 
		    System.out.println("reaction_target_no: " + reactionTargetNo + ", reaction_count: " + reactionCount);
		}
		*/
		
		
        
		mav.addObject("boardvoList", boardvoList);
		mav.addObject("membervo", membervo);
		mav.addObject("reactionvoList", reactionvoList);
		mav.addObject("reactionCountList", reactionCountList);
		//mav.addObject("commentvoList", commentvoList);
		
		mav.setViewName("feed/board");
		
		return mav;
	}
	
	
	// 글 작성
	@PostMapping("add")
	public ModelAndView add(@RequestParam String fk_member_id, @RequestParam String board_content, @RequestParam String board_visibility, @RequestParam(required = false) MultipartFile[] attach, ModelAndView mav, MultipartHttpServletRequest mrequest) {
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("fk_member_id", fk_member_id);
		paraMap.put("board_content", board_content);
		paraMap.put("board_visibility", board_visibility);
		
		try {
			
			if (attach != null) {	// 이미지 첨부했을 경우
				
				// WAS 절대경로 알아오기
				HttpSession session = mrequest.getSession();
				String root = session.getServletContext().getRealPath("/");
				String path =  root + "resources" + File.separator + "files" + File.separator + "board";  
				//System.out.println("path : " + path);
				//C:\git\Jobchae-SNS\jobchae\src\main\webapp\resources\files\board
				
				//System.out.println("attach.length : " + attach.length);

				int n = service.add(paraMap);
				String file_target_no = paraMap.get("board_no");	// 채번
				
				for (MultipartFile file : attach) {
					String file_name = "";		
					byte[] bytes = file.getBytes();
					long file_size = 0;
					
					String file_original_name = file.getOriginalFilename();
					file_name = fileManager.doFileUpload(bytes, file_original_name, path);	// 첨부파일 업로드
					file_size = file.getSize();
					
					//System.out.println("파일명 : " + file_name);
					
					Map<String, String> paraMap2 = new HashMap<>();
					paraMap2.put("file_target_no", file_target_no);
					paraMap2.put("file_name", file_name);
					paraMap2.put("file_original_name", file_original_name);
					paraMap2.put("file_size", String.valueOf(file_size));
					
					int n2 = service.addWithFile(paraMap2);
					
					if (n != 1 || n2 != 1) {
						mav.addObject("message", "업데이트 과정에서 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.");
						mav.addObject("loc", "javascript:history.back()");
						mav.setViewName("msg");
					}
				}
				
			} else {	// 첨부파일 아무것도 없을 경우
				int n = service.add(paraMap);	
				
				if (n != 1) {
					mav.addObject("message", "업데이트 과정에서 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.");
					mav.addObject("loc", "javascript:history.back()");
					mav.setViewName("msg");
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		mav.setViewName("redirect:/board/feed");	// feed 화면으로 새로고침

		//알림 전송 시작
		//현재 로그인된 사람
		//		MemberVO user001 = new MemberVO();
//		user001.setMember_id("user001");
		HttpSession session = mrequest.getSession();
		MemberVO member = (MemberVO) session.getAttribute("loginuser");



		//받는 사람

		List<FollowEntity> followerList = new ArrayList<>();
//		followerList.addAll(List.of("user001", "user003", "dltnstls89"));
		followerList = followService.getFollowers(member.getMember_id());


		//알림 데이터
		AlarmData alarmData = new AlarmData();
		alarmData.setBoardContent(board_content);
		List<AlarmVO> alarmList = new ArrayList<>();

		followerList.stream().forEach(follow -> {
			AlarmVO alarm = alarmService.insertAlarm(member, follow.getFollowerId(), AlarmVO.NotificationType.FOLLOWER_POST, alarmData);
			alarmList.add(alarm);

			simpMessagingTemplate.convertAndSendToUser(follow.getFollowerId(), "/topic/alarm", alarm);
		});


		//알림 전송 끝
		return mav;
	}
	
	
	// 글 수정
	@PostMapping("editBoardFile")
	public ModelAndView editBoardFile(@RequestParam String board_no, @RequestParam(required = false) MultipartFile[] attach, ModelAndView mav, MultipartHttpServletRequest mrequest) {
		
		try {
			
			if (attach != null && attach.length > 0) {	// 이미지 첨부했을 경우
				
				// WAS 절대경로 알아오기
				HttpSession session = mrequest.getSession();
				String root = session.getServletContext().getRealPath("/");
				String path =  root + "resources" + File.separator + "files" + File.separator + "board";  
				//System.out.println("path : " + path);
				//C:\git\Jobchae-SNS\jobchae\src\main\webapp\resources\files\board
				
				//System.out.println("attach.length : " + attach.length);
				
				for (MultipartFile file : attach) {
					String file_name = "";		
					byte[] bytes = file.getBytes();
					long file_size = 0;
					
					String file_original_name = file.getOriginalFilename();
					file_name = fileManager.doFileUpload(bytes, file_original_name, path);	// 첨부파일 업로드
					file_size = file.getSize();
					
					//System.out.println("파일명 : " + file.getOriginalFilename());
					
					Map<String, String> paraMap = new HashMap<>();
					paraMap.put("board_no", board_no);
					paraMap.put("file_name", file_name != null ? file_name : "");
					paraMap.put("file_original_name", file_original_name);
					paraMap.put("file_size", String.valueOf(file_size));
					
					int n = service.editBoardWithFiles(paraMap);
					
					if (n != 1) {
						mav.addObject("message", "업데이트 과정에서 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.");
						mav.addObject("loc", "javascript:history.back()");
						mav.setViewName("msg");
					}
				}
				
			}  
		} catch (Exception e) {
			e.printStackTrace();
		}

		mav.setViewName("redirect:/board/feed");
		return mav;
	}
	
	
	// 피드 하나만 띄우기
	@GetMapping("/feed/{board_no}")
	public ModelAndView boardOne(HttpServletRequest request, ModelAndView mav, @PathVariable String board_no) {
		
		BoardVO boardvo = service.boardOneSelect(board_no);
		
		if (boardvo == null) {
			mav.setViewName("redirect:/board/feed");
			return mav;
		}
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
//		MemberVO loginuser = new MemberVO(); // feat: 이준영, 기능 구현 중 오류발생하여 주석처리함
//		loginuser.setMember_id("user001");
//		session.setAttribute("loginuser", loginuser);
		String login_userid = loginuser.getMember_id();
		
		// 로그인된 사용자의 정보 얻어오기
		MemberVO membervo = service.getUserInfo(login_userid);
		
		String following_id = boardvo.getFk_member_id();
        int followerCount = service.getFollowerCount(following_id);
        boardvo.setCountFollow(String.valueOf(followerCount)); 
        
        int countComment = service.getCommentCount(board_no);
        boardvo.setCountComment(String.valueOf(countComment));
        
        // 첨부파일 조회하기
        List<FileVO> filevoList = service.getFiles(board_no);
        boardvo.setFileList(filevoList); 
        
        // 댓글 조회하기
        //System.out.println(board_no);
        List<CommentVO> commentvoList = service.getAllComments(board_no);
        for (CommentVO commentvo : commentvoList) {
        	// 답글 조회하기
        	List<CommentVO> replyCommentsList = service.getRelplyComments(commentvo.getComment_no());
        	commentvo.setReplyCommentsList(replyCommentsList);
        	
        	// 댓글에 대한 답글 수 구하기
        	int replyCount = service.getReplyCount(commentvo.getComment_no());
        	commentvo.setReplyCount(String.valueOf(replyCount));
        	//System.out.println("replyCount : " + replyCount);
        }
        boardvo.setCommentvoList(commentvoList);
        
        // 반응 많은 순 상위 1~3개 추출하기 시작
        Map<String, String> topReactionsList = service.getTopReactionsForBoard(board_no);
        
        // 예시로 첫 번째 상태인 1의 반응 개수를 출력
        //System.out.println(topReactionsList);
        
        
        List<Map.Entry<String, String>> entryList = new ArrayList<>(topReactionsList.entrySet());
        
        // 값 기준으로 내림차순 정렬 (String을 Integer로 변환하여 비교)
        entryList = entryList.stream()
        	    .filter(entry -> Integer.parseInt(entry.getValue()) != 0)  
        	    .sorted((entry1, entry2) -> Integer.compare(Integer.parseInt(entry2.getValue()), Integer.parseInt(entry1.getValue())))  
        	    .collect(Collectors.toList());
        
        // 상위 1~3개만 추출
        Map<String, String> topReactionList = entryList.stream()
            .limit(3)  
            .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue));

        boardvo.setTopReactionList(topReactionList);
        
        // 반응 조회하기
 		List<ReactionVO> reactionvoList = service.getAllReaction(login_userid);
 		
 		// 피드별 반응 개수 조회하기
 		List<Map<String, String>> reactionCountList = service.getReactionCount();
     		
		mav.addObject("membervo", membervo);
		mav.addObject("boardvo", boardvo);
		mav.addObject("reactionvoList", reactionvoList);
		mav.addObject("reactionCountList", reactionCountList);
		mav.setViewName("feed/boardOne");
		return mav;
	}
	


}
