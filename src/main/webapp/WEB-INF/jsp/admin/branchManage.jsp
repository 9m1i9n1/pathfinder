<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.9/dist/css/bootstrap-select.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.9/dist/js/bootstrap-select.min.js"></script>
<title>지점관리페이지</title>

</head>
<body>
	<div class="container-fluid">
		<ol class="breadcrumb">
			<li class="breadcrumb-item">관리자 페이지</li>
			<li class="breadcrumb-item active">지점 관리</li>
		</ol>
	</div>

	<div class="card-header">
		<b>지점 관리</b> <input type="button" data-toggle="modal"
			data-target="#insertModal" value="지점 추가" />
		<span id="seachAll"></span>
	</div>

	<table class="table table-hover table-mc-light-blue"
		style="text-align: center; boarder: 1px solid #ddddd" id="tableTest">
		<thead>
			<tr>
				<th>번호</th>
				<th>지역</th>
				<th>지점명</th>
				<th>지점장</th>
				<th>운반비</th>
				<th>주소</th>
				<th>전화번호</th>
				<th>수정/삭제</th>
			</tr>
		</thead>
		<tbody id="tableListBody">
		</tbody>
	</table>
	
	<div class="form-group row justify-content-center">
			<div class="w100" style="padding-right:10px">
				<select class="form-control form-control-sm" name="searchType" id="searchType">
					<option value="branchName">지점명</option>
					<option value="areaName">지역</option>
					<option value="branchAddr">주소</option>
				</select>
			</div>
			<div class="w300" style="padding-right:10px">
				<input type="text" class="form-control form-control-sm" name="keyword" id="keyword">
			</div>
			<div>
				<button class="btn btn-sm btn-primary" name="btnSearch" id="btnSearch">검색</button>
			</div>
			
		</div>
		<div id="page1"></div>
</body>
<%@include file="branchManageModal.jsp"%>
<script src="/static/js/adminBranchManage.js">
	
</script>
</html>