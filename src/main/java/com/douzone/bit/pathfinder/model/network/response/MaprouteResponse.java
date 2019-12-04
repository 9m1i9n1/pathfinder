package com.douzone.bit.pathfinder.model.network.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MaprouteResponse {

  private Long branchIndex;

  private String branchName;

  private double branchLat;

  private double branchLng;

  private int routeCost;
}