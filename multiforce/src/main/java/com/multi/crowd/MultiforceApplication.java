package com.multi.crowd;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.scheduling.annotation.EnableScheduling;
@ComponentScan(basePackages="board")
@ComponentScan(basePackages="funding")
@ComponentScan(basePackages="member")
@ComponentScan(basePackages="project")
@ComponentScan(basePackages="admin")
@ComponentScan(basePackages="config")
@ComponentScan(basePackages="summernote")
@ComponentScan(basePackages="approvalRequest")
@ComponentScan(basePackages="notification")
@MapperScan(basePackages="board")
@MapperScan(basePackages="funding")
@MapperScan(basePackages="member")
@MapperScan(basePackages="project")
@MapperScan(basePackages="admin")
@MapperScan(basePackages="approvalRequest")
@MapperScan(basePackages="notification")
@EnableScheduling
@SpringBootApplication
@ComponentScan
public class MultiforceApplication{

	public static void main(String[] args) {
		SpringApplication.run(MultiforceApplication.class, args);
		
	}

}
