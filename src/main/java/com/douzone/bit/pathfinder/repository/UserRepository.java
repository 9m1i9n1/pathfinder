package com.douzone.bit.pathfinder.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

import com.douzone.bit.pathfinder.model.entity.UserTb;

@Repository
public interface UserRepository extends JpaRepository<UserTb, Long> {
  Optional<UserTb> findByType(String type);
}
