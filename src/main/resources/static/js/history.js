$(document).ready(function() {
	getHistory(0, "ing");
});

function pageButton(totalPages, currentPage, type, id) {
	$("#page").paging({
		nowPage : currentPage + 1,
		pageNum : totalPages,
		buttonNum : 12,
		callback : function(currentPage) {
			if (type === "history")
				getHistory(currentPage - 1, id);
		}
	});
}

function getHistory(selectPage, id) {
	$.ajax({
			url : "/history/gethistory.do",
			type : "get",
			data : {
				page : selectPage,
				id : id
			},
			success : function(res) {
				let str = "";
				
				$.each(
						res.data,
						function(key, value) {
							str += `<tr class="tr-shadow">`;
							str += "<td>" + value.dlvrdate	+ "</td>";
							str += "<td>" + value.username + "</td>";
							str += "<td>" + value.dep + "</td>";
							str += "<td>" + value.arvl + "</td>";
							str += "<td>" + value.carname + "</td>";
							str += "<td>" + value.regdate + "</td>";
							str += "<td><button class='btn btn-primary btn-sm bg-gradient-primary'"
									+ "data-toggle='modal' data-target='#detailsModal'"
									+ "onclick='getRoutes("
									+ JSON.stringify(value)
									+ ")'>상세보기</button></td>";
							str += "</tr>";
						});

					$("#tableListBody").html(str);

				pageButton(res.pagination.totalPages,
					res.pagination.currentPage, "history", id);
		}
	})
}

// Modal
var detailsModal = $("#detailsModal");

function removeRoutes(history) {
	let alertBox = confirm('해당 기록을 삭제하시겠습니까?');

	if (alertBox) {
		$.ajax({
			url : "/history/removeroutes.do",
			type : "post",
			data : JSON.stringify(history),
			contentType : "application/json; charset=UTF-8",
			success : function(res) {
				alert("삭제 되었습니다.");
				$("#detailsModal").modal("hide");
				getHistory(0);
			}
		})
	}
}

function getRoutes(routes) {
	$.ajax({
		url : "/history/getroutes.do",
		type : "get",
		data : {
			routesIndex : routes.routes
		},
		success : function(res) {
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

			if (userAuth === "[ROLE_ADMIN]") {
				$("#deleteBtn").show();
			} else if (userName === routes.username) {
				$("#deleteBtn").show();
			} else {
				$("#deleteBtn").hide();
			}

			$("#deleteBtn").off().on('click', function() {
				removeRoutes(routes);
			});

			$("#routesListBody").html(str);

			detailsModal.find("#regdate").text(routes.regdate);

			detailsModal.find("#username").text(routes.username);

			detailsModal.find("#depandarvl").text(
					routes.dep + " -> " + routes.arvl);

			detailsModal.find("#dist").text("총 거리 : " + routes.dist);

			detailsModal.find("#fee").text("총 비용 : " + routes.fee);
		}
	})
}
