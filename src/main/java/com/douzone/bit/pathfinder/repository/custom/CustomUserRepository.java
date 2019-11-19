package com.douzone.bit.pathfinder.repository.custom;

import java.util.List;

import com.douzone.bit.pathfinder.model.entity.UserTb;
import com.douzone.bit.pathfinder.model.network.request.UserSearch;

public interface CustomUserRepository {

  public List<UserTb> search(UserSearch userSearch);
}