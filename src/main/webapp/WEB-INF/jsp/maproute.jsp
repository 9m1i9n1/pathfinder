<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<!-- 선언부 밑에 위치해야한다. -->
<%@page import="java.util.ArrayList"%>
<%@page import="com.douzone.bit.pathfinder.model.entity.RouteDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- <%@include file="DramaVO.jsp" %>--%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<script src="/static/js/swiper.min.js"></script>
<script>
	
</script>
<title>CSS</title>

<link rel="stylesheet" href="/static/css/swiper.min.css">
<link href="/static/css/maproute.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://unpkg.com/leaflet@1.2.0/dist/leaflet.css" />
<link rel="stylesheet" href="/static/css/leaflet-routing-machine.css" />
</head>

<body>
<!-- 	<button type="button" onClick="location.href = '/maproute/tt'">aaa</button> -->
	<div class="container-fluid">
		<ol class="breadcrumb">
			<li class="breadcrumb-item">경로탐색</a></li>
		</ol>
	</div>
	<div class="container-fluid">
		<div class="row">
			<div class="col-9">
				<div id="map" style="height:540px"></div>
			</div>
			<div class="col-3">
				<div class="card">
					<div class="card-header">
						<b>검색</b> <input type="text" name="keyword" id="keyword"
							style="text-align: center; width: 60%" /> <input type="button"
							name="btnSearch" id="btnSearch" value="확인" style="width: 20%" />
					</div>

					<div id="tableEdge">
						<table class="table table-hover table-mc-light-blue"
							style="text-align: center;" id="allDataTable">
						</table>
					</div>
					<div class="card">
						<div class="card-header">
							<b>검색누른거</b>
						</div>
						<div id="tableEdge">
							<table class="table table-hover table-mc-light-blue"
								style="text-align: center;" id="selectRoute"></table>
						</div>
						<button type="button" id="submitroute">전송</button>
					</div>
				</div>
			</div>
		</div>
		<div class="row" style="margin-top: 5px;">
			<div class="col-9">
				<div class="card">
					<div class="card-header">
						<b>경로</b>
					</div>
					<div class="row flex-row flex-nowrap" id="box" class="box" style="min-height:200px; max-height: 200px;">
					</div>
				</div>
			</div>
			<div class="col-3">
				<div class="card" >
					<div class="card-header" > 
						<b>최종값</b>
					</div>
					<div class="card-body" style="min-height: 200px;">
						<div id="finalPathDiv"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="/static/js/routes.js"></script>
<!-- 	<script src="https://unpkg.com/leaflet@1.2.0/dist/leaflet.js"></script>
	<script src="/static/js/leaflet-routing-machine.js"></script>
	<script src="/static/js/routes.js"></script> -->
</body>
</html>