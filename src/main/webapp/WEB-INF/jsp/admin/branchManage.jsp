<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>

<title>Document</title>
</head>
<body>
	<h1>Branch</h1>
	<input type="button" data-toggle="modal" data-target="#insertModal" value="지점 추가" class="btn btn-primary btn-lg" />
	<table id="tableTest">
	</table>
	<%@include file="branchManageModal.jsp"%>
</body>
<script src="/static/js/adminBranchManage.js">

</html>