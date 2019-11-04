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
import com.douzone.bit.pathfinder.model.network.Header;
import com.douzone.bit.pathfinder.model.network.Pagination;
import com.douzone.bit.pathfinder.model.network.request.AdminUserRequest;
import com.douzone.bit.pathfinder.model.network.response.AdminUserResponse;
import com.douzone.bit.pathfinder.repository.AreaRepository;
import com.douzone.bit.pathfinder.repository.BranchRepository;
import com.douzone.bit.pathfinder.repository.UserRepository;

@Service
public class AdminUserService {

  @Autowired
  private UserRepository userRepository;

  @Autowired
  private BranchRepository branchRepository;

  @Autowired
  private AreaRepository areaRepository;

  // 유저 등록 서비스
  public Header<AdminUserResponse> create(AdminUserRequest request) {

    UserTb user = UserTb.builder().userId(request.getUserId()).userPw("12345").userName(request.getUserName())
        .userEmail(request.getUserEmail()).userPhone(request.getUserPhone()).userCreated(LocalDateTime.now())
        .userAuth(request.getUserAuth()).userPosition(request.getUserPosition())
        .branch(branchRepository.getOne(request.getBranchIndex())).build();

    UserTb newUser = userRepository.save(user);

    return Header.OK(response(newUser));
  }

  // 지점 이름 불러오기
  // TODO 지점 service 쪽으로 뺴야함.
  public Header<List<Object>> readBranchName(Long id) {

    // 이부분 나중에 수정 요망
    return Header.OK(branchRepository.findValueByArea((areaRepository.getOne(id))));
  }

  // 지점 이름 불러오기
  // TODO 지역 service 쪽으로 뺴야함.
  public Header<List<Object>> readAreaName() {

    return Header.OK(areaRepository.findAreaName());
  }

  // 유저 리스트
  public Header<List<AdminUserResponse>> list(Pageable pageable) {

    Page<UserTb> users = userRepository.findAll(pageable);

    List<AdminUserResponse> userResponseList = users.stream().map(user -> response(user)).collect(Collectors.toList());

    Pagination pagination = Pagination.builder().totalPages(users.getTotalPages())
        .totalElements(users.getTotalElements()).currentPage(users.getNumber())
        .currentElements(users.getNumberOfElements()).build();

    return Header.OK(userResponseList, pagination);
  }

  public Header<List<AdminUserResponse>> search(Pageable pageable) {

    return null;
  }

  // 유저 비밀번호 초기화
  public Header<AdminUserResponse> update(Long id) {

    Optional<UserTb> optional = userRepository.findById(id);

    return optional.map(user -> {
      user.setUserPw("12345");
      return user;
    }).map(updatedUser -> userRepository.save(updatedUser)).map(updatedUser -> response(updatedUser)).map(Header::OK)
        .orElseGet(() -> Header.ERROR("데이터 없음"));
  }

  // 유저 삭제
  public Header delete(Long id) {

    Optional<UserTb> optional = userRepository.findById(id);

    return optional.map(user -> {
      userRepository.delete(user);
      return Header.OK();
    }).orElseGet(() -> Header.ERROR("데이터 없음"));
  }

  // Response 데이터 파싱
  private AdminUserResponse response(UserTb user) {

    AdminUserResponse adminUserResponse = AdminUserResponse.builder().userIndex(user.getUserIndex())
        .userId(user.getUserId()).userName(user.getUserName()).userEmail(user.getUserEmail())
        .userPhone(user.getUserPhone()).branchName(user.getBranch().getBranchName())
        .userPosition(user.getUserPosition()).build();

    return adminUserResponse;
  }
}