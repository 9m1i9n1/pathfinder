package com.douzone.bit.pathfinder.model.network.request;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MaprouteInsertRequest {

  private Long carIndex;

  private String dep;

  private String arvl;

  private String dlvrdate;

  private String arrivedate;

  private Integer fee;

  private Integer time;

  private Double dist;

  private List<Object> routes;
}
