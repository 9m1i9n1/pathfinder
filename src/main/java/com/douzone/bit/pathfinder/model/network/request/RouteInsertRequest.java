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
public class RouteInsertRequest {

  private Long carIndex;

  private String dep;

  private String arvl;

  private String dlvrdate;

  private String arrivedate;

  private Integer fee;

  private Integer time;

  private Double dist;

<<<<<<< HEAD:src/main/java/com/douzone/bit/pathfinder/model/network/request/RouteInsertRequest.java
<<<<<<< HEAD:src/main/java/com/douzone/bit/pathfinder/model/network/request/RouteInsertRequest.java
  private List<MongoRoutesDTO> routes;
=======
  private List<Object> routes;
>>>>>>> parent of 7da44b8... Convert Second to HH:mm:ss:src/main/java/com/douzone/bit/pathfinder/model/network/request/MaprouteInsertRequest.java
}
=======
  private List<Object> routes;
}
>>>>>>> parent of 7da44b8... Convert Second to HH:mm:ss:src/main/java/com/douzone/bit/pathfinder/model/network/request/MaprouteInsertRequest.java
