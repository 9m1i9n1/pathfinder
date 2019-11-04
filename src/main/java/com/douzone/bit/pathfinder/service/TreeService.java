package com.douzone.bit.pathfinder.service;

import java.util.List;
import java.util.stream.Collectors;

import com.douzone.bit.pathfinder.model.entity.AreaTb;
import com.douzone.bit.pathfinder.model.entity.BranchTb;
import com.douzone.bit.pathfinder.model.network.Header;
import com.douzone.bit.pathfinder.model.network.response.TreeResponse;
import com.douzone.bit.pathfinder.repository.AreaRepository;
import com.douzone.bit.pathfinder.repository.BranchRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TreeService {

  @Autowired
  AreaRepository areaRepository;

  @Autowired
  BranchRepository branchRepository;

  public Header<List<TreeResponse>> readArea() {

    List<AreaTb> areas = areaRepository.findAll();

    List<TreeResponse> areaList = areas.stream().map(area -> areaResponse(area)).collect(Collectors.toList());

    return Header.OK(areaList);
  }

  public Header<List<TreeResponse>> readBranch(String id) {

    Long index = Long.parseLong(id.split(":")[1]);

    System.out.println("#index");
    System.out.println(index);

    List<BranchTb> branchs = branchRepository.findByArea(areaRepository.getOne(index));

    List<TreeResponse> branchList = branchs.stream().map(branch -> branchResponse(branch)).collect(Collectors.toList());

    return Header.OK(branchList);
  }

  // Response 데이터 파싱
  private TreeResponse areaResponse(AreaTb area) {

    TreeResponse treeResponse = TreeResponse.builder().id("area:" + area.getAreaIndex()).text(area.getAreaName())
        .children(true).build();

    return treeResponse;
  }

  private TreeResponse branchResponse(BranchTb branch) {

    TreeResponse treeResponse = TreeResponse.builder().id("branch:" + branch.getBranchIndex())
        .text(branch.getBranchName()).children(false).build();

    return treeResponse;
  }

}