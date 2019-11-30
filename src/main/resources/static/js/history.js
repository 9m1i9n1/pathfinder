$(document).ready(function() {
  getHistory();
});

function getHistory() {
	$.ajax({
		url: "/history/gethistory.do",
		type: "get",
		success: function(res) {
			let str = "";
			
			console.log(res);
			$.each(res.data, function(key, value) {		
				str += `<tr class="tr-shadow">`;
				str += "<td>" + value.dlvrdate + "</td>";
				str += "<td>" + value.username + "</td>";
				str += "<td>" + value.dep + "</td>";
				str += "<td>" + value.arvl + "</td>";
				str += "<td>" + value.carname + "</td>";
				str += "<td>" + value.regdate + "</td>";
				str += "<td><button class='btn btn-primary btn-sm bg-gradient-primary'"
								 + "data-toggle='modal' data-target='#detailsModal'"
								 + "onclick='getRoutes(" + JSON.stringify(value) + ")'>상세보기</button></td>";
				str += "</tr>";
			});
			
			$("#tableListBody").html(str);
		}
	})
}

// Modal
var detailsModal = $("#detailsModal");

// detailsModal 열릴 시
detailsModal.on("shown.bs.modal", function() {
  // something Do...
});

function getRoutes(routes) {
	$.ajax({
		url: "/history/getroutes.do",
		type: "get",
		data: {routesIndex : routes.routes},
		success: function(res) {
			let str = "";
			let count = 0;

			$.each(res.data.detail, function(key, value) {
				str += `<tr class="tr-shadow">`;
				str += "<td>" + ++count + "</td>";
				str += "<td>" + value.rdep + "</td>";
				str += "<td>" + value.rarvl + "</td>";
				str += "<td>" + value.rdist + "</td>";
				str += "<td>" + value.rtime + "</td>";
				str += "<td>" + value.rfee + "</td>";
				str += "</tr>";
			});
			
			$("#routesListBody").html(str);
			
			detailsModal
			.find("#regdate")
			.text(routes.regdate);
			
			detailsModal
			.find("#username")
			.text(routes.username);
			
			detailsModal
			.find("#depandarvl")
			.text(routes.dep + " -> " + routes.arvl);
			
			detailsModal
			.find("#dist")
			.text("총 거리 : " + routes.dist);
			
			detailsModal
			.find("#fee")
			.text("총 비용 : " + routes.fee);
		}
	})
}