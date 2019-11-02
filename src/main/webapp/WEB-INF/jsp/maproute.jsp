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
		
		/* Map Data */
		/* Route Plan 초기화 */
		var mapPlan = L.Routing.plan({
			routeWhileDragging : false,
			draggableWaypoints : false
		});
		
		/* Route Control 초기화 */
		var mapControl = L.Routing.control({});
			
		var marker = new Array(); // 지도에 출력할 Marker 정보 배열
		var latLngInfo = new Array(); // 최종경로 출력 전 기존 경로 데이터 배열
		var removeMarker;
		var removeInfo;
		var prev_size = 0;	
		var bool_routed = false;
		
		function HighLightTR(target, backColor) {
			tbody = target.parentNode;
			var trs = tbody.getElementsByTagName('tr');
			
			/* 기존 경로결과를 초기화하고 남아있던 Marker 출력. */
			if (bool_routed){
				bool_routed = false;
				
				/* 기존에 존재하던 Waypoints들 수 만큼 mapPlan에서 제거. */
				mapPlan.spliceWaypoints(0, prev_size,
						mapPlan.getWaypoints());
				
				/* 경로 초기화 */
				mapControl.setWaypoints(mapPlan.getWaypoints());
				mapControl.addTo(map);

				/* Marker 배열 초기화 */
				marker.length = 0;
				
				/* 기존에 남은 경로 출력 */
				for (var i = 0; i < latLngInfo.length; i++) {
					marker.push(L.marker(latLngInfo[i]).addTo(map));
				}
			}
			
			for (var i = 0; i < trs.length; i++) {
				//녹색을 클릭
				if (trs[i].style.backgroundColor == 'rgb(45, 180, 0)'
						&& trs[i] == target) {
					
					trs[i].style.backgroundColor = orgBColor;
					route = route.splice(1, route.length);
					data = data.splice(1, data.length);
					
					/* 삭제될 마커 정보 저장. */
					removeMarker = marker;
					/* removeInfo = latLngInfo; */
					
					/* Marker 배열은 삭제된 배열을 제거하고 남은 배열 저장. */
					marker = marker.splice(1, marker.length);
					latLngInfo = latLngInfo.splice(1, latLngInfo.length);
					
					/* 지도에서 Merker 제거. */
					map.removeLayer(removeMarker[0]);
										
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
					
					/* 위경도정보추가 */
					latLngInfo.push([amu.branch_lat, amu.branch_lng]);
					/* 마커추가 */	
					marker.push(L.marker([amu.branch_lat, amu.branch_lng]).addTo(map));
					continue;
				}

				//나머지 클릭
				if (trs[i] == target) {
					if (trs[i].style.backgroundColor == backColor) {
						trs[i].style.backgroundColor = orgBColor;
						//0 1 2 3 4 5 6에서 slice(1,4)하면 1 2 3 출력
						//var a = route = route.splice(1, route.length);
						var index = 0;
						route.forEach(function(item) {
							if (item === target) {
								var t1 = new Array();
								t1 = route.splice(index, 1);
								t1 = data.splice(index, 1);
								
								/* 제거할 마커 정보 Splice */
								removeMarker = marker.splice(index, 1);
								latLngInfo.splice(index, 1);
								/* 해당 마커를 Map에서 제거 */
								map.removeLayer(removeMarker[0]);
							}
							index++;
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
						
						/* 위경도정보추가 */
						latLngInfo.push([amu.branch_lat, amu.branch_lng]);
						/* Marker 추가 */
						marker.push(L.marker([amu.branch_lat, amu.branch_lng]).addTo(map));
					}
				}
			} // endfor i
		}

		//data : encodeURI(JSON.stringify(data)),
		
		//버튼 누르면 경로 출력
		$(function() {	
			
			/* 지도 출력 함수 */
			function drawMap(mapInfoData) {
				bool_routed = true;
				
				/* 이전 맵에 미리 클릭된 마커를 모두 제거. */
				for(var i = 0; i < marker.length; i++) {
					map.removeLayer(marker[i]);
				}
				
				/* 기존에 존재하던 Waypoints들 수 만큼 mapPlan에서 제거. */
				mapPlan.spliceWaypoints(0, prev_size,
						mapPlan.getWaypoints());
					
				/* mapPlan에 새로운 경로 추가. */
				mapPlan.setWaypoints(mapInfoData);
					
				/* Controller에 mapPlan 등록. */
				mapControl.setWaypoints(mapPlan.getWaypoints());
				
				/* 이전에 탐색한 WayPoints 길이를 저장 */
				prev_size = mapPlan.getWaypoints().length;
				
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
 								var mapInfoData = [];
								if (data.length > 0) {
									$.each(data, function(i, s) {
										mapInfoData.push (L.latLng(data[i].branch_lat, data[i].branch_lng));
										str +=	'<th>' + data[i].branch_name + '</th>' + 
										'<th style="display: none">' + data[i].branch_value + '</th>' + 
										'<th style="display: none">' + data[i].branch_lat + '</th>' + 
										'<th style="display: none">' + data[i].branch_lng + '</th>';

									});
									str += "</tr>";
								
								}
								
								drawMap(mapInfoData);
								
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

		$(function() {
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
		
		/* testarr.forEach(function(element){
			console.log(element);
			});
			
		for(var i = 0; i < testarr.length; ++i){
			console.log('하이염');
			console.log(testarr[i].branch_lat);
			console.log(testarr[i].branch_lng);
			} */
		
		var map = L.map('map').setView([36.441163, 127.861612], 7);
	
		L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
			attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
		}).addTo(map);
	</script>
</body>
</html>