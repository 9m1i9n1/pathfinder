package com.douzone.bit.pathfinder.model.entity.mongodb;

import java.time.LocalDateTime;
import java.util.Date;

import javax.persistence.Id;

import org.bson.types.ObjectId;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.mongodb.core.mapping.Document;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
@Document(collection = "history")
public class HistoryTb {

	@Id
	private ObjectId id;

	@CreatedDate
	private Date regdate;

	private String username;

	private Long carname;

	private String dep;

	private String arvl;

	private Double dist;

	private Integer fee;

	private Date dlvrdate;

	private Date arrivedate;

	private ObjectId routes;
}
