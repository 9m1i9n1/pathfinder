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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import com.douzone.bit.pathfinder.model.entity.UserTb;
import com.douzone.bit.pathfinder.service.AdminUserService;

@RestController
@RequestMapping("/admin")
public class AdminUserController {

  @Autowired
  AdminUserService adminUserService;

  @GetMapping("/usermanage")
  public ModelAndView userManage(
      @PageableDefault(sort = "userIndex", direction = Sort.Direction.DESC, size = 15) Pageable pageable, Model model) {

    ModelAndView mv = new ModelAndView();
    mv.setViewName("/admin/userManage");

    return mv;
  }

  @GetMapping("/usermanage.do")
  public List<UserTb> userManageList(
      @PageableDefault(sort = "userIndex", direction = Sort.Direction.DESC, size = 15) Pageable pageable) {

    return adminUserService.search(pageable);
  }

  @DeleteMapping("/usermanage/delete/{userIndex}")
  public int userDelete(@PathVariable Long userIndex) {

    return adminUserService.delete(userIndex);
  }
}