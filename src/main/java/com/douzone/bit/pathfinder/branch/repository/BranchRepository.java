package com.douzone.bit.pathfinder.branch.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.douzone.bit.pathfinder.branch.entity.BranchTb;

@Repository
public interface BranchRepository extends JpaRepository<BranchTb, Long> {

}
