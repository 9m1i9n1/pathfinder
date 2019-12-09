$(document).ready(function() {
	recentlyHistory();
	todayHistory();
	drawDoughnut();
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
	
	console.log(parseInt((pp / total) * 100));
	
	$('#willDiv').css('width', parseInt((will / total) * 100) + '%');
	$('#ingDiv').css('width', parseInt((ing / total) * 100) + '%');
	$('#ppDiv').css('width', parseInt((pp / total) * 100) + '%');
}

function recentlyHistory(){
	$.ajax({
		url : "/home/recentlyHistory",
		type : "get",
		data : {
			page : 0
		},
		success : function(res) {
			console.log("good")
			var str = "";
			
			$.each(
					res.data,
					function(key, value) {
						str += `<tr class="tr-shadow">`;
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

function todayHistory(){
	$.ajax({
		url : "/home/todayHistory",
		type : "get",
		data : {
			page : 0
		},
		success : function(res) {
			console.log("good")
			var str = "";
			
			$.each(
					res.data,
					function(key, value) {
						str += `<tr class="tr-shadow">`;
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