package com.multi.crowd;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;
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
@ComponentScan
public class MultiforceApplication implements CommandLineRunner{

	public static void main(String[] args) {
		SpringApplication.run(MultiforceApplication.class, args);
		
	}
	@Autowired 
	ApplicationContext factory;
	
	
	@Override
	public void run(String... args) throws Exception {
		System.out.println("===bean 출력 시작===");
		
		for(String bean : factory.getBeanDefinitionNames()) {
			System.out.println(bean);
		}
		System.out.println("===bean 출력 종료===");
		
	}

}
