package com.douzone.bit.pathfinder.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/userinfo")
public class UserinfoController {

  @GetMapping({ "", "/" })
  public String userinfo(Model model) {

    return "/userinfo";
  }
}