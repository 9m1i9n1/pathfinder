package com.douzone.bit.pathfinder.util;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.function.Function;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

@Service
public class JwtUtil {

	// token 앞에 붙일 키
	private String SECRET_KEY = "pathfinder";

	public String extractUserId(String token) {
		return extractClaim(token, Claims::getSubject);
	}

	public Date extractExpiration(String token) {
		return extractClaim(token, Claims::getExpiration);
	}

	public <T> T extractClaim(String token, Function<Claims, T> claimsResolver) {
		final Claims claims = extractAllClaims(token);

		return claimsResolver.apply(claims);
	}

	private Claims extractAllClaims(String token) {
		return Jwts.parser().setSigningKey(SECRET_KEY).parseClaimsJws(token).getBody();
	}

	private Boolean isTokenExpired(String token) {
		return extractExpiration(token).before(new Date());
	}

	// User정보랑 관련된 객체를 먼저 생성.
	// JWT 기본바탕 생성.
	public String generateToken(UserDetails userDetails) {
		Map<String, Object> claims = new HashMap<>();
		
		return createToken(claims, userDetails.getUsername());
	}
	
	// subject 는 로그인 하는 대상이 들어감.
	// setIssuedAt는 최근데 생성된 토큰 시간.
	// setExpiration은 토큰 만료시간.
	// signWith는 암호화 알고리즘 선택.
	private String createToken(Map<String, Object> claims, String subject) {
		return Jwts.builder()
				.setClaims(claims)
				.setSubject(subject)
				.setIssuedAt(new Date(System.currentTimeMillis()))
				.setExpiration(new Date(System.currentTimeMillis() + 1000 * 60 * 60 * 10))
				.signWith(SignatureAlgorithm.HS256, SECRET_KEY)
				.compact();
	}

	public Boolean validateToken(String token, UserDetails userDetails) {
		final String userName = extractUserId(token);
		return (userName.equals(userDetails.getUsername())) && !isTokenExpired(token);
	}
}
