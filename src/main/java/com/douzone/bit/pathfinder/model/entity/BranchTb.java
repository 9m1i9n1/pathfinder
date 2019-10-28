package com.douzone.bit.pathfinder.model.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Entity
@Builder
@Accessors(chain = true)
public class BranchTb {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long branchIndex;
	
	private String branchName;
	
	private String branchOwner;
	
	private Integer branchValue;
	
	private String branchAddr;
	
	private String branchDaddr;
	
	private String branchPhone;
	
	private Double branchLat;
	
	private Double branchLng;
}
