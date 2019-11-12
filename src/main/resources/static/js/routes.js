$(document).ready(function() {
	branchlist();
	
	$("#allDataTable tr").click(
			function() {
				selectRouteStr = "";
				selectRouteCnt = 0;

				// 현재 클릭된 Row(<tr>)
				var tr = $(this);
				var td = tr.children();
				
				var branch_name = td.eq(0).text().trim();
				var branch_value = td.eq(1).text().trim();
				var branch_lat = td.eq(2).text().trim();
				var branch_lng = td.eq(3).text().trim();
				if (arr.indexOf(branch_name) == -1) {
					arr.push(branch_name);
					if (arr.length > 0) {
						routecnt++;
						$.each(arr, function(i) {
							selectRouteCnt++;
							if (selectRouteCnt == 1)
								selectRouteStr += '<tr onClick="cancelRoute(this)">' + 
									'<td>' + '출발지' + '</td>' +
									'<td>' + (i + 1) + '</td>' + 
									'<td>' + arr[i] + '</td>' + 
									'</tr>';
							else
								selectRouteStr += '<tr onClick="cancelRoute(this)">' + 
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
						selectRouteCnt++;
						if (selectRouteCnt == 1)
							selectRouteStr += '<tr onClick="cancelRoute(this)">' + 
								'<td>' + '출발지' + '</td>' +
								'<td>' + (i + 1) + '</td>' + 
								'<td>' + arr[i] + '</td>' + 
								'</tr>';
						else
							selectRouteStr += '<tr onClick="cancelRoute(this)">' + 
							'<td>' + '경유지' + '</td>' + 
							'<td>' + (i + 1) + '</td>' + 
							'<td>' + arr[i] + '</td>' +
							'</tr>';
					});
				}
				$("#selectRoute").html(selectRouteStr);
			});
});

var tbody;
var orgBColor = '#ffffff';
var route = new Array();
var branchObject = new Object;
var branchObjectDataArray = new Array();
var totalprice = 0;
var routecnt = 0;
var trs = null;
var selectRouteCnt = 0;
arr = new Array;
var selectRouteStr;

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
		// 녹색을 클릭
		if (trs[i].style.backgroundColor == 'rgb(45, 180, 0)'
				&& trs[i] == target) {
			
			trs[i].style.backgroundColor = orgBColor;
			route = route.splice(1, route.length);
			branchObjectDataArray = branchObjectDataArray.splice(1, branchObjectDataArray.length);
			
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

		// 첫번째 클릭.
		if (route.length == 0 && trs[i] == target) {
			trs[i].style.backgroundColor = 'rgb(45, 180, 0)';
			route.push(target);
			branchObject = new Object;
			branchObject.branch_name = target.childNodes[0].innerHTML.trim();
			branchObject.branch_value = target.childNodes[1].innerHTML.trim();
			branchObject.branch_lat = target.childNodes[2].innerHTML.trim();
			branchObject.branch_lng = target.childNodes[3].innerHTML.trim();
			branchObjectDataArray.push(branchObject);
			
			/* 위경도정보추가 */
			latLngInfo.push([branchObject.branch_lat, branchObject.branch_lng]);
			/* 마커추가 */	
			marker.push(L.marker([branchObject.branch_lat, branchObject.branch_lng]).addTo(map));
			continue;
		}

		// 나머지 클릭
		if (trs[i] == target) {
			if (trs[i].style.backgroundColor == backColor) {
				trs[i].style.backgroundColor = orgBColor;
				// 0 1 2 3 4 5 6에서 slice(1,4)하면 1 2 3 출력
				// var a = route = route.splice(1, route.length);
				var index = 0;
				route.forEach(function(item) {
					if (item === target) {
						var t1 = new Array();
						t1 = route.splice(index, 1);
						t1 = branchObjectDataArray.splice(index, 1);
						
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

				branchObject = new Object();
				branchObject.branch_name = target.childNodes[0].innerHTML.trim();
				branchObject.branch_value = target.childNodes[1].innerHTML.trim();
				branchObject.branch_lat = target.childNodes[2].innerHTML.trim();
				branchObject.branch_lng = target.childNodes[3].innerHTML.trim();
				branchObjectDataArray.push(branchObject);
				route.push(target);
				
				/* 위경도정보추가 */
				latLngInfo.push([branchObject.branch_lat, branchObject.branch_lng]);
				/* Marker 추가 */
				marker.push(L.marker([branchObject.branch_lat, branchObject.branch_lng]).addTo(map));
			}
		}
	} // endfor i
}

// data : encodeURI(JSON.stringify(data)),

// 버튼 누르면 경로 출력
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
		test = mapControl.setWaypoints(mapPlan.getWaypoints());
		
		/* 이전에 탐색한 WayPoints 길이를 저장 */
		prev_size = mapPlan.getWaypoints().length;
		
		/* map에 출력. */
		mapControl.addTo(map);
		
		return test;
	}
	
	$("#submitroute").click(	
		function() {
			
			if (routecnt <= 2) {
				alert("출발지와 목적지를 포함한 경로가 세개 이상이어야 합니다.");
			} else if (routecnt > 100) {
				alert("경유지가 너무 MP염");
			} else {
				var str = "출발 : ";
				$.ajax({
					url : "/maproute/maproutesend",
					type : 'post',
					data : JSON.stringify({
						"data" : branchObjectDataArray
					}),
					contentType : "application/json; charset=UTF-8",
					async: false,

					success : function(branchObjectDataArray) {
						
						var mapInfoData = [];
				
						if (branchObjectDataArray.length > 0) {
							$.each(branchObjectDataArray, function(i, s) {
								/*
								 * data[i].branch_value data[i].branch_lat
								 * data[i].branch_lng
								 */
								mapInfoData.push (L.latLng(branchObjectDataArray[i].branch_lat, branchObjectDataArray[i].branch_lng));
								str +=	branchObjectDataArray[i].branch_name + '->'; 
							});
						}
						
						new Promise(function(resolve, reject) {
							resolve(drawMap(mapInfoData));
							
						}).then((result) => {
							test.on('routesfound', function (e) {
								var distance = e.routes[0].summary.totalDistance;
							    var time = e.routes[0].summary.totalTime;
							    var m = time/60;
							    var h = parseInt(m/60);
							    var s = parseInt(time%60);
							    var m = parseInt(m%60);
							    var km = (distance/1000).toFixed(1);
							    str += "  도착 <br/> 총 걸리는 시간 : " + h + "시간 " + m + "분 " + s +"초 <br/> 총 거리 : " + km +"Km";
							    $("#finalPathDiv").html(str);
							});
						})
					},
					
					error : function(jqXHR, textStatus, errorThrown) {
						alert("에러 발생~~ \n" + textStatus + " : "
								+ errorThrown);
				}
			});
		}
	})
})



