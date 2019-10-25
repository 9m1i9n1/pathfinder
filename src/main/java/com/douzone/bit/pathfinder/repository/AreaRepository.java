package com.douzone.bit.pathfinder.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.douzone.bit.pathfinder.model.entity.AreaTb;

@Repository
public interface AreaRepository extends JpaRepository<AreaTb, Long> {

}
