package com.douzone.bit.pathfinder.model.network.request;

import java.time.LocalDateTime;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AdminUserRequest {

  private Long userIndex;

  @NotBlank
  private String userId;

  @NotBlank
  private String userPw;

  @NotBlank
  private String userName;

  @NotBlank
  private String userPosition;

  @NotBlank
  @Email
  private String userEmail;

  @NotBlank
  private String userPhone;

  private LocalDateTime userCreated;

  @NotBlank
  private Boolean userAuth;

  @NotBlank
  private Long branchIndex;
}