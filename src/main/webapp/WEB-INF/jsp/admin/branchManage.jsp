<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>지점 관리 페이지</title>
</head>
<body>
	<div class="container-fluid">
		<ol class="breadcrumb">
			<li class="breadcrumb-item">관리자 페이지 : 지점 관리</li>
		</ol>
	</div>

	<div class="container-fluid">
		<div class="row">
			<div class="col-2">
				<div class="card">
					<div class="card-header">
						<h3 class="card-title">조직도</h3>
					</div>

					<div class="card-body small hierarchysideheight">
						<div id="jstree"></div>
					</div>
				</div>
			</div>

			<div class="col-10">
				<div class="card">
					<div class="card-header" style="height: 47px;">
						지점 목록
						<div style="float: right;">

							<div class="input-group input-group-sm">
								<button class=" btn btn-primary btn-sm btn-block bg-gradient-primary col-3" data-toggle="modal"
									data-target="#insertModal">지점 추가</button>
								<select class=" col-4 small " name="searchType" id="searchType">
									<option value="branchName" class="small">지점명</option>
									<option value="branchAddr" class="small">주소</option>
								</select> <input class="col-sm-7 form-control form-control-navbar"
									type="search" placeholder="Search" name="keyword" id="keyword" />
								<div class="input-group-append">
									<button class="btn btn-primary" name="btnSearch" id="btnSearch">
										<i class="fas fa-search"></i>
									</button>

								</div>
							</div>
						</div>
					</div>

					<div class="card-body table-responsive p-0">
						<table class="table table-hover" id="tableTest">
							<thead>
								<tr>
									<th style= "width:8%">지역</th>
									<th style= "width:12%">지점명</th>
									<th style= "width:7%">지점장</th>
									<th style= "width:33%">주소</th>
									<th style= "width:15%">전화번호</th>
									<th style= "width:10%">운반비</th>
									<th style= "width:10%">수정/삭제</th>
								</tr>
							</thead>

							<tbody id="tableListBody" class="small text-center"></tbody>

						</table>

						<div id="page"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>

<%@include file="branchManageModal.jsp"%>

<script src="/static/js/adminBranchManage.js"></script>
</html>
