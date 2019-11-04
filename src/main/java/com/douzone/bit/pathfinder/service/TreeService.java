package com.douzone.bit.pathfinder.service;

import java.util.List;
import java.util.stream.Collectors;

import com.douzone.bit.pathfinder.model.entity.AreaTb;
import com.douzone.bit.pathfinder.model.entity.BranchTb;
import com.douzone.bit.pathfinder.model.network.Header;
import com.douzone.bit.pathfinder.model.network.response.TreeResponse;
import com.douzone.bit.pathfinder.repository.AreaRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TreeService {

  @Autowired
  AreaRepository areaRepository;

  public Header<List<TreeResponse>> readArea() {

    List<AreaTb> areas = areaRepository.findAll();

    List<TreeResponse> areaList = areas.stream().map(area -> areaResponse(area)).collect(Collectors.toList());

    return Header.OK(areaList);
  }

  public Header<List<TreeResponse>> readBranch(String id) {

    return null;
  }

  // public JsonArray readBranch(String id) {

  // String index[] = id.split(":");

  // List<BranchTb> branchData =
  // branchRepository.findByArea(areaRepository.getOne(Long.parseLong(index[1])));

  // JsonArray jArray = new JsonArray();

  // for (int i = 0; i < branchData.size(); i++) {
  // JsonObject sObject = new JsonObject();
  // sObject.addProperty("id", "branch:" + branchData.get(i).getBranchIndex());
  // sObject.addProperty("text", branchData.get(i).getBranchName());
  // jArray.add(sObject);
  // }

  // return jArray;
  // }

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