package com.douzone.bit.pathfinder.model.network.request;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MaprouteRequest {

  private Long branchIndex;

  private String branchName;

  private double branchLat;

  private double branchLng;
}