package com.spring.app.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration // Spring 컨테이너가 처리해주는 클래스로서, 클래스내에 하나 이상의 @Bean 메소드를 선언만 해주면 런타임시 해당 빈에 대해 정의되어진 대로 요청을 처리해준다.
public class Interceptor_Configuration implements WebMvcConfigurer {

//  @Override
//  public void addInterceptors(InterceptorRegistry registry) {
//      registry.addInterceptor(loginCheckInterceptor)
//              .addPathPatterns("/**/*") // 해당 경로에 접근하기 전에 인터셉터가 가로챈다.
//              .excludePathPatterns("/", "/index", "/member/login", "/member/loginEnd", "/board/list", "/board/view", "/interceptor/anyone/**", "/interceptor/special_member/**"); // 해당 경로는 인터셉터가 가로채지 않는다.

//      //   addInterceptor() : 인터셉터를 등록해준다.
//      //   addPathPatterns() : 인터셉터를 호출하는 주소와 경로를 추가한다.
//      //   excludePathPatterns() : 인터셉터 호출에서 제외하는 주소와 경로를 추가한다.
//  }
}
