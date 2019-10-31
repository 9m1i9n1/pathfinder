package com.douzone.bit.pathfinder.model.network.request;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder

public class adminUserRequest {

  private Long userIndex;

  private String userId;

  private String userPw;

  private String userName;

  private String userPosition;

  private String userEmail;

  private String userPhone;

  private LocalDateTime userCreated;

  private Boolean userAuth;

  private Long branchId;
}