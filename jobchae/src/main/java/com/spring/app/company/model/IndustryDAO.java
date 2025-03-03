package com.spring.app.company.model;

import com.spring.app.company.domain.IndustryVO;
import org.springframework.data.jpa.repository.JpaRepository;

public interface IndustryDAO extends JpaRepository<IndustryVO, Long> {
}
