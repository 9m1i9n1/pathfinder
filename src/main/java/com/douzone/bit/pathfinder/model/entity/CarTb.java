package com.douzone.bit.pathfinder.model.entity;

import java.time.LocalDateTime;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Entity
public class CarTb {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long carIndex;
	private String carName;
	private Double carFuel;
	private String carNumber;
	private LocalDateTime carBuy;
}
