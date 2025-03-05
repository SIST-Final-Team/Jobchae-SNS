package com.spring.app.company.model;

import com.spring.app.company.domain.IndustryVO;
import jakarta.validation.constraints.NotBlank;
import org.springframework.data.domain.Limit;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface IndustryDAO extends JpaRepository<IndustryVO, Long> {

    Optional<IndustryVO> findByIndustryName(@NotBlank String industryNameString);

    List<IndustryVO> findByIndustryNameContaining(String industryName);

}
