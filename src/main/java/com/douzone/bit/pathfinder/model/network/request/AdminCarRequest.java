package com.douzone.bit.pathfinder.model.network.request;

import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder

public class AdminCarRequest {

	private Long carArea;
	private String carName;
	private Double carFuel;
	private String carNumber;
	
//	@DateTimeFormat(pattern="yyyy-MM-dd")
//	private LocalDateTime carBuy;
	
//	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
//	private LocalDateTime carBuy;
	
	private String carBuy; 
	
}

