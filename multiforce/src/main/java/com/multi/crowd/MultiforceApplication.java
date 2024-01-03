package com.multi.crowd;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;
@ComponentScan(basePackages="board")
@ComponentScan(basePackages="funding")
@ComponentScan(basePackages="member")
@ComponentScan(basePackages="project")
@MapperScan(basePackages="board")
@MapperScan(basePackages="funding")
@MapperScan(basePackages="member")
@MapperScan(basePackages="project")
@SpringBootApplication
public class MultiforceApplication {

	public static void main(String[] args) {
		SpringApplication.run(MultiforceApplication.class, args);
	}

}
