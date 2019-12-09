$(document).ready(function() {
	recentlyHistory()
	todayHistory()
	userCount()
	branchCount()
	historyTotalCount()
	todayHistoryPercent()
});

function recentlyHistory() {
	$.ajax({
		url : "/home/recentlyHistory",
		type : "get",
		data : {
			page : 0
		},
		success : function(res) {
			console.log("good")
			var str = "";

			$.each(res.data, function(key, value) {
				str += `<tr class="tr-shadow">`;
				str += "<td>" + value.dlvrdate + "</td>";
				str += "<td>" + value.arrivedate + "</td>";
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
		data : {
			page : 0
		},
		success : function(res) {
			console.log("good")
			var str = "";

			$.each(res.data, function(key, value) {
				str += `<tr class="tr-shadow">`;
				str += "<td>" + value.dlvrdate + "</td>";
				str += "<td>" + value.arrivedate + "</td>";
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
