package com.douzone.bit.pathfinder.model.network.request;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class AdminBranchRequest {

  private Long branchIndex;

  private String branchName;

  private String branchOwner;

  private Integer branchValue;

  private String branchAddr;

  private String branchDaddr;

  private String branchPhone;

  private Double branchLat;

  private Double branchLng;
  
  private Long areaIndex;
}
