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
		
		// 피드 조회하기 (본인이 작성한 글)
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
	
}
