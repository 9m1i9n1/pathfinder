package com.douzone.bit.pathfinder.area.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Entity
public class AreaTb {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long areaIndex;
	private String areaName;
}
