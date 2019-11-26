package com.douzone.bit.pathfinder.model.entity;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import org.springframework.format.annotation.DateTimeFormat;

import com.douzone.bit.pathfinder.model.entity.BranchTb.BranchTbBuilder;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import lombok.experimental.Accessors;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Entity
@Builder
@ToString(exclude = { "carArea" })
@Accessors(chain = true)
public class CarTb {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long carIndex;
	private String carName;
	private Double carFuel;
	private String carNumber;
	
	private LocalDate carBuy;
	
	@ManyToOne
	@JoinColumn(name = "carArea")
	private AreaTb carArea;
}
