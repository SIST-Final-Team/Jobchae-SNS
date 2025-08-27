package com.spring.app.config;

import com.github.benmanes.caffeine.cache.Caffeine;
import org.springframework.cache.CacheManager;
import org.springframework.cache.caffeine.CaffeineCacheManager;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.concurrent.TimeUnit;

@Configuration
public class CacheConfig {
    
    @Bean
    public CacheManager cacheManager() {
        CaffeineCacheManager cacheManager = new CaffeineCacheManager("chatRoomMemberIds"); // 캐시 이름 설정
        cacheManager.setCaffeine(Caffeine.newBuilder()
                // .expireAfterWrite(1, TimeUnit.HOURS) // 쓰기 후 1시간 뒤 만료
                .expireAfterAccess(1, TimeUnit.HOURS) // 또는, 접근 후 1시간 뒤 만료
                // .maximumSize(500) // 메모리에 보관할 최대 채팅방 수 (메모리 관리)
        );
        return cacheManager;
    }
    
    
}//end of class...
