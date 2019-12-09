$(document).ready(function() {
	recentlyHistory();
	todayHistory();
	drawDoughnut();
	userCount()
	branchCount()
	historyTotalCount()
	todayHistoryPercent()
});

function drawDoughnut() {
	var config = {
			type: 'doughnut',
			data : {
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
			},
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
	
	$.ajax({
		url : "/home/getTotalCount.do",
		type : "get",
		success : function(res) {
			let ctx = $('#chart-area');
			
			let will = res[0];
			let ing = res[1];
			let pp = res[2];
			let total = will + ing + pp;
			
			window.myDoughnut = new Chart(ctx, config);

			window.myDoughnut.options.circumference = Math.PI;
			window.myDoughnut.options.rotation = -Math.PI;
			
			for (let i = 0; i < res.length; i++) {
				window.myDoughnut.data.datasets[0].data.push(res[i]);
			}
			
			window.myDoughnut.update();
			
			drawProgress(will, ing, pp, total);
		}
	})
}

function drawProgress(will, ing, pp, total) {
	$('#willProgress').html(`<b>${will}</b>/${total}`);
	$('#ingProgress').html(`<b>${ing}</b>/${total}`);
	$('#ppProgress').html(`<b>${pp}</b>/${total}`);
	
	$('#willDiv').css('width', parseInt((will / total) * 100) + '%');
	$('#ingDiv').css('width', parseInt((ing / total) * 100) + '%');
	$('#ppDiv').css('width', parseInt((pp / total) * 100) + '%');
}

function recentlyHistory() {
	$.ajax({
		url : "/home/recentlyHistory",
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
			$("#todayPercent").html(res + " %");
		}
	});
}

function branchCount() {
	$.ajax({
		url : "/home/totalBranchCount",
		type : "get",
		data : {},
		success : function(res) {
			var count = "";
			count = res.pagination.totalElements + " 개";
			console.log(count)
			$("#branchCount").html(count);
		}
	})
}

function userCount() {
	let treeId = sessionStorage.getItem("treeId");
	let selectPage = sessionStorage.getItem("page");

	$.ajax({
		url : "/home/totalUserCount",
		type : "get",
		data : {
			treeId : treeId,
			page : selectPage
		},
		success : function(res) {
			let str = "";
			let count = "";

			count = res.pagination.totalElements + " 명";
			console.log(count)
			$("#userCount").html(count);
		}
	});
}

function historyTotalCount() {
	$.ajax({
		url : "/home/totalHistoryCount",
		type : "get",
		success : function(res) {
			var str = 0;
			let count = "";
			$.each(res.data,function(key, value) {
				str += 1
				});
			count = str + " 개";
			console.log(count)
			$("#totalHistoryCount").html(count);
		}
	});
}
