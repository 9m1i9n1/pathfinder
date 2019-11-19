package com.douzone.bit.pathfinder.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.support.QuerydslRepositorySupport;
import org.springframework.data.repository.NoRepositoryBean;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;
import com.douzone.bit.pathfinder.model.entity.UserTb;
import com.douzone.bit.pathfinder.model.entity.BranchTb;
// import com.douzone.bit.pathfinder.model.entity.QBranchTb;
// import com.douzone.bit.pathfinder.model.entity.QUserTb;
// import com.douzone.bit.pathfinder.model.entity.QAreaTb;

import com.douzone.bit.pathfinder.model.network.request.UserSearch;
import com.douzone.bit.pathfinder.repository.custom.CustomUserRepository;
import com.querydsl.jpa.JPQLQuery;

@NoRepositoryBean
public class UserRepositoryImpl extends QuerydslRepositorySupport implements CustomUserRepository {

	public UserRepositoryImpl() {
		super(UserTb.class);
	}

	@Override
	public List<UserTb> search(UserSearch userSearch) {

		// QUserTb user = QUserTb.userTb;
		// QBranchTb branch = QBranchTb.branchTb;
		// QAreaTb area = QAreaTb.areaTb;

		// JPQLQuery query = from(user);

		// if (userSearch.getBranchIndex() != null) {
		// query.leftJoin(user.branch, branch)
		// .where(branch.userList)
		// } else {

		// }

		return null;
	}
}
