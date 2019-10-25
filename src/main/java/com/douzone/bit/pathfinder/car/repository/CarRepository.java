package com.douzone.bit.pathfinder.car.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.douzone.bit.pathfinder.car.entity.CarTb;

@Repository
public interface CarRepository extends JpaRepository<CarTb, Long> {

}
