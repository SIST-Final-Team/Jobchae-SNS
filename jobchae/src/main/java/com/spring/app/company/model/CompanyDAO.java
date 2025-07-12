package com.spring.app.company.model;

import com.spring.app.company.domain.CompanyVO;
import com.spring.app.member.domain.MemberVO;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CompanyDAO extends JpaRepository<CompanyVO, Long> {

//    List<CompanyVO> member(MemberVO member);

    List<CompanyVO> findByFkMemberId(String fkMemberId);
}
