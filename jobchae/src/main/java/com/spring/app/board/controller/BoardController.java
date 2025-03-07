package com.spring.app.board.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
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
	
	// 피드 조회하기
	@GetMapping("feed")
	public ModelAndView feed(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, @RequestParam(required = false) String sort) {
		
		// 임시로 세션값 저장해주기. 시작
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
//		MemberVO loginuser = new MemberVO(); // feat: 이준영, 기능 구현 중 오류발생하여 주석처리함
//		loginuser.setMember_id("user001");
//		session.setAttribute("loginuser", loginuser);
		String login_userid = loginuser.getMember_id();
		// 임시로 세션값 저장해주기. 끝
		
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
	        
	        // 반응 많은 순 상위 1~3개 추출하기
	        //List<String> reactionCounts = service.getReactionCountsByBoard(board_no);
	        //System.out.println("board_no Reaction Counts: " + reactionCounts);
	        
	        // 댓글 수 구하기
	        int countComment = service.getCommentCount(board_no);
	        boardvo.setCountComment(String.valueOf(countComment));
	        //System.out.println("countComment : " + countComment);
		}
		
		// 반응 조회하기
		List<ReactionVO> reactionvoList = service.getAllReaction(login_userid);
		
		// 피드별 반응 개수 조회하기
		List<Map<String, String>> reactionCountList = service.getReactionCount();
		
		//for (Map<String, String> map : reactionCountList) {
		    //String reactionTargetNo = (String) map.get("reaction_target_no"); 
		    //String reactionCount = (String) map.get("reaction_count"); 
		    //System.out.println("reaction_target_no: " + reactionTargetNo + ", reaction_count: " + reactionCount);
		//}
		
		// 댓글 조회하기
        List<CommentVO> commentvoList = service.getAllComments();
		
		mav.addObject("boardvoList", boardvoList);
		mav.addObject("membervo", membervo);
		mav.addObject("reactionvoList", reactionvoList);
		mav.addObject("reactionCountList", reactionCountList);
		mav.addObject("commentvoList", commentvoList);
		
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
				//C:\git\Jobchae-SNS\jobchae\src\main\webapp\resources\files
				
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
					
					System.out.println("파일명 : " + file_name);
					
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
		return mav;
	}
	
	
	// 글 수정
	@PostMapping("editBoard")
	public ModelAndView editBoard(@RequestParam String board_no, @RequestParam String fk_member_id, @RequestParam String board_content, @RequestParam String board_visibility, ModelAndView mav) {
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("board_no", board_no);
		paraMap.put("fk_member_id", fk_member_id);
		paraMap.put("board_content", board_content);
		paraMap.put("board_visibility", board_visibility);
		
		int n = service.editBoard(paraMap);
		
		if (n != 1) {
			mav.addObject("message", "수정 과정에서 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.");
			mav.addObject("loc", "javascript:history.back()");
			mav.setViewName("msg");
		}
		
		mav.setViewName("redirect:/board/feed");
		return mav;
	}



}
