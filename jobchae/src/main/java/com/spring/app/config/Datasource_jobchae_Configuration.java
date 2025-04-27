package com.spring.app.config;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@Configuration  // Spring 컨테이너가 처리해주는 클래스로서, 클래스내에 하나 이상의 @Bean 메소드를 선언만 해주면 런타임시 해당 빈에 대해 정의되어진 대로 요청을 처리해준다.
@EnableTransactionManagement // 스프링 부트에서 Transaction 처리를 위한 용도
@MapperScan(basePackages={"com.spring.app.member.model", "com.spring.app.board.model", "com.spring.app.search.model", "com.spring.app.recruit.model"}, sqlSessionFactoryRef="sqlSessionFactory") // Mapper Interface 를 사용하기 위한 설정
public class Datasource_jobchae_Configuration {

	@Value("${mybatis.mapper-locations}")  // *.yml 파일에 있는 설정값을 가지고 온 것으로서 mapper 파일의 위치를 알려주는 것
    private String mapperLocations;

	@Bean
 	@Qualifier("dataSource")
    @ConfigurationProperties(prefix = "spring.datasource-jobchae")
    public DataSource dataSource(){
        return DataSourceBuilder.create().build();
    }
   /*
     @ConfigurationProperties은 *.properties , *.yml 파일에 있는 property를 자바 클래스에 값을 가져와서 사용할 수 있게 해주는 어노테이션이다.

     @ConfigurationProperties를 사용하기 위해서는
     pom.xml 에서 아래와 같이 spring-boot-configuration-processor 를 추가해주어야 한다.
     spring-boot-configuration-processor는 pom.xml에서 다음과 같이 추가한다.

	 <dependency>
	    <groupId>org.springframework.boot</groupId>
	    <artifactId>spring-boot-configuration-processor</artifactId>
	 </dependency>
   */


    @Bean
    @Qualifier("sqlSessionFactory")
    @Primary
    public SqlSessionFactory sqlSessionFactory(@Qualifier("dataSource") DataSource dataSource, ApplicationContext applicationContext) throws Exception{
        SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
        sqlSessionFactoryBean.setDataSource(dataSource);
        sqlSessionFactoryBean.setConfigLocation(applicationContext.getResource("classpath:mybatis/mybatis-config.xml"));
        sqlSessionFactoryBean.setMapperLocations(new PathMatchingResourcePatternResolver().getResources(mapperLocations));

        return sqlSessionFactoryBean.getObject();

    }

    @Bean
    @Qualifier("sqlsession")
    @Primary
    public SqlSessionTemplate sqlSessionTemplate(@Qualifier("sqlSessionFactory") SqlSessionFactory sqlSessionFactory) {
        return new SqlSessionTemplate(sqlSessionFactory);
    }
    /*
       @Primary 는 처음 스프링 구동 시 기본으로 사용할 Bean을 설정하는 것이다.

       @Autowired
       private SqlSessionTemplate abc;
       -- 위처럼 별도 Bean 설정없이 @Autowired로 연결한 경우, abc 에는 @Primary로 설정한 SqlSessionTemplate 빈이 주입된다.

       @Autowired
	   @Qualifier("sqlsession")
       private SqlSessionTemplate abc;
       -- 위처럼 @Qualifier("sqlsession")을 해주면 빈 이름이 sqlsession 인 SqlSessionTemplate 객체가 abc 에 주입된다.
    */

    @Bean(name = "transactionManager_jobchae")
    public PlatformTransactionManager transactionManager_jobchae() {
        DataSourceTransactionManager tm = new DataSourceTransactionManager();
        tm.setDataSource(dataSource());
        return tm;
    }

    @Bean(name = "transactionManager")
    @Primary
    public PlatformTransactionManager transactionManager() {
        return transactionManager_jobchae();
    }

}
