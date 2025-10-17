package com.spring.app.config;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import java.util.List;

@Setter
@Getter
@ConfigurationProperties(prefix = "cors") // yml 파일의 'cors' 프리픽스 아래 값을 매핑
public class CorsProperties {

    // 'allowed-origins' 속성을 List<String> 타입으로 받는다.
    private List<String> allowedOrigins;

}