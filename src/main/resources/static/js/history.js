$(document).ready(function() {
  getHistory(0);
});


function pageButton(totalPages, currentPage, type) {
	  $("#page").paging({
	    nowPage: currentPage + 1,
	    pageNum: totalPages,
	    buttonNum: 12,
	    callback: function(currentPage) {
	      if (type === "history") getHistory(currentPage - 1);
	    }
	  });
	}


function getHistory(selectPage) {
	$.ajax({
		url: "/history/gethistory.do",
		type: "get",
		data:{page : selectPage},
		
		success: function(res) {
			let str = "";
			
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
			
		      pageButton(
		    	        res.pagination.totalPages,
		    	        res.pagination.currentPage,
		    	        "history"
		    	      );
		}
	})
}

// Modal
var detailsModal = $("#detailsModal");

function getRoutes(routes) {
	$.ajax({
		url: "/history/getroutes.do",
		type: "get",
		data: {routesIndex : routes.routes},
		success: function(res) {
			let str = "";
			let count = 0;
			let totalTime = 0;
			$.each(res.data.detail, function(key, value) {
			
				str += `<tr class="tr-shadow" id="ModalTr">`;
				str += "<td>" + ++count + "</td>";
				str += "<td>" + value.rdep + "</td>";
				str += "<td>" + value.rarvl + "</td>";
				str += "<td>" + value.rdist + "</td>";
				str += "<td>" + value.rtime + "</td>";
				str += "<td>" + value.rfee + "</td>";
				str += "</tr>";
				
				totalTime += parseFloat(value.rtime);
				console.log(parseFloat(totalTime))
			});
			
			if (userAuth === "[ROLE_ADMIN]"){
				$("#deleteBtn").show();
			} else if(userName === routes.username){
				$("#deleteBtn").show();
			} else {
				$("#deleteBtn").hide();
			}
			
			$("#routesListBody").html(str);
			console.log(routes)
			detailsModal
			.find("#index")
			.text('총 소요시간 '+routes.index);
			
			detailsModal
			.find("#totalTime")
			.text('총 소요시간 : '+Number(totalTime).toFixed(1));
			
			detailsModal
			.find("#regdate")
			.text(routes.regdate);
			
			detailsModal
			.find("#username")
			.text(routes.username);
			
			detailsModal
			.find("#carname")
			.text(routes.carname);
			
			detailsModal
			.find("#dep")
			.text(routes.dep );
			
			detailsModal
			.find("#arvl")
			.text(routes.arvl);
			
			detailsModal
			.find("#dist")
			.text("총 거리 : " + routes.dist +" km");
			
			detailsModal
			.find("#fee")
			.text("전체 비용 : " + routes.fee+" 원");
		}
	})
}