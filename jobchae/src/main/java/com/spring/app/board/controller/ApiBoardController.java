package com.spring.app.board.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.board.service.BoardService;
import com.spring.app.member.domain.MemberVO;
import com.spring.app.reaction.domain.ReactionVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping(value="/api/board/*")
public class ApiBoardController {

	@Autowired
	BoardService service;
	
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
}
