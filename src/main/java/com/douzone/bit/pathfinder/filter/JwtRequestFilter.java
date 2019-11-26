package com.douzone.bit.pathfinder.filter;

import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
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
	private SignService signService;
	
	@Autowired
	private JwtUtil jwtUtil;

	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
			throws ServletException, IOException {

		final String authorizationHeader = request.getHeader("Authorization");

		String token = null;
		
		String requestUrl = request.getRequestURI();

		if (!requestUrl.matches("^/static/.*$")) {
			System.out.println(requestUrl);
			if (authorizationHeader != null && authorizationHeader.startsWith("pathfinder ")) {
				token = authorizationHeader.substring(11);

				checkToken(token, request);
			} else {
				Cookie[] cookie = request.getCookies();

				if (cookie != null) {
					for (Cookie value : cookie) {
						if (value.getName().equals("token")) {
							token = value.getValue();

							checkToken(token, request);
							break;
						}
					}
				} else {
					// Exception 추가
				}
			}
		}

		chain.doFilter(request, response);
	}

	private void checkToken(String token, HttpServletRequest request) {
		String userId = null;
		userId = jwtUtil.extractUserId(token);

		if (userId != null && SecurityContextHolder.getContext().getAuthentication() == null) {
			Claims userClaim = jwtUtil.extractAllClaims(token);

			List<GrantedAuthority> authorities = new ArrayList<>();
			authorities.add(new SimpleGrantedAuthority(userClaim.get("userAuthority").toString()));

			SignDTO signInfo = (SignDTO) this.signService.loadUserByUsername(userId);

			if (jwtUtil.validateToken(token, signInfo)) {
				UsernamePasswordAuthenticationToken usernamePasswordAuthenticationToken = new UsernamePasswordAuthenticationToken(
						signInfo, null, signInfo.getAuthorities());

				usernamePasswordAuthenticationToken
						.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));

				SecurityContextHolder.getContext().setAuthentication(usernamePasswordAuthenticationToken);
			}
		}
	}
}
