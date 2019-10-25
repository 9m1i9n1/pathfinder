package com.douzone.bit.pathfinder.area.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.douzone.bit.pathfinder.area.entity.AreaTb;

@Repository
public interface AreaRepository extends JpaRepository<AreaTb, Long> {

}
