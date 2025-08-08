package com.spring.app.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.mongodb.MongoDatabaseFactory;
import org.springframework.data.mongodb.MongoTransactionManager;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.SimpleMongoClientDatabaseFactory;
import org.springframework.transaction.annotation.EnableTransactionManagement;


@Configuration  // Spring 컨테이너가 처리해주는 클래스로서, 클래스내에 하나 이상의 @Bean 메소드를 선언만 해주면 런타임시 해당 빈에 대해 정의되어진 대로 요청을 처리해준다.
@EnableTransactionManagement // Spring Framework에서 선언적 트랜잭션 관리 기능을 활성화하는 데 사용되는 애노테이션입니다.
public class MongoDB_Config {

	@Value("${spring.data.mongodb.uri}")
    private String uri;

    @Bean
    public MongoDatabaseFactory mongoDatabaseFactory() {
        return new SimpleMongoClientDatabaseFactory(uri);
    }

    @Bean
    public MongoTemplate mongoTemplate() {
        return new MongoTemplate(mongoDatabaseFactory());
    }
    
    @Bean
    public MongoTransactionManager transactionManager(MongoDatabaseFactory dbFactory) {
        return new MongoTransactionManager(dbFactory);
    }
    
}