$(function () {
		tdArr = new Array(); // 배열 선언
		// 테이블의 Row 클릭시 값 가져오기
		
		$("#allDataTable").find("#2").click(
				function(){
					selectRouteStr = "";
					selectRouteCnt = 0;

					// 현재 클릭된 Row(<tr>)
					var tr = $(this);
					var td = tr.children();
					
					var branch_name = td.eq(0).text().trim();
					var branch_value = td.eq(1).text().trim();
					var branch_lat = td.eq(2).text().trim();
					var branch_lng = td.eq(3).text().trim();
					if (arr.indexOf(branch_name) == -1) {
						arr.push(branch_name);
						if (arr.length > 0) {
							routecnt++;
							$.each(arr, function(i) {
								selectRouteCnt++;
								if (selectRouteCnt == 1)
									selectRouteStr += '<tr onClick="cancelRoute(this)">' + 
										'<td>' + '출발지' + '</td>' +
										'<td>' + (i + 1) + '</td>' + 
										'<td>' + arr[i] + '</td>' + 
										'</tr>';
								else
									selectRouteStr += '<tr onClick="cancelRoute(this)">' + 
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
							selectRouteCnt++;
							if (selectRouteCnt == 1)
								selectRouteStr += '<tr onClick="cancelRoute(this)">' + 
									'<td>' + '출발지' + '</td>' +
									'<td>' + (i + 1) + '</td>' + 
									'<td>' + arr[i] + '</td>' + 
									'</tr>';
							else
								selectRouteStr += '<tr onClick="cancelRoute(this)">' + 
								'<td>' + '경유지' + '</td>' + 
								'<td>' + (i + 1) + '</td>' + 
								'<td>' + arr[i] + '</td>' +
								'</tr>';
						});
					}
					$("#selectRoute").html(selectRouteStr);
				});
		
			})
// 맵을 클릭할 때마다 포인트를 add해주는 ajax를 만들어야함.

/*
 * testarr.forEach(function(element){ console.log(element); });
 * 
 * for(var i = 0; i < testarr.length; ++i){ console.log('하이염');
 * console.log(testarr[i].branch_lat); console.log(testarr[i].branch_lng); }
 */

var map = L.map('map').setView([36.441163, 127.861612], 7);

L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
	attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
}).addTo(map);




