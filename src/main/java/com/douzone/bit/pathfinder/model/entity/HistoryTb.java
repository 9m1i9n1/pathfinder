package com.douzone.bit.pathfinder.model.entity;

import org.springframework.data.mongodb.core.mapping.Document;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Document(collection="history")
public class HistoryTb {

	private String _id;
	private String name;
	private String age;
}
