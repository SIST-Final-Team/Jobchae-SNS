package com.spring.app.company.model;

import com.spring.app.company.domain.CompanyVO;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CompanyDAO extends JpaRepository<CompanyVO, Long> {

}