function cancelRoute(target) {
	for (var i = 0; i < branchObjectDataArray.length; i++) {
		if (target.childNodes[2].innerHTML === branchObjectDataArray[i].branch_name) {
			var ttt = branchObjectDataArray[i].branch_name;
		}
	}
	for (var i = 0; i < trs.length; i++) {
		if(i == 0)
			continue;
		
		if (ttt == trs[i].getElementsByTagName('td')[0].innerHTML){
			HighLightTR(trs[i], 'rgb(201, 204, 153)');
			
				selectRouteStr = "";
				selectRouteCnt = 0;

				routecnt--;
				arr.splice(arr.indexOf(ttt), 1);
				$.each(arr, function(ii) {
					selectRouteCnt++;
					if (selectRouteCnt == 1)
						selectRouteStr += '<tr onClick="cancelRoute(this)">' + 
							'<td>' + '출발지' + '</td>' +
							'<td>' + (ii + 1) + '</td>' + 
							'<td>' + arr[ii] + '</td>' + 
							'</tr>';
					else
						selectRouteStr += '<tr onClick="cancelRoute(this)">' + 
						'<td>' + '경유지' + '</td>' + 
						'<td>' + (ii + 1) + '</td>' + 
						'<td>' + arr[ii] + '</td>' +
						'</tr>';
				});
			$("#selectRoute").html(selectRouteStr);

		}
	}
}

// 검색버튼
$('#btnSearch').click(function(e){
	e.preventDefault();
	var url = "";    
	url = url + "?searchType=branchName";
	url = url + "&keyword=" + $('#keyword').val();
	branchsearch(url);
});

// 검색뷰
function branchsearch(searchUrl, searchpage) {
	$.ajax({
		type : "GET",
		url : "/maproute/search" + searchUrl +"&page=" + 0 ,
		contentType : 'application/json',
		async: false,
		success : function(res) {
			var str = '<tr onclick=\"event.cancelBubble=true\">';
				str += '<th onclick=\"event.cancelBubble=true\"';
				str += 'style=\"background-color: #fafafa; text-align: center;\">branch_name(지역이름)</th>';
				str += '<th onclick=\"event.cancelBubble=true\" style=\"display: none\">branch_value(교통비)</th>';
				str += '<th onclick=\"event.cancelBubble=true\" style=\"display: none\">branch_lat(위도)</th>';
				str += '<th onclick=\"event.cancelBubble=true\" style=\"display: none\">branch_lng(경도)</th>';
			$.each(res.data, function(key, value) {
				str += '<tr id="' + key + '" onClick=\"HighLightTR(this, \'rgb(201, 204, 153)\');\">';
				str += '<td>'+ value.branchName+ '</td>';
				str += '<td style=\"display: none\"> '+ value.branchValue+ '</td>';
				str += '<td style=\"display: none\">'+ value.branchLat+ '</td>';
				str += '<td style=\"display: none\">'+ value.branchLng+ '</td>';
				str += '</tr>'
			});
			$("#allDataTable").html(str);
//			var buttonAll = "";
//			buttonAll += '<button id="allSearchB" onclick="allSearch()">전체보기</button>';
//			$("#seachAll").html(buttonAll);
		}
	});
}

// 첫페이지
function branchlist() {
	$.ajax({
		url : "/maproute/allData",
		type: "get",
		async: false,
		success : function(res) {
			var str = '<tr onclick=\"event.cancelBubble=true\">';
				str += '<th onclick=\"event.cancelBubble=true\"';
				str += 'style=\"background-color: #fafafa; text-align: center;\">branch_name(지역이름)</th>';
				str += '<th onclick=\"event.cancelBubble=true\" style=\"display: none\">branch_value(교통비)</th>';
				str += '<th onclick=\"event.cancelBubble=true\" style=\"display: none\">branch_lat(위도)</th>';
				str += '<th onclick=\"event.cancelBubble=true\" style=\"display: none\">branch_lng(경도)</th>';
			$.each(res.data, function(key, value) {
				str += '<tr id="' + key + '" onClick=\"HighLightTR(this, \'rgb(201, 204, 153)\');\">';
				str += '<td>'+ value.branchName+ '</td>';
				str += '<td style=\"display: none\"> '+ value.branchValue+ '</td>';
				str += '<td style=\"display: none\">'+ value.branchLat+ '</td>';
				str += '<td style=\"display: none\">'+ value.branchLng+ '</td>';
				str += '</tr>'
			});
			$("#allDataTable").html(str);
		}
	})
}