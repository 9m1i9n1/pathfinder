<<<<<<< HEAD
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<!-- 선언부 밑에 위치해야한다. -->
<%@page import="java.util.ArrayList"%>
<%@page import="com.douzone.bit.pathfinder.model.entity.TestDTO"%>
<%@page import="com.douzone.bit.pathfinder.model.entity.testDTO2"%>
<%-- <%@include file="DramaVO.jsp" %>--%>

<%
	List<String> listTest = new ArrayList<String>();
	listTest.add("List1");
	listTest.add("List2");
	listTest.add("List3");
	listTest.add("List4");
	listTest.add("List5");
	listTest.add("List6");
	listTest.add("List7");
	listTest.add("List8");

	TestDTO dto = null;
	testDTO2 dto2 = null;

	List<TestDTO> lists = new ArrayList<TestDTO>();
	for (int i = 1; i < 9; i++) {

		dto = new TestDTO();
		dto.setAreaName("t" + i);
		dto.setTransportationExpenses((int) (Math.random() * 100));
		dto.setLatitude((Math.round(((Math.random() * 1000) + 1) * 10000)) / 10000.0);
		dto.setLongitude((Math.round(((Math.random() * 1000) + 1) * 10000)) / 10000.0);
		lists.add(dto);

	}

	List<testDTO2> lists2 = new ArrayList<testDTO2>();
	for (int i = 0; i < 4; i++) {

		dto2 = new testDTO2();
		dto2.setT1("t" + (i + 3));
		dto2.setT2("test" + (i + 3));
		lists2.add(dto2);

	}
%>
=======
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
>>>>>>> origin/master

<!DOCTYPE html>
<html>
<head>
<<<<<<< HEAD
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="//code.jquery.com/jquery-3.4.1.min.js"></script>

<script>
	var tbody;
	var orgBColor = '#ffffff';
	var route = new Array();
	var amu = new Object;
	var data = new Array();
	
	var routecnt =0;
	
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
				console.log('녹색 누르면 데이타가 사라지니? ', data);
				console.log("녹색 클릭할 때 ", routecnt);
				if (route.length != 0)
					route[0].style.backgroundColor = 'rgb(45, 180, 0)';
				continue;
			}

			//첫번째 클릭.
			if (route.length == 0 && trs[i] == target) {
				trs[i].style.backgroundColor = 'rgb(45, 180, 0)';
				route.push(target);

				amu = new Object;
				amu.areaName = target.childNodes[1].innerHTML;
				amu.transportationExpenses = target.childNodes[3].innerHTML;
				amu.latitude = target.childNodes[5].innerHTML;
				amu.longitude = target.childNodes[7].innerHTML;
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
					console.log("나머지 클릭할 때 ", routecnt);
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
					amu.areaName = target.childNodes[1].innerHTML;
					amu.transportationExpenses = target.childNodes[3].innerHTML;
					amu.latitude = target.childNodes[5].innerHTML;
					amu.longitude = target.childNodes[7].innerHTML;
					data.push(amu);
					route.push(target);
				}
			}
		} // endfor i
	}

	//data : encodeURI(JSON.stringify(data)),

	$(function() {
		$("#submitroute").click(

				function() {
					if(routecnt <= 2){
						alert("출발지와 목적지를 포함한 경로가 세개 이상이어야 합니다.");
					} else if(routecnt > 5){
						alert("경유지가 너무 MP염");
					}else{
					$.ajax({
						url : "/test/testSend",
						type : 'post',
						data : JSON.stringify({
							"data" : data
						}),
						contentType : "application/json; charset=UTF-8",

						success : function(data) {
							var str = '<tr>' + '<th>전달된 a</th>'
									+ '<th>전달된 b</th>' + '<th>전달된 c</th>'
									+ '<th>전달된 d</th>' + '</tr>';

							if (data.length > 0) {
								$.each(data, function(i, s) {
									str += '<tr>' + '<td>' + data[i].areaName
											+ '</td>' + '<td>'
											+ data[i].transportationExpenses
											+ '</td>' + '<td>'
											+ data[i].latitude + '</td>'
											+ '<td>' + data[i].longitude
											+ '</td>' + +'</tr>';

								});
							}
							$("#testTable").html(str);
						},

						error : function(jqXHR, textStatus, errorThrown) {
							alert("에러 발생~~ \n" + textStatus + " : "
									+ errorThrown);
						}
					});}
				})
	})

	$(function() {
		arr = new Array;
		tdArr = new Array(); // 배열 선언
		// 테이블의 Row 클릭시 값 가져오기
		$("#allDataTable tr").click(function() {
			var str = "경로 = ";

			// 현재 클릭된 Row(<tr>)
			var tr = $(this);
			var td = tr.children();
			var cnt =0;
			console.log("ajax 내부", routecnt);
			console.log("클릭한 Row의 모든 데이터 : " + tr.text());

			var areaName = td.eq(0).text();
			var transportationExpenses = td.eq(1).text();
			var latitude = td.eq(2).text();
			var longitude = td.eq(3).text();
			console.log("변수에 제대로 드갔니 -", areaName,transportationExpenses,latitude,longitude);
			if (arr.indexOf(areaName) == -1) {
				arr.push(areaName);
				if (arr.length > 0) {
					routecnt++;
					$.each(arr, function(i) {
						cnt++;
						if (cnt == arr.length)
							str += arr[i];
						else
							str += arr[i] + "->";
					});
				}
			} else {
				routecnt--;
				arr.splice(arr.indexOf(areaName), 1);
				$.each(arr, function(i) {
					cnt++;
					if (cnt == arr.length)
						str += arr[i];
					else
						str += arr[i] + "->"
				});
			}
			console.log("areaName = ", areaName);
			$("#selectRoute").html(str);
		});
	})
</script>

<title>Insert title here</title>
=======
  <title>Document</title>
>>>>>>> origin/master
</head>
<body>
	<table border="1" align=center id="allDataTable">
		<tr>
			<th>areaName(지역이름)</th>
			<th>transportationExpenses(교통비)</th>
			<th>latitude(위도)</th>
			<th>longitude(경도)</th>
		</tr>
		<%
			for (TestDTO list : lists) {
		%>
		<tr onClick="HighLightTR(this, 'rgb(201, 204, 153)');">
			<td id="areaName"><%=list.getAreaName()%></td>
			<td id="transportationExpenses"><%=list.getTransportationExpenses()%></td>
			<td id="latitude"><%=list.getLatitude()%></td>
			<td id="longitude"><%=list.getLongitude()%></td>
		</tr>
		<%
			}
		%>
	</table>
	<div id="selectRoute"></div>
	<button type="button" id="submitroute">전송</button>
	<table border="1" id="testTable">
	</table>

	<!-- 저기서 버튼을 누르면 여기선 소팅이 되서 보여주면 된다. -->
</body>

</html>
