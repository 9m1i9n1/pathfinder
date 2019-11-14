package com.douzone.bit.pathfinder.filter;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jboss.logging.Logger;
import org.jboss.logging.Logger.Level;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import com.douzone.bit.pathfinder.service.SignService;
import com.douzone.bit.pathfinder.util.JwtUtil;

@Component
public class JwtRequestFilter extends OncePerRequestFilter {
	
	Logger logger = Logger.getLogger(JwtRequestFilter.class);

	@Autowired
	private SignService signService;
	
	@Autowired
	private JwtUtil jwtUtil;
	
	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
			throws ServletException, IOException {
		
		final String authorizationHeader = request.getHeader("Authorization");
		
		String userId = null;
		String token = null;
		
		if (authorizationHeader != null && authorizationHeader.startsWith("pathfinder ")) {
			token = authorizationHeader.substring(11);
			userId = jwtUtil.extractUserId(token);
			
			if (userId != null && SecurityContextHolder.getContext().getAuthentication() == null) {
				UserDetails userDetails = this.signService.loadUserByUsername(userId);
				
				if (jwtUtil.validateToken(token, userDetails)) {
					UsernamePasswordAuthenticationToken usernamePasswordAuthenticationToken =
							new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
					
					usernamePasswordAuthenticationToken
						.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
					
					SecurityContextHolder.getContext().setAuthentication(usernamePasswordAuthenticationToken);
				}
			}
		}
		
		chain.doFilter(request, response);
	}
}
