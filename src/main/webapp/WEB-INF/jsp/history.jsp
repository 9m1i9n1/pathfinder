<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Document</title>
</head>
<body>
	<section class="content-header">
		<div class="container-fluid">
			<div class="row mb-2">
				<div class="col-md-2 col-md-6">
					<h1>조회내역</h1>
				</div>
				<div class="col-md-6">
					<ol class="breadcrumb float-sm-right">
						<li class="breadcrumb-item"><a href="#">사용자 메뉴</a></li>
						<li class="breadcrumb-item active">조회내역</li>
					</ol>
				</div>
			</div>
		</div>
		<!-- /.container-fluid -->
	</section>

	<div class="container-fluid ">
		<div class="card height100">
			<div class="card-header">

				<div class="card-tools ">
					<div class="input-group input-group-sm">
						<select class=" col-4 small " name="searchType" id="searchType">
							<option value="regdate" class="small">출발일자</option>
							<option value="username" class="small">사용자</option>
							<option value="dep" class="small">출발지</option>
							<option value="dist" class="small">도착지</option>
							<option value="carindex" class="small">차량번호</option>

						</select> <input class="col-sm-7 form-control form-control-navbar"
							type="search" placeholder="Search" name="keyword" id="keyword" />
						<div class="input-group-append">
							<button class="btn btn-primary btn-sm" name="btnSearch"
								id="btnSearch">
								<i class="fas fa-search"></i>
							</button>
						</div>
					</div>
				</div>
			</div>

			<div class="card-body box-profile table-responsive p-0 height700px">


				<div class="card">
					<div class="card-header p-2">
						<ul class="nav nav-pills">
							<li class="nav-item"><a class="nav-link" href="#todayList"
								id="todayAjax" data-toggle="tab">오늘</a></li>
							<li class="nav-item"><a class="nav-link active"
								id="afterAjax" href="#afterList" data-toggle="tab">이후</a></li>
							<li class="nav-item"><a class="nav-link" href="#beforeList"
								id="beforeAjax" data-toggle="tab">이전</a></li>
						</ul>
					</div>
					<!-- /.card-header -->
					<div class="card-body">
						<div class="tab-content">
							<table class="table table-hover" >
								<thead>
									<tr>
										<th style="width: 10%">출발일자</th>
										<th style="width: 10%">사용자</th>
										<th style="width: 10%">출발지</th>
										<th style="width: 10%">도착지</th>
										<th style="width: 10%">차량번호</th>
										<th style="width: 10%">예약일자</th>
										<th style="width: 10%">상세보기</th>
									</tr>
								</thead>

								<tbody id="tableListBody" class="small">

								<div class="tab-pane" id="todayList">오늘D</div>

								<div class="tab-pane active" id="afterList">이후D</div>

								<div class="tab-pane" id="beforeList">이전D</div>
								</tbody>
								
							</table>
						</div>
						<!-- /.tab-content -->
					</div>
					<!-- /.card-body -->
				</div>
				<!-- /.nav-tabs-custom -->
			</div>

			<div id="page"></div>

		</div>
	</div>
	</div>

</body>
<%@include file="historyModal.jsp"%>

<script src="/static/js/history.js"></script>
<script src="/static/js/hisoryModal.js"></script>
</html>