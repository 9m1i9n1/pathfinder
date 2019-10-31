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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
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

    System.out.println("#control request : " + request);

    return adminUserService.create(request);
  }

  @GetMapping("")
  public ModelAndView userManage(
      @PageableDefault(sort = "userIndex", direction = Sort.Direction.DESC, size = 15) Pageable pageable, Model model) {

    ModelAndView mv = new ModelAndView();
    mv.setViewName("/admin/userManage");

    return mv;
  }

  @GetMapping("/userlist.do")
  public List<AdminUserResponse> userList(
      @PageableDefault(sort = "userIndex", direction = Sort.Direction.DESC, size = 15) Pageable pageable) {

    return adminUserService.search(pageable);
  }

  @GetMapping("/branchlist.do")
  public List<String> branchList() {

    return adminUserService.readBranchName();
  }

  @DeleteMapping("/{userIndex}")
  public int userDelete(@PathVariable Long userIndex) {

    return adminUserService.delete(userIndex);
  }
}