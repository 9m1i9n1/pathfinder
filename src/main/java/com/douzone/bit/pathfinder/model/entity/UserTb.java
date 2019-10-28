package com.douzone.bit.pathfinder.model.entity;

import java.time.LocalDateTime;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;

import com.douzone.bit.pathfinder.model.entity.AreaTb;
import com.douzone.bit.pathfinder.model.entity.BranchTb;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Entity
public class UserTb {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long userIndex;
	private String userId;
	private String userPw;
	private String userName;
	private String userPosition;
	private String userEmail;
	private String userPhone;
	private LocalDateTime userCreated;
	private Boolean userAuth;
	
	@ManyToOne
	@JoinColumn(name = "branch_index")
	private BranchTb branch;
}
