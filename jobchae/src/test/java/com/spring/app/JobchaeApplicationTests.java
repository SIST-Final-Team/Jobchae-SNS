package com.spring.app;


import org.junit.jupiter.api.ClassOrderer.OrderAnnotation;
import org.junit.jupiter.api.TestClassOrder;
import org.junit.jupiter.api.TestInstance;
import org.springframework.boot.test.context.SpringBootTest;


@SpringBootTest
@TestClassOrder(OrderAnnotation.class)
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
class JobchaeApplicationTests {


}
