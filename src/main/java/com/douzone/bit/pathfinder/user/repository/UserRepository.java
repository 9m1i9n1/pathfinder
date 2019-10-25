package com.douzone.bit.pathfinder.user.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.douzone.bit.pathfinder.user.entity.UserTb;

public interface UserRepository extends JpaRepository<UserTb, Long> {

}
