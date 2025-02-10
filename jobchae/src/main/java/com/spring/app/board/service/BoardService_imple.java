package com.spring.app.board.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.board.model.BoardDAO;

@Service
public class BoardService_imple implements BoardService {

	@Autowired
	BoardDAO dao;
	
}
