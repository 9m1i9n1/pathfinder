package com.douzone.bit.pathfinder.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/maproute")
public class MaprouteController {

  @GetMapping({ "", "/" })
  public String maproute(Model model) {

    return "/maproute";
  }

}