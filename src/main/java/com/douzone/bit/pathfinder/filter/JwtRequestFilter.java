package com.douzone.bit.pathfinder.filter;

import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jboss.logging.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import com.douzone.bit.pathfinder.model.dto.SignDTO;
import com.douzone.bit.pathfinder.service.SignService;
import com.douzone.bit.pathfinder.util.JwtUtil;

import io.jsonwebtoken.Claims;

@Component
public class JwtRequestFilter extends OncePerRequestFilter {
	
	Logger logger = Logger.getLogger(JwtRequestFilter.class);

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
				Claims userClaim = jwtUtil.extractAllClaims(token);
				
				List<GrantedAuthority> authorities = new ArrayList<>();
				authorities.add(new SimpleGrantedAuthority(userClaim.get("userAuthority").toString()));
				
				logger.info(Long.valueOf(userClaim.get("userIndex").toString()));
				
				SignDTO signInfo = SignDTO.builder()
						.username(userId)
						.password(null)
						.userIndex(Long.valueOf(userClaim.get("userIndex").toString()))
						.userFullName(userClaim.get("userFullName").toString())
						.userEmail(userClaim.get("userEmail").toString())
						.userPhone(userClaim.get("userPhone").toString())
						.userPosition(userClaim.get("userPosition").toString())
						.userBranch(userClaim.get("userBranch").toString())
						.userArea(userClaim.get("userArea").toString())
						.authorities(authorities)
						.accountNonExpired(true).accountNonLocked(true)
						.credentialsNonExpired(true).enabled(true)
						.build();
				
				if (jwtUtil.validateToken(token, signInfo)) {
					
					UsernamePasswordAuthenticationToken usernamePasswordAuthenticationToken =
							new UsernamePasswordAuthenticationToken(signInfo, null, signInfo.getAuthorities());
					
					usernamePasswordAuthenticationToken
						.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
				
					SecurityContextHolder.getContext().setAuthentication(usernamePasswordAuthenticationToken);
				}
			}
		}
		
		chain.doFilter(request, response);
	}
}
