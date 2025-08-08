package com.spring.app.chatting.domain;

import java.time.LocalDateTime;
import java.util.Objects;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PartiMember {

	private String member_id; // 사용자 아이디
	
	private String member_name; // 사용자 이름

	private LocalDateTime start_date; // 첫 접속 시간

	// PartiMember 생성 정적 팩토리 메소드
	public static PartiMember createPartiMember(String member_id, String member_name) {
		return PartiMember.builder()
				.member_id(member_id)
				.member_name(member_name)
				.start_date(LocalDateTime.now())
				.build();
	}

	// @Override
	// public boolean equals(Object obj) {
	// 	if(this == obj) {
	// 		return true;
	// 	} // 현재 객체와 주소값이 동일한 객체인지 확인
	// 	if(obj == null || getClass() != obj.getClass()) {
	// 		return false;
	// 	} // 현재 클래스와 다른 클래스인지 확인
	//
	// 	PartiMember partiMember = (PartiMember) obj;
	// 	return Objects.equals(member_id, partiMember.member_id); // 회원 번호를 기준으로 비교
	// }
    //
	// @Override
	// public int hashCode() {
	// 	// eqauls 비교 구문에는 hashCode를 기준으로 비교하기에 회원번호를 기준으로 해시값 생성
	// 	return Objects.hash(member_id);
	// }
	
}