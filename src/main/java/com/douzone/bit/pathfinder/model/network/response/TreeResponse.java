package com.douzone.bit.pathfinder.model.network.response;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Accessors(chain = true)
public class TreeResponse {

  private String id;

  private String text;

  private List<TreeResponse> children;
}
