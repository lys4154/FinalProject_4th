package config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration //servlet-context.xml파일 대신 현재 클래스가 설정을 대신할것
public class ImagePathConfig implements WebMvcConfigurer{

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/noticesimages/**")
		.addResourceLocations("file:///c:/fullstack/workspace_springboot/images/notices/");
		//addResourceHandler(url).addResourceLocations(실제 파일 경로)
		///upload/파일명
		
		
        // memberimages 핸들러 등록
        registry.addResourceHandler("/memberimages/**")
                .addResourceLocations("file:///c:/fullstack/workspace_springboot/images/members/");
	
	}
	
}
