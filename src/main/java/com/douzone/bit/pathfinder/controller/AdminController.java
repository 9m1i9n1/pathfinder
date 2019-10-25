package com.douzone.bit.pathfinder.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminController {

  @GetMapping({ "", "/" })
  public String admin(Model model) {

    return "/admin/mainManage";
  }

  @GetMapping("/branchmanage")
  public String branchManage(Model model) {

    return "/admin/branchManage";
  }

  @GetMapping("/usermanage")
  public String userManage(Model model) {

    return "/admin/userManage";
  }

  @GetMapping("/carmanage")
  public String carManage(Model model) {

    return "/admin/carManage";
  }

}