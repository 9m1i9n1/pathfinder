package com.douzone.bit.pathfinder.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.douzone.bit.pathfinder.model.entity.UserTb;
import com.douzone.bit.pathfinder.model.network.Header;
import com.douzone.bit.pathfinder.model.network.request.SignRequest;
import com.douzone.bit.pathfinder.model.network.response.SignResponse;
import com.douzone.bit.pathfinder.service.SignService;
import com.douzone.bit.pathfinder.util.JwtUtil;

@RestController
@RequestMapping("/")
public class SignController {

	@Autowired
	private AuthenticationManager authenticationManager;
	
	@Autowired
	private JwtUtil jwtTokenUtil;
	
	@Autowired
	private SignService signService;
	
	@GetMapping({ "", "/", "/login" })
	public ModelAndView loginPage() {

		ModelAndView mv = new ModelAndView();

		mv.setViewName("/pages/login");
		
		return mv;
	}
	
	@PostMapping("/authenticate.do")
	public ModelAndView createAuthenticationToken(
			SignRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mv = new ModelAndView();

		try {
			authenticationManager.authenticate(
					new UsernamePasswordAuthenticationToken(
							request.getId(), request.getPwd()));
			
		} catch (BadCredentialsException e) {
			throw new Exception("Incorrect userId or password", e);
		}
		UserDetails userDetails = signService
				.loadUserByUsername(request.getId());
		
		String token = jwtTokenUtil.generateToken(userDetails);
		
		Cookie cookie = new Cookie("token", token);
		
		cookie.setMaxAge(7 * 24 * 60 * 60); // 7일
		
		response.addCookie(cookie);
		
		mv.setViewName("/hierarchy");
		
		return mv;
	}

}