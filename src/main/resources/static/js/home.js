$(document).ready(function() {
	recentlyHistory();
	todayHistory();
	drawDoughnut(false);
	checkEvent();
	userCount();
	branchCount();
	historyTotalCount();
	todayHistoryPercent();
});

function checkEvent() {
	$('#myDelivery').change(function() {	
		let checked = $(this).prop('checked');
		
		drawDoughnut(checked);
	});
}

function initDoughnut(res) {
	let data = null;
	
	if (res[2] !== 0) {
		data = {
			datasets: [{
				data: [],
				backgroundColor: [
					'rgb(255, 0, 0)',
					'rgb(255, 165, 0)',
					'rgb(0, 128, 0)'
					]
			}],
			labels: [
				'배송예정',
				'배송중',
				'배송완료'
			]
		};
	} else {
		data = {
			labels : ["Empty"],
			datasets: [{
				labels : "데이터가 존재하지 않습니다",
				backgroundColor: ['#D3D3D3'],
				data : [100]
			}]
		};
	}
	
	let config = {
			type: 'doughnut',
			data : data,
			options: {
				responsive: true,
				maintainAspectRatio: false,
				legend: {
					position: 'top'
				},
				title: {
					display: true,
					text: '배송현황'
				},
				animation: {
					animateScale: true,
					animateRotate: true
				}
		}
	}
	
	$('#chart-area').remove();
	$('#doughnutDiv').append(`<canvas id="chart-area"
	 class="chart-js-render-monitor"></canvas>`);
	
	let ctx = $('#chart-area');
	
	myDoughnut = new Chart(ctx, config);
	myDoughnut.options.circumference = Math.PI;
	myDoughnut.options.rotation = -Math.PI;
	
	for (let i = 0; i < res.length; i++) {
		myDoughnut.data.datasets[0].data.push(res[i]);
	}
	
	myDoughnut.update();
}

function drawDoughnut(checked) {
	$.ajax({
		url : "/home/getTotalCount.do",
		type : "get",
		data : {
			myDelivery : checked
		},
		success : function(res) {
			let will = res[0];
			let ing = res[1];
			let pp = res[2];
			let total = will + ing + pp;
		
			initDoughnut(res);
			
			drawProgress(will, ing, pp, total);
		}
	})
}

function drawProgress(will, ing, pp, total) {
	$('#willProgress').html(`<b>${will}</b>/${total}`);
	$('#ingProgress').html(`<b>${ing}</b>/${total}`);
	$('#ppProgress').html(`<b>${pp}</b>/${total}`);
	
	calWill = 0;
	calIng = 0;
	calPp = 0;
	
	if (total !== 0) {
		calWill = parseInt((will / total) * 100);
		calIng = parseInt((ing / total) * 100);
		calPp = parseInt((pp / total) * 100);
	}
	
	$("#willDiv").animate({
		width : `${calWill}%`
	}, 1000);
	$("#ingDiv").animate({
		width : `${calIng}%`
	}, 1000);
	$("#ppDiv").animate({
		width : `${calPp}%`
	}, 1000);
}

function recentlyHistory() {
	$.ajax({
		url : "/home/recentlyHistory",
		type : "get",

		success : function(res) {
			var str = "";
			if (res.resultCode !== "ERROR") {
			$.each(
					res.data,
					function(key, value) {
						str += `<tr class="tr-shadow">`;
						
						if(value.stat === -1)
						str += "<td><span class=\"badge badge-secondary\">발송완료</span></td>";
						else if(value.stat === 0)
							str += "<td><span class=\"badge badge-success\">발송중</span></td>";
						else if(value.stat === 1)
							str += "<td><span class=\"badge badge-warning\">발송예정</span></td>";
						str += "<td>" + value.dlvrdate	+ "</td>";
						str += "<td>" + value.arrivedate	+ "</td>";
						str += "<td>" + value.username + "</td>";
						str += "<td>" + value.dep + "</td>";
						str += "<td>" + value.arvl + "</td>";
						str += "<td>" + value.carname + "</td>";
						str += "</tr>";
					});
			} else {
				$("#tableListBody").html("");
				$("#page").html("");
				
				str += `<tr class="tr-shadow">`;
				str += `<td colspan="8">`;
				str += `${res.description}`;
				str += `</td>`;
				str += `</tr>`;
			}
				$("#schedule").html(str);
		}
	})
}

function todayHistory() {
	$.ajax({
		url : "/home/todayHistory",
		type : "get",
		success : function(res) {
			var str = "";
			
			$.each(
					res.data,
					function(key, value) {
						str += `<tr class="tr-shadow">`;
						if(value.stat === -1)
							str += "<td><span class=\"badge badge-secondary\">발송완료</span></td>";
						else if(value.stat === 0)
							str += "<td><span class=\"badge badge-success\">발송중</span></td>";
						else if(value.stat === 1)
							str += "<td><span class=\"badge badge-warning\">발송예정</span></td>";
						str += "<td>" + value.dlvrdate	+ "</td>";
						str += "<td>" + value.arrivedate	+ "</td>";
						str += "<td>" + value.username + "</td>";
						str += "<td>" + value.dep + "</td>";
						str += "<td>" + value.arvl + "</td>";
						str += "<td>" + value.carname + "</td>";
						str += "</tr>";
					});

				$("#schedule").html(str);
		}
	})
}

function todayHistoryPercent() {
	$.ajax({
		url : "/home/todayHistoryPercent",
		type : "get",
		success : function(res) {
			console.log(res)
			$("#todayPercent").html(res + '<small>%</small>');
		}
	});
}

function branchCount() {
	$.ajax({
		url : "/home/totalBranchCount",
		type : "get",
		data : {},
		success : function(res) {
			
			$("#branchCount").html(res + " 개");
		}
	})
}

function userCount() {
	$.ajax({
		url : "/home/totalUserCount",
		type : "get",
		data : {
		},
		success : function(res) {
			$("#userCount").html(res +" 명");
		}
	});
}

function historyTotalCount() {
	$.ajax({
		url : "/home/totalHistoryCount",
		type : "get",
		success : function(res) {
			
			$("#totalHistoryCount").html(res + " 개");
		}
	});
}