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
	<div id="maproute-container">
		<div id="maproute-content">
			    <div id="map">   	
			    </div>    
		</div>
		<div id="maproute-sidebar">
			<h6>검색</h6>
			<div id="fuckingmin2">
				<table border="1" align=center id="allDataTable"
					style="height: 200px; width: 90%; overflow: hidden;">
					<tr>
						<th onclick="event.cancelBubble=true">branch_name(지역이름)</th>
						<th onclick="event.cancelBubble=true"
							onclick="event.cancelBubble=true" style="display: none">branch_value(교통비)</th>
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
		</div>
		<div id="maproute-sidebar">
			<h6>검색 누른거</h6>
			<div id="fuckingmin2">
				<table border="1" id="selectRoute"></table>
			</div>
				<button type="button" id="submitroute">전송</button>
		</div>
		<div id="maproute-footer">
			<p>경로</p>
			<div id="fuckingmin">
				<table border="1" id="testTable"></table>
			</div>
		</div>
	</div>
	
	<script src="https://unpkg.com/leaflet@1.2.0/dist/leaflet.js"></script>
		<script src="/static/js/leaflet-routing-machine.js"></script>
		<script type="text/javascript">
		var tbody;
		var orgBColor = '#ffffff';
		var route = new Array();
		var amu = new Object;
		var data = new Array();
		var totalprice = 0;
		var routecnt = 0;
		var aaaaa= 0;
		
		function HighLightTR(target, backColor) {
			tbody = target.parentNode;
			var trs = tbody.getElementsByTagName('tr');

			for (var i = 0; i < trs.length; i++) {

				//녹색을 클릭
				if (trs[i].style.backgroundColor == 'rgb(45, 180, 0)'
						&& trs[i] == target) {
					trs[i].style.backgroundColor = orgBColor;
					route = route.splice(1, route.length);
					data = data.splice(1, data.length);
					if (route.length != 0)
						route[0].style.backgroundColor = 'rgb(45, 180, 0)';
					continue;
				}

				//첫번째 클릭.
				if (route.length == 0 && trs[i] == target) {
					trs[i].style.backgroundColor = 'rgb(45, 180, 0)';
					route.push(target);

					amu = new Object;
					amu.branch_name = target.childNodes[1].innerHTML;
					amu.branch_value = target.childNodes[3].innerHTML;
					amu.branch_lat = target.childNodes[5].innerHTML;
					amu.branch_lng = target.childNodes[7].innerHTML;
					data.push(amu);

					continue;
				}

				//나머지 클릭
				if (trs[i] == target) {
					if (trs[i].style.backgroundColor == backColor) {
						trs[i].style.backgroundColor = orgBColor;
						//0 1 2 3 4 5 6에서 slice(1,4)하면 1 2 3 출력
						//var a = route = route.splice(1, route.length);
						var hi = 0;
						route.forEach(function(item) {
							if (item === target) {
								var t1 = new Array();
								t1 = route.splice(hi, 1);
								t1 = data.splice(hi, 1);
							}
							hi++;
						});

					} else {
						trs[i].style.backgroundColor = backColor;

						amu = new Object();
						amu.branch_name = target.childNodes[1].innerHTML;
						amu.branch_value = target.childNodes[3].innerHTML;
						amu.branch_lat = target.childNodes[5].innerHTML;
						amu.branch_lng = target.childNodes[7].innerHTML;
						data.push(amu);
						route.push(target);
					}
				}
			} // endfor i
		}

		//data : encodeURI(JSON.stringify(data)),
		
		//버튼 누르면 경로 출력
		$(function() {
			var mapPlan;
			var mapControl;
			var been_routed = false;
			var prev_size = 0;
			
			/* 지도 출력 함수 */
			function drawMap(mapData) {
				/* 만약 처음으로 지도를 출력할 경우 Plan객체 생성 및 Control */
				if (!been_routed) {
					/* 탐색할 경로 계획 설정 초기화. */
					mapPlan = L.Routing.plan(mapData, {
						routeWhileDragging : false,
						draggableWaypoints : false
					});
					
					/* Routing Controller에 경로 계획 추가 */
					/* 최적의 경로 출력 */
					mapControl = L.Routing.control({
						plan : mapPlan
					});
					
					/* 첫 번째 호출을 true로 설정. */
					been_routed = true;
				} else {
					/* 기존에 존재하던 Waypoints들 수 만큼 mapPlan에서 제거. */
					mapPlan.spliceWaypoints(0, prev_size,
							mapPlan.getWaypoints());
					
					/* mapPlan에 새로운 경로 추가. */
					mapPlan.setWaypoints(mapData);
					
					/* Controller에 mapPlan 등록. */
					mapControl.setWaypoints(mapPlan.getWaypoints());
				}
				
				/* 이전에 탐색한 WayPoints 길이를 저장 */
				prev_size = mapData.length;
				
				/* map에 출력. */
				mapControl.addTo(map);
			}
			
			$("#submitroute").click(

					function() {
						if (routecnt <= 2) {
							alert("출발지와 목적지를 포함한 경로가 세개 이상이어야 합니다.");
						} else if (routecnt > 15) {
							alert("경유지가 너무 MP염");
						} else {
							$.ajax({
								url : "/maproute/maproutesend",
								type : 'post',
								data : JSON.stringify({
									"data" : data
								}),
								contentType : "application/json; charset=UTF-8",

								success : function(data) {
									
									var str = "<tr>";/*  '<tr>' + '<th>전달된 a</th>'
											+ '<th>전달된 b</th>' + '<th>전달된 c</th>'
											+ '<th>전달된 d</th>' + '</tr>';
	 										*/
	 								var aaarr = [];
									if (data.length > 0) {
										$.each(data, function(i, s) {
											aaarr.push (L.latLng(data[i].branch_lat, data[i].branch_lng));
											str +=	'<th>' + data[i].branch_name + '</th>' + 
											'<th style="display: none">' + data[i].branch_value + '</th>' + 
											'<th style="display: none">' + data[i].branch_lat + '</th>' + 
											'<th style="display: none">' + data[i].branch_lng + '</th>';

										});
										str += "</tr>";
									
									}
									
									drawMap(aaarr);
									
									$("#testTable").html(str);
									
								},

								error : function(jqXHR, textStatus, errorThrown) {
									alert("에러 발생~~ \n" + textStatus + " : "
											+ errorThrown);
								}
							});
						}
					})
		})

		$(
				function() {
					arr = new Array;
					tdArr = new Array(); // 배열 선언
					// 테이블의 Row 클릭시 값 가져오기
					$("#allDataTable tr").click(
							function() {
								var str = "";

								// 현재 클릭된 Row(<tr>)
								var tr = $(this);
								var td = tr.children();
								var cnt = 0;

								var branch_name = td.eq(0).text();
								var branch_value = td.eq(1).text();
								var branch_lat = td.eq(2).text();
								var branch_lng = td.eq(3).text();
								if (arr.indexOf(branch_name) == -1) {
									arr.push(branch_name);
									if (arr.length > 0) {
										routecnt++;
										$.each(arr, function(i) {
											cnt++;
											if (cnt == 1)
												str += '<tr>' + 
													'<td>' + '출발지' + '</td>' +
													'<td>' + (i + 1) + '</td>' + 
													'<td>' + arr[i] + '</td>' + 
													'</tr>';
											else
												str += '<tr>' + 
												'<td>' + '경유지' + '</td>' + 
												'<td>' + (i + 1) + '</td>' + 
												'<td>' + arr[i] + '</td>' +
												'</tr>';
										});
									}
								} else {
									routecnt--;
									arr.splice(arr.indexOf(branch_name), 1);
									$.each(arr, function(i) {
										cnt++;
										if (cnt == 1)
											str += '<tr>' + 
												'<td>' + '출발지' + '</td>' +
												'<td>' + (i + 1) + '</td>' + 
												'<td>' + arr[i] + '</td>' + 
												'</tr>';
										else
											str += '<tr>' + 
											'<td>' + '경유지' + '</td>' + 
											'<td>' + (i + 1) + '</td>' + 
											'<td>' + arr[i] + '</td>' +
											'</tr>';
									});
								}
								$("#selectRoute").html(str);
							});
				})
		//맵을 클릭할 때마다 포인트를 add해주는 ajax를 만들어야함.
		/*
		testarr.forEach(function(element){
			console.log(element);
			});
			
		for(var i = 0; i < testarr.length; ++i){
			console.log('하이염');
			console.log(testarr[i].branch_lat);
			console.log(testarr[i].branch_lng);
			}
		*/
			var map = L.map('map').setView([36.441163, 127.861612], 7);
		
			L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
				attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
			}).addTo(map);

		 </script>
</body>
</html>