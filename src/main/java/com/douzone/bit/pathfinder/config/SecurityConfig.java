package com.douzone.bit.pathfinder.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.password.NoOpPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.firewall.HttpFirewall;
import org.springframework.security.web.firewall.StrictHttpFirewall;

import com.douzone.bit.pathfinder.filter.JwtRequestFilter;
import com.douzone.bit.pathfinder.service.SignService;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

	@Autowired
	SignService signService;

	@Autowired
	private JwtRequestFilter jwtRequestFilter;

	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {

		auth.userDetailsService(signService);

		super.configure(auth);
	}

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.addFilterBefore(jwtRequestFilter, UsernamePasswordAuthenticationFilter.class).csrf().disable() // CSRF 보안 비설정
				.authorizeRequests().antMatchers("/admin/**").access("hasRole('ADMIN')")
				.antMatchers("/authenticate.do", "/login").permitAll() // 로그인은 누구나 접속할 수 았게 설정
				.anyRequest().authenticated().and().sessionManagement() // JWT 토큰 방식을 이용하기 때문에 Session은 이용하지 않음.
				.sessionCreationPolicy(SessionCreationPolicy.STATELESS).and().formLogin() // Login 화면 설정.
				.loginPage("/login").permitAll().failureUrl("/login").and().logout().permitAll();
	}

	@Override
	public void configure(WebSecurity web) {
		web.httpFirewall(allowUrlEncoddedSlashHttpFirewall());
		web.ignoring().antMatchers("/static/**");
	}

	@Override
	@Bean
	public AuthenticationManager authenticationManagerBean() throws Exception {
		return super.authenticationManagerBean();
	}

	@SuppressWarnings("deprecation")
	@Bean
	public PasswordEncoder passwordEncoder() {
		return NoOpPasswordEncoder.getInstance();
	}

	@Bean
	public HttpFirewall allowUrlEncoddedSlashHttpFirewall() {
		StrictHttpFirewall firewall = new StrictHttpFirewall();
		firewall.setAllowSemicolon(true);

		return firewall;
	}
}
