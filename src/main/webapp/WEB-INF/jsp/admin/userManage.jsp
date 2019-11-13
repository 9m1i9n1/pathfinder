<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<title>Document</title>

<!-- Fontfaces CSS-->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/material-design-iconic-font/2.2.0/css/material-design-iconic-font.css" rel="stylesheet" media="all">

<!-- Main CSS-->
<link href="/static/css/theme.css" rel="stylesheet" media="all">
</head>

<body>
	<div class="container-fluid">
		<ol class="breadcrumb" id=headerol>
			<li class="breadcrumb-item">관리자 페이지 : 사용자 관리</a></li>
		</ol>
	</div>

	<div class="container-fluid">
		<div class="row">
			<div class="col-2">
				<div class="card">
					<div class="card-header">
						<b>조직도</b>
					</div>
					<div class="card-body">
						<div id="jstree"></div>
					</div>
				</div>
			</div>

			<div class="col-10">
				<div class="card">
					<div class="card-header">
						<b>사용자 목록</b>

						<button class="au-btn au-btn-icon au-btn--blue au-btn--small"
							data-toggle="modal" data-target="#insertModal">
							<i class="zmdi zmdi-plus"></i>사용자 추가
						</button>
					</div>

					<div class="table-responsive table-responsive-data2">
						<table id="table" class="table table-data2">
							<thead>
								<tr>
									<th><label class="au-checkbox"> <input
											type="checkbox"> <span class="au-checkmark"></span>
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

							<tbody id="body"></tbody>
						</table>

						<div id="page"></div>
					</div>
				</div>
			</div>

			<%@include file="userManageModal.jsp"%>
			<script src="/static/js/adminUserManage.js">
				
			</script>
</body>
</html>
