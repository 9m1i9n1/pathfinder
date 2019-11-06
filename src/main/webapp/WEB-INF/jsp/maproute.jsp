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
<script src="//code.jquery.com/jquery-3.4.1.min.js"></script>

<script>
	
</script>
<title>CSS</title>
<link href="/static/css/maproute.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://unpkg.com/leaflet@1.2.0/dist/leaflet.css" />
<link rel="stylesheet" href="/static/css/leaflet-routing-machine.css" />
</head>
<body>
	<div class="container-fluid">
		<ol class="breadcrumb">
			<li class="breadcrumb-item">경로탐색</a></li>
		</ol>
	</div>
	<div class="container-fluid">
		<div class="row">
			<div class="col-9">
				<div id="map"></div>
			</div>
			<div class="col-3">
				<div class="card">
					<div class="card-header">
						<b>검색</b> <input type="text"
							style="text-align: center; width: 60%" /> <input type="button"
							value="확인" style="text-align: right; width: 20%" />
					</div>

					<div id="tableEdge">
						<table class="table table-hover table-mc-light-blue"
							style="text-align: center;" id="allDataTable">
							<tr onclick="event.cancelBubble=true">
								<th onclick="event.cancelBubble=true"
									style="background-color: #fafafa; text-align: center;">branch_name(지역이름)</th>
								<th onclick="event.cancelBubble=true" style="display: none">branch_value(교통비)</th>
								<th onclick="event.cancelBubble=true" style="display: none">branch_lat(위도)</th>
								<th onclick="event.cancelBubble=true" style="display: none">branch_lng(경도)</th>
							</tr>

							<c:forEach items="${datalist}" var="list">
								<tr onClick="HighLightTR(this, 'rgb(201, 204, 153)');">
									<td>${list.branchName}</td>
									<td style="display: none">${list.branchValue}</td>
									<td style="display: none">${list.branchLat}</td>
									<td style="display: none">${list.branchLng}</td>
								</tr>
							</c:forEach>
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
		<div class="row" style="margin-top: 20px;">
			<div class="col-12">
				<div class="card">
					<div class="card-header">
						<b>경로</b>
					</div>
					<div class="card-body"
						style="min-height: 100px; max-height: 100px;">
						<div id="finalPathDiv"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="https://unpkg.com/leaflet@1.2.0/dist/leaflet.js"></script>
	<script src="/static/js/leaflet-routing-machine.js"></script>
	<script src="/static/js/routes.js"></script>
</body>
</html>