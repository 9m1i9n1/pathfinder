package com.douzone.bit.pathfinder.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.douzone.bit.pathfinder.model.entity.UserTb;
import com.douzone.bit.pathfinder.repository.UserRepository;

@Service
public class SignService implements UserDetailsService  {

	@Autowired
	private UserRepository userRepository;

	@Override
	public UserDetails loadUserByUsername(String userId) throws UsernameNotFoundException {
		UserTb user = userRepository.findByUserId(userId);
		
		String auth = "";
		
		auth = (user.getUserAuth()) ? "ADMIN" : "USER";

		return new User(user.getUserId(), user.getUserPw(),
				AuthorityUtils.createAuthorityList(auth));
	}

//	public Header<SignResponse> login(String userId, String userPwd) {
//		UserTb user = userRepository.findByUserId(userId);
//		
//		SignResponse signResponse = response(user);
//		
//		return Header.OK(signResponse);
//	}
	
//	private SignResponse response(UserTb user) {
//		SignResponse signResponse = SignResponse.builder()
//				.userIndex(user.getUserIndex()).userId(user.getUserId())
//				.userName(user.getUserName())
//				.userPosition(user.getUserPosition())
//				.userEmail(user.getUserEmail()).userPhone(user.getUserPhone())
//				.userAuth(user.getUserAuth())
//				.build();
//		
//		return signResponse;
//	}
}