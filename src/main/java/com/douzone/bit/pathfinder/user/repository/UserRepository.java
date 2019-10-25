package com.douzone.bit.pathfinder.user.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.douzone.bit.pathfinder.user.entity.UserTb;

@Repository
public interface UserRepository extends JpaRepository<UserTb, Long> {

}
