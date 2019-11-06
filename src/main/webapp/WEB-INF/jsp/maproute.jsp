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
						<b>검색</b>
						<input type="text" style="text-align: center; width:60%"/>
						<input type="button" value="확인" style="text-align: right; width:20% "/>
					</div>
					
					<div id = "fuckingmin2">
						<table class="table table-hover table-mc-light-blue"
									style="text-align: center;" id="allDataTable">
							<tr onclick="event.cancelBubble=true">
								<th onclick="event.cancelBubble=true" style="background-color: #fafafa; text-align: center;">branch_name(지역이름)</th>
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
					<div class="card" >
						<div class="card-header">
							<b>검색누른거</b>
						</div>
						<div id="fuckingmin2">
							<table  class="table table-hover table-mc-light-blue"
										style="text-align: center;" id="selectRoute"></table>
						</div>
						<button type="button" id="submitroute">전송</button>
					</div>
				</div>
			</div>
		</div>
		<div class = "row" style=" margin-top: 20px;">
			<div class="col-12">
				<div class="card">
					<div class="card-header">
						<b>경로</b>
					</div>
					<div class="card-body" style="min-height: 80px">
						<div id="testTable"></div>
					</div>
				</div>
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
		var trs = null;
		
		var Acnt = 0;
		arr = new Array;
		var Astr;
		
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
			trs = tbody.getElementsByTagName('tr');
			console.log(target);
			console.log(tbody);
			console.log(trs);
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
			var distance;
			var time;
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
				test = mapControl.setWaypoints(mapPlan.getWaypoints());
				
				test.on('routesfound', function (e) {
				    distance = e.routes[0].summary.totalDistance;
				    time = e.routes[0].summary.totalTime;
				    console.log("e가 뭐게요", e);
				    console.log("---", e.routes[0]);
				    console.log('totalDdistance: ' + distance);
				    console.log('totalTime: ' + time);
				});
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
								var str = "출발";
						$.ajax({
							url : "/maproute/maproutesend",
							type : 'post',
							data : JSON.stringify({
								"data" : data
							}),
							contentType : "application/json; charset=UTF-8",
							async: false,

							success : function(data) {

 								var mapInfoData = [];
								
								
								if (data.length > 0) {
									$.each(data, function(i, s) {
										/* data[i].branch_value
										data[i].branch_lat
										data[i].branch_lng */
										mapInfoData.push (L.latLng(data[i].branch_lat, data[i].branch_lng));
										str +=	'->' + data[i].branch_name; 
									});
									
									console.log('totalDdistance: ', distance);
								    console.log('totalTime: ' + time);
								    
								}
								drawMap(mapInfoData);
							},
							
							error : function(jqXHR, textStatus, errorThrown) {
								alert("에러 발생~~ \n" + textStatus + " : "
										+ errorThrown);
						}
					});
								str += "  ->  도착 총 걸리는 시간 : " + time + "총 거리 : " + distance;
								$("#testTable").html(str);
				}
			})
		})

		$(function () {
				tdArr = new Array(); // 배열 선언
				// 테이블의 Row 클릭시 값 가져오기
				$("#allDataTable tr").click(
						function() {
							Astr = "";
							Acnt = 0;
	
							// 현재 클릭된 Row(<tr>)
							var tr = $(this);
							console.log("티알입니다.",tr);
							var td = tr.children();
	
							var branch_name = td.eq(0).text();
							var branch_value = td.eq(1).text();
							var branch_lat = td.eq(2).text();
							var branch_lng = td.eq(3).text();
							if (arr.indexOf(branch_name) == -1) {
								arr.push(branch_name);
								if (arr.length > 0) {
									routecnt++;
									$.each(arr, function(i) {
										Acnt++;
										if (Acnt == 1)
											Astr += '<tr onClick="cancelRoute(this)">' + 
												'<td>' + '출발지' + '</td>' +
												'<td>' + (i + 1) + '</td>' + 
												'<td>' + arr[i] + '</td>' + 
												'</tr>';
										else
											Astr += '<tr onClick="cancelRoute(this)">' + 
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
									Acnt++;
									if (Acnt == 1)
										Astr += '<tr onClick="cancelRoute(this)">' + 
											'<td>' + '출발지' + '</td>' +
											'<td>' + (i + 1) + '</td>' + 
											'<td>' + arr[i] + '</td>' + 
											'</tr>';
									else
										Astr += '<tr onClick="cancelRoute(this)">' + 
										'<td>' + '경유지' + '</td>' + 
										'<td>' + (i + 1) + '</td>' + 
										'<td>' + arr[i] + '</td>' +
										'</tr>';
								});
							}
							$("#selectRoute").html(Astr);
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
		



		function cancelRoute(target) {
			for (var i = 0; i < data.length; i++) {
				if (target.childNodes[2].innerHTML === data[i].branch_name) {
					var ttt = data[i].branch_name;
				}
			}
			for (var i = 0; i < trs.length; i++) {
				if(i == 0)
					continue;
				
				if (ttt == trs[i].getElementsByTagName('td')[0].innerHTML){
					HighLightTR(trs[i], 'rgb(201, 204, 153)');
					
						Astr = "";
						Acnt = 0;

						routecnt--;
						arr.splice(arr.indexOf(ttt), 1);
						$.each(arr, function(ii) {
							Acnt++;
							if (Acnt == 1)
								Astr += '<tr onClick="cancelRoute(this)">' + 
									'<td>' + '출발지' + '</td>' +
									'<td>' + (ii + 1) + '</td>' + 
									'<td>' + arr[ii] + '</td>' + 
									'</tr>';
							else
								Astr += '<tr onClick="cancelRoute(this)">' + 
								'<td>' + '경유지' + '</td>' + 
								'<td>' + (ii + 1) + '</td>' + 
								'<td>' + arr[ii] + '</td>' +
								'</tr>';
						});
					$("#selectRoute").html(Astr);

				}
			}
		}
	</script>
</body>
</html>