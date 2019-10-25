package com.douzone.bit.pathfinder.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/hierarchy")
public class HierarchyController {

  @GetMapping({ "", "/" })
  public String hierarchy(Model model) {

    return "/hierarchy";
  }

}