package com.douzone.bit.pathfinder.model.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Entity
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
	
	@ManyToOne
	@JoinColumn(name = "area_index")
	private AreaTb area;
}
