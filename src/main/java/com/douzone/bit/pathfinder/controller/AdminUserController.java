package com.douzone.bit.pathfinder.controller;

import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.douzone.bit.pathfinder.model.entity.BranchTb;
import com.douzone.bit.pathfinder.model.entity.UserTb;
import com.douzone.bit.pathfinder.model.network.request.AdminUserRequest;
import com.douzone.bit.pathfinder.model.network.response.AdminUserResponse;
import com.douzone.bit.pathfinder.service.AdminBranchService;
import com.douzone.bit.pathfinder.service.AdminUserService;

@RestController
@RequestMapping("/admin/usermanage")
public class AdminUserController {

  @Autowired
  AdminUserService adminUserService;

  @Autowired
  AdminBranchService adminBranchService;

  @PostMapping("")
  public AdminUserResponse create(@RequestBody AdminUserRequest request) {

    return adminUserService.create(request);
  }

  @GetMapping("")
  public ModelAndView userManage() {

    ModelAndView mv = new ModelAndView();
    mv.setViewName("/admin/userManage");

    return mv;
  }

  @GetMapping("/userlist.do")
  public List<AdminUserResponse> userList(
      @PageableDefault(sort = "userIndex", direction = Sort.Direction.DESC, size = 10) Pageable pageable) {

    return adminUserService.search(pageable);
  }

  @GetMapping("/branchlist.do")
  public List<Object> branchList() {

    return adminUserService.readBranchName();
  }

  @PutMapping("/{userIndex}")
  public Optional<AdminUserResponse> userUpdate(@PathVariable Long userIndex) {

    return adminUserService.update(userIndex);
  }

  @DeleteMapping("/{userIndex}")
  public int userDelete(@PathVariable Long userIndex) {

    return adminUserService.delete(userIndex);
  }
}