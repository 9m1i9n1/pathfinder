package com.douzone.bit.pathfinder.model.network.request;

import java.util.List;

import com.douzone.bit.pathfinder.model.dto.MongoRoutesDTO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RouteInsertRequest {

  private Long carIndex;

  private String dep;

  private String arvl;

  private String dlvrdate;

  private String arrivedate;

  private Integer fee;

  private Integer time;

  private Double dist;

  private List<MongoRoutesDTO> routes;
}
