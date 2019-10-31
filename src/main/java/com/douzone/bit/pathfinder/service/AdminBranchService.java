package com.douzone.bit.pathfinder.service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import com.douzone.bit.pathfinder.model.entity.BranchTb;
import com.douzone.bit.pathfinder.repository.AreaRepository;
import com.douzone.bit.pathfinder.repository.BranchRepository;

@Service
public class AdminBranchService {

    @Autowired
    private BranchRepository branchRepository;

    @Autowired
    private AreaRepository areaRepository;

    // branch read
    public Optional<BranchTb> read(Long id) {

        return branchRepository.findById(id);
    }

    // branch create
    public BranchTb create(BranchTb request) {

        BranchTb branchTb = request;

        BranchTb branchtb = BranchTb.builder().branchAddr(branchTb.getBranchAddr())
                .branchDaddr(branchTb.getBranchDaddr()).branchLat(branchTb.getBranchLat())
                .branchLng(branchTb.getBranchLng()).branchPhone(branchTb.getBranchPhone())
                .branchName(branchTb.getBranchName()).branchOwner(branchTb.getBranchOwner())
                .branchValue(branchTb.getBranchValue()).area(areaRepository.getOne(branchTb.getArea().getAreaIndex()))
                .build();

        BranchTb newBranchTb = branchRepository.save(branchtb);

        return newBranchTb;

    }

    // branch page
    public List<BranchTb> search(Pageable pageable) {

        Page<BranchTb> branchs = branchRepository.findAll(pageable);

        List<BranchTb> branchList = branchs.stream().collect(Collectors.toList());

        return branchList;
    }

    // branch update
    public Optional<Object> update(BranchTb request) {

        BranchTb body = request;

        return branchRepository.findById(body.getBranchIndex()).map(branch -> {
            branch.setArea(body.getArea()).setBranchAddr(body.getBranchAddr()).setBranchDaddr(body.getBranchDaddr())
                    .setBranchLat(body.getBranchLat()).setBranchLng(body.getBranchLng())
                    .setBranchName(body.getBranchName()).setBranchOwner(body.getBranchOwner())
                    .setBranchPhone(body.getBranchPhone()).setBranchValue(body.getBranchValue());

            return branch;
        }).map(changeBranch -> branchRepository.save(changeBranch));
    }

    // branch delete
    public int delete(Long id) {
        return branchRepository.findById(id).map(branch -> {
            branchRepository.delete(branch);
            return 1;
        }).orElse(0);
    }
}