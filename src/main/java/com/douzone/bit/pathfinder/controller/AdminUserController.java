package com.douzone.bit.pathfinder.controller;

import java.util.List;
import java.util.Optional;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.douzone.bit.pathfinder.model.network.Header;
import com.douzone.bit.pathfinder.model.network.request.AdminUserRequest;
import com.douzone.bit.pathfinder.model.network.response.AdminUserResponse;
import com.douzone.bit.pathfinder.model.network.response.TreeResponse;
import com.douzone.bit.pathfinder.service.AdminBranchService;
import com.douzone.bit.pathfinder.service.AdminUserService;
import com.douzone.bit.pathfinder.service.TreeService;

@RestController
@RequestMapping("/admin/usermanage")
public class AdminUserController {

  @Autowired
  AdminUserService adminUserService;

  @Autowired
  AdminBranchService adminBranchService;

  @Autowired
  TreeService treeService;

  // 회원 리스트 뷰
  @GetMapping("")
  public ModelAndView userManage() {

    ModelAndView mv = new ModelAndView();
    mv.setViewName("/admin/userManage");

    return mv;
  }

  // 회원 리스트 불러오기
  @GetMapping("/userlist.do")
  public Header<List<AdminUserResponse>> userList(
      @PageableDefault(sort = { "userIndex" }, direction = Sort.Direction.DESC, size = 10) Pageable pageable) {

    return adminUserService.list(pageable);
  }

  // 트리 불러오기
  @GetMapping("/treelist.do")
  public Header<List<TreeResponse>> treeList(
      @RequestParam(value = "id", required = false, defaultValue = "#") String id) {

    return (id.equals("#")) ? treeService.readArea() : treeService.readBranch(id);

  }

  // 지점 리스트 불러오기
  @GetMapping("/branchlist.do")
  public Header<List<Object>> branchList(@RequestParam("areaIndex") Long areaIndex) {

    return adminUserService.readBranchName(areaIndex);
  }

  // 지역 리스트 불러오기
  @GetMapping("/arealist.do")
  public Header<List<Object>> areaList() {

    return adminUserService.readAreaName();
  }

  // 회원 등록
  @PostMapping("")
  public Header<AdminUserResponse> create(@RequestBody AdminUserRequest request) {

    return adminUserService.create(request);
  }

  // 비밀번호 초기화
  @PutMapping("/{userIndex}")
  public Header<AdminUserResponse> userUpdate(@PathVariable Long userIndex) {

    return adminUserService.update(userIndex);
  }

  // 회원 삭제
  @DeleteMapping("/{userIndex}")
  public Header userDelete(@PathVariable Long userIndex) {

    return adminUserService.delete(userIndex);
  }
}