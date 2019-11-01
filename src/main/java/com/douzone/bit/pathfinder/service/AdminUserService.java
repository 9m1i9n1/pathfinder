package com.douzone.bit.pathfinder.service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import com.douzone.bit.pathfinder.model.entity.UserTb;
import com.douzone.bit.pathfinder.model.network.request.AdminUserRequest;
import com.douzone.bit.pathfinder.model.network.response.AdminUserResponse;
import com.douzone.bit.pathfinder.repository.BranchRepository;
import com.douzone.bit.pathfinder.repository.UserRepository;

@Service
public class AdminUserService {

  @Autowired
  private UserRepository userRepository;

  @Autowired
  private BranchRepository branchRepository;

  public AdminUserResponse create(AdminUserRequest request) {

    UserTb user = UserTb.builder().userId(request.getUserId()).userPw("12345").userName(request.getUserName())
        .userEmail(request.getUserEmail()).userPhone(request.getUserPhone()).userCreated(LocalDateTime.now())
        .userAuth(request.getUserAuth()).userPosition(request.getUserPosition())
        .branch(branchRepository.getOne(request.getBranchIndex())).build();

    userRepository.save(user);

    return response(user);
  }

  public Optional<UserTb> read(Long id) {

    return userRepository.findById(id);
  }

  public List<Object> readBranchName() {

    return branchRepository.findBranchName();
  }

  public List<AdminUserResponse> search(Pageable pageable) {

    Page<UserTb> users = userRepository.findAll(pageable);

    List<AdminUserResponse> userResponseList = users.stream().map(user -> response(user)).collect(Collectors.toList());

    return userResponseList;
  }

  public Optional<AdminUserResponse> update(Long id) {
    Optional<UserTb> optional = userRepository.findById(id);

    return optional.map(user -> {
      user.setUserPw("12345");
      return user;
    }).map(updatedUser -> userRepository.save(updatedUser)).map(updatedUser -> response(updatedUser));
  }

  public int delete(Long id) {
    Optional<UserTb> optional = userRepository.findById(id);

    return optional.map(user -> {
      userRepository.delete(user);
      return 1;
    }).orElseGet(() -> 0);
  }

  private AdminUserResponse response(UserTb user) {

    AdminUserResponse adminUserResponse = AdminUserResponse.builder().userIndex(user.getUserIndex())
        .userId(user.getUserId()).userName(user.getUserName()).userEmail(user.getUserEmail())
        .userPhone(user.getUserPhone()).branchName(user.getBranch().getBranchName())
        .userPosition(user.getUserPosition()).build();

    return adminUserResponse;
  }
}