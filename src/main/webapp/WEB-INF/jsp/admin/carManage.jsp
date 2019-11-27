<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<head>
<title>차량 관리 페이지</title>
</head>
<body>
	<div class="container-fluid">
		<ol class="breadcrumb">
			<li class="breadcrumb-item">관리자 페이지 : 차량 관리</li>
		</ol>
	</div>

	<div class="container-fluid">
		<div class="row">
			<div class="col-2">
				<div class="card">
					<div class="card-header">
						<h3 class="card-title">조직도</h3>
					</div>

					<div class="card-body">
						<div id="jstree"></div>
					</div>
				</div>
			</div>

			<div class="col-10">
				<div class="card">
					<div class="card-header">
						<h3 class="card-title">차량 목록</h3>

						<button class="btn btn-block bg-gradient-primary col-2"
							data-toggle="modal" data-target="#insertModal">차량 추가</button>

						<div style="float: right;">
							<select name="searchType" id="searchType">
								<option value="carNumber">차량번호</option>
								<option value="carName">차종</option>
							</select> <input type="text" name="keyword" id="keyword" />
							<button class="btn btn-primary" name="btnSearch" id="btnSearch">
								<i class="fas fa-search"></i>
							</button>
						</div>
					</div>

					<div class="card-body table-responsive p-0">
						<table class="table table-hover" id="tableTest">
							<thead>
								<tr>
									<th>지역</th>
									<th>차량번호</th>
									<th>차종</th>
									<th>연비</th>
									<th>구입날짜</th>
									<th>삭제</th>
								</tr>
							</thead>

							<tbody id="tableListBody"></tbody>

						</table>

						<div id="page"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>

<%@include file="carManageModal.jsp"%>

<script src="/static/js/adminCarManage.js"></script>
</html>
