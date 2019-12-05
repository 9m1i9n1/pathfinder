$(document).ready(function() {
	recentlyHistory()
	todayHistory()
});

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