package com.spring.app.board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.board.domain.BoardVO;
import com.spring.app.board.service.BoardService;
import com.spring.app.member.domain.MemberVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping(value="/board/*")
public class BoardController {

	@Autowired
	BoardService service;
	
	// 피드 조회하기
	@GetMapping("feed")
	public ModelAndView feed(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		// 임시로 세션값 저장해주기. 시작
		HttpSession session = request.getSession();
		MemberVO loginuser = new MemberVO();
		loginuser.setMember_id("user001");
		session.setAttribute("loginuser", loginuser);
		String login_userid = loginuser.getMember_id();
		// 임시로 세션값 저장해주기. 끝
		
		// 로그인된 사용자의 정보 얻어오기
		MemberVO membervo = service.getUserInfo(login_userid);
		
		// 피드 조회하기
		List<BoardVO> boardvo = service.getAllBoards(login_userid);
		
		mav.addObject("boardvo", boardvo);
		mav.addObject("membervo", membervo);
		mav.setViewName("feed/board");
		
		return mav;
	}
	
	
	// 파일첨부가 없는 글쓰기
	@PostMapping("add")
	public ModelAndView add(@RequestParam String fk_member_id, @RequestParam String board_content, @RequestParam String board_visibility, ModelAndView mav) {
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("fk_member_id", fk_member_id);
		paraMap.put("board_content", board_content);
		paraMap.put("board_visibility", board_visibility);
		
		int n = service.add(paraMap);
		//System.out.println("n ~~~~~" + n);
		
		mav.setViewName("redirect:/board/feed");	// feed 화면으로 새로고침
		return mav;
	}
	
	
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
		
		if (n != 1) {
			mav.addObject("message", "삭제 과정에서 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.");
			mav.addObject("loc", "javascript:history.back()");
			mav.setViewName("msg");
		}
		
		Map<String, Integer> map = new HashMap<>();
		map.put("n", n);
		
		return map; 
	}
	
	// 글 수정
	@PostMapping("editSearch")
	public ModelAndView editSearch(@RequestParam String board_no, ModelAndView mav) {
		
		BoardVO boardvo = service.editSearch(board_no);
		
		System.out.println("dd" + boardvo.getBoard_content());
		mav.addObject("board_content", boardvo.getBoard_content());
		
		mav.setViewName("redirect:/board/feed");
		return mav;
	}
	
	// 게시물 반응
	@PostMapping("reactionBoard")
	public ModelAndView reactionBoard(HttpServletRequest request, @RequestParam String reaction_target_no, @RequestParam String reaction_status, ModelAndView mav) {

		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String fk_member_id = loginuser.getMember_id();

		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("fk_member_id", fk_member_id);
		paraMap.put("reaction_target_no", reaction_target_no);
		paraMap.put("reaction_status", reaction_status);

		int n = service.reactionBoard(paraMap);

		mav.setViewName("redirect:/board/feed");
		return mav;
	}

}
