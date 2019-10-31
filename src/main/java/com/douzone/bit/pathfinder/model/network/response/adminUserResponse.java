package com.douzone.bit.pathfinder.model.network.response;

import java.time.LocalDateTime;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder

public class adminUserResponse {

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

  private List<adminBranchResponse> branchResponseList;
}