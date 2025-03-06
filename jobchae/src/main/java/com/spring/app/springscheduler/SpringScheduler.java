package com.spring.app.springscheduler;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.spring.app.member.service.MemberService;

@Component
public class SpringScheduler {

	@Autowired
	MemberService service;
	
	
	
	// 회원 휴면을 자동으로 지정해주는 스케줄러
	@Scheduled(cron = "0 0 4 *  * *")
	public void scheduler_update_idle() {
		// 스캐줄러가 업데이트 해준다.
		service.deactivateMember_idle();
	}// end of public void scheduler_update_idle() {}...
	
	
	
	// 회원 탈퇴 시 한달 뒤에 자동으로 계정 삭제하는 스케줄러
	@Scheduled(cron = "0 0 4 *  * *")
	public void scheduler_update_status() {
		service.memberDelete();
	}//end of public void scheduler_update_status() {
	
	
	
	
	
	
	
	
	
}//end of class...
