package com.douzone.bit.pathfinder.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.douzone.bit.pathfinder.model.entity.BranchTb;
import com.douzone.bit.pathfinder.service.AdminService;

@RestController
@RequestMapping("/admin")
public class AdminController {

  @Autowired
  AdminService adminService;
	
  @GetMapping({ "", "/" })
  public String admin(Model model) {

    return "/admin/mainManage";
  }


  //branch read
  @GetMapping("/branchmanage/read/{branchIndex}")
  public ModelAndView read(@PathVariable Long branchIndex) {
	  
	  ModelAndView mv = new ModelAndView();
	  Header<BranchTb> a = adminService.read(branchIndex);
	  
	  mv.setViewName("/admin/branchManage");
	  mv.addObject("read", adminService.read(branchIndex));

	  return mv;
  }
  
  //branch page
  @GetMapping("/branchmanage")
  public ModelAndView search(@PageableDefault(sort ="branchIndex", direction = Sort.Direction.DESC, size = 15) Pageable pageable) {

	  ModelAndView mv = new ModelAndView();
	  Header<List<BranchTb>> b = adminService.search(pageable);
	  
	  mv.addObject("initpage", b.getData());
	  mv.setViewName("/admin/branchManage");
	  return mv;
	  
  }
  
  //branch update
  @PutMapping("/branchmanage/update")
  public Header update(@RequestBody Header<BranchTb> request) {
	  return adminService.update(request);
  }

  //branch delete
  @GetMapping("/branchmanage/delete/{branchIndex}")
  public Header delete(@PathVariable Long branchIndex) {
	  return adminService.delete(branchIndex);

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