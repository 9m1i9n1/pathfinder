package com.douzone.bit.pathfinder;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication
public class PathfinderApplication extends SpringBootServletInitializer {
	
	public static final String APPICATION_LOCATIONS = "spring.config.location="
			+ "classpath:application.properties,"
			+ "classpath:aws.properties";
	
	public static void main(String[] args) {
		
		new SpringApplicationBuilder(PathfinderApplication.class)
			.properties(APPICATION_LOCATIONS)
			.run(args);
//		SpringApplication.run(PathfinderApplication.class, args);
	}

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		return application.sources(PathfinderApplication.class);
	}

}
