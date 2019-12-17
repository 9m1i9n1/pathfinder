<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>회원 관리 페이지</title>
</head>

<body>

	<section class="content-header">
		<div class="container-fluid">
			<div class="row mb-2">
				<div class="col-md-2 col-md-6">
					<h1>사용자 관리</h1>
				</div>
				<div class="col-md-6">
					<ol class="breadcrumb float-sm-right" id="headerol">
						<li class="breadcrumb-item"><a href="#">관리자 메뉴</a></li>
						<li class="breadcrumb-item active">사용자 관리</li>
					</ol>
				</div>
			</div>
		</div>
		<!-- /.container-fluid -->
	</section>

	<div class="container-fluid">
		<div class="row vh-80">
			<div class="col-md-2">
				<div class="card height100">
					<div class="card-header">
						<h3 class="card-title" style="height: 30px">조직도</h3>
					</div>

					<div class="card-body small height675px">
						<div id="jstree" class="myScrollableBlock"></div>
					</div>
				</div>
			</div>

			<div class="col-md-10">
				<div class="card height100">
					<div class="card-header">
						<h3 class="card-title">
							<button class="btn bg-gradient-primary btn-sm"
								data-toggle="modal" data-target="#insertModal">
								<i class="zmdi zmdi-plus"></i>사용자 추가
							</button>
						</h3>

						<div class="card-tools">
							<div class="input-group input-group-sm">
								<input type="search" name="table_search"
									class="col-sm-7 form-control form-control-navbar"
									placeholder="Search" />

								<div class="input-group-append">
									<button type="submit" class="btn btn-default">
										<i class="fas fa-search"></i>
									</button>
								</div>
							</div>
						</div>
					</div>

					<div class="card-body table-responsive p-0 ">
						<table id="table" class="table table-hover">
							<thead>
								<tr>
									<th><label class="au-checkbox"> <input
											type="checkbox" /> <span class="au-checkmark"></span>
									</label></th>
									<th style="display: none;">번호</th>
									<th>이름</th>
									<th>지점</th>
									<th>직책</th>
									<th>아이디</th>
									<th>이메일</th>
									<th>전화번호</th>
									<th>권한</th>
									<th>수정/삭제</th>
								</tr>
							</thead>

							<tbody id="body" class="small"></tbody>
						</table>


					</div>
				</div>
			</div>
		</div>
		<div id="page"></div>
	</div>

	<%@include file="userManageModal.jsp"%>

	<script src="/static/js/adminUserManage.js"></script>

</body>
</html>
