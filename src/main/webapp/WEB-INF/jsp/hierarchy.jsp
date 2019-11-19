<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<link href="/static/css/theme.css" rel="stylesheet" media="all">
<link rel="stylesheet" href="/static/js/bootstrap/table.css">
</head>
<body>
	<div class="container-fluid">
		<ol id="headInfo" class="breadcrumb">
		</ol>
	</div>
	<div class="container-fluid">
		<div class="row">
			<div class="col-2">
				<div class="card">
					<div class="card-header">
						<b>부서 조직도</b>
					</div>
					<div class="card-body">
						<div id="jstree"></div>
					</div>
				</div>
			</div>
			<div class="col-9">
				<div class="card">
					<div class="card-header">
						<b>사용자 리스트</b>
						<div style="float: right;">
							<select id="searchType">
								<option selected value="name">이름</option>
								<option value="position">직책</option>
							</select> <input id="searchInput" />
							<button type="button" id="searchButton" onclick="getSearch()">검색</button>
						</div>
					</div>
					<div class="card-body">
						<div class="table-responsive table-responsive-data2">
							<table class="table table-data2">
								<thead>
									<tr>
										<th>이름</th>
										<th>이메일</th>
										<th>전화번호</th>
										<th>지점명</th>
										<th>직책</th>
									</tr>
								</thead>
								<tbody id="userTable"></tbody>
							</table>
							<div id="page"></div>
						</div>
					</div>
				</div>
			</div>
		</div>

	</div>

	<script src="/static/js/hierarchy.js"></script>
</body>
</html>
