$(document).ready(function() {
	recentlyHistory()
	todayHistory()
});

function recentlyHistory(){
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

function todayHistory(){
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