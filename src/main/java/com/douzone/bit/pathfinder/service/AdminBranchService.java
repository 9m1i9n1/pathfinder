package com.douzone.bit.pathfinder.service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import com.douzone.bit.pathfinder.model.entity.BranchTb;
import com.douzone.bit.pathfinder.model.network.request.AdminBranchRequest;
import com.douzone.bit.pathfinder.model.network.response.AdminBranchResponse;
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
    public AdminBranchResponse create(AdminBranchRequest request) {

        System.out.println(request);
        
        BranchTb branch = BranchTb.builder()
                .branchAddr(request.getBranchAddr())
                .branchDaddr(request.getBranchDaddr())
                .branchLat(request.getBranchLat())
                .branchLng(request.getBranchLng())
                .branchPhone(request.getBranchPhone())
                .branchName(request.getBranchName())
                .branchOwner(request.getBranchOwner())
                .branchValue(request.getBranchValue())
                .area(areaRepository.getOne(request.getAreaIndex()))
                .build();

        branchRepository.save(branch);

        return response(branch);

    }

    // branch page
    public List<AdminBranchResponse> search(Pageable pageable) {

        Page<BranchTb> branchs = branchRepository.findAll(pageable);

        List<AdminBranchResponse> branchResponseList = branchs.stream().map(branch -> response(branch)).collect(Collectors.toList());

        return branchResponseList;
    }

    // branch update
    public Optional<AdminBranchResponse> update(AdminBranchRequest request) {

    	Optional<BranchTb> optional = branchRepository.findById(request.getBranchIndex());
    	
    	System.out.println("#optional : " + optional);
    	System.out.println("#request : " + request);
    	
    	return optional.map(branch -> {
        		branch
                .setBranchName(request.getBranchName())
                .setBranchOwner(request.getBranchOwner())
                .setBranchPhone(request.getBranchPhone())
                .setBranchValue(request.getBranchValue())
                .setArea(areaRepository.getOne(request.getAreaIndex()));
                
                return branch;
    	})
    	.map(newBranch -> branchRepository.save(newBranch))
    	.map(newBranch -> response(newBranch));
    }

    // branch delete
    public int delete(Long id) {
        return branchRepository.findById(id).map(branch -> {
            branchRepository.delete(branch);
            return 1;
        }).orElseGet(() -> 0);
    }
    
    private AdminBranchResponse response(BranchTb branch) {
    	
    	AdminBranchResponse adminBranchResponse = AdminBranchResponse.builder()
    			.branchIndex(branch.getBranchIndex())
    			.branchName(branch.getBranchName())
    			.branchOwner(branch.getBranchOwner())
    			.branchValue(branch.getBranchValue())
    			.branchAddr(branch.getBranchAddr())
    			.branchDaddr(branch.getBranchDaddr())
    			.branchPhone(branch.getBranchPhone())
    			.branchLat(branch.getBranchLat())
    			.branchLng(branch.getBranchLng())
    			.area(branch.getArea().getAreaName())
    			.areaIndex(branch.getArea().getAreaIndex())
    			.build();
    			
    	
    	return adminBranchResponse;
    }
    
    
}