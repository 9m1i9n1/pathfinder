<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
</head>
<body>
	<div class="container-fluid">
		<ol id="headInfo" class="breadcrumb">
		</ol>
	</div>
	<div class="container-fluid">
		<div class="row">
			<div class="col-3">
				<div class="d-flex flex-row h-100">
					<div class="card">
						<div class="card-header">
							<b>부서 조직도</b>
						</div>
						<div class="scrollable">
							<div class="test">
								<div class="card-body">
									<div class="item" id="jstree"></div>
								</div>
							</div>
						</div>
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
						<table class="table table-hover table-mc-light-blue"
							style="text-align: center;">
							<thead>
								<tr>
									<th style="background-color: #fafafa; text-align: center;">이름</th>
									<th style="background-color: #fafafa; text-align: center;">이메일</th>
									<th style="background-color: #fafafa; text-align: center;">전화번호</th>
									<th style="background-color: #fafafa; text-align: center;">지점명</th>
									<th style="background-color: #fafafa; text-align: center;">직책</th>
								</tr>
							</thead>
							<tbody id="userTable" style="font-size: 75%" />
						</table>
						<div id="page"></div>
					</div>
				</div>
			</div>
		</div>

	</div>

	<script src="/static/js/hierarchy.js"></script>
</body>
</html>
