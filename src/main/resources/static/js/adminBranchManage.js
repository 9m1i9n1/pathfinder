$(document).ready(function() {
	branchlist();
});
// 지점추가버튼
$('[name=branchInsertBtn]').click(function() {
	var formData = $('[name=branchInsertform]').serializeObject()
	console.log(formData)
	let geo = geocoding(formData.branchAddr);
	formData.branchLat = geo.y;
	formData.branchLng = geo.x;
	branchinsert(JSON.stringify(formData));
})
// 지점수정버튼
$('[name=branchUpdateSaveBtn]').click(function() {
	var formData1 = $('[name=branchUpdateForm]').serializeObject()

	console.log(formData1)
	console.log(JSON.stringify(formData1))
	branchupdate(JSON.stringify(formData1));
})
// 검색버튼
$('#btnSearch').click(function(e){
	e.preventDefault();
	var url = "/admin/branchmanage/search";    
	if($('#searchType').val() == "areaName"){
		switch($('#keyword').val()){
		case "경기도" : $('#keyword').val("1"); break;
		case "강원도" : $('#keyword').val("2"); break;
		case "충청남도" : $('#keyword').val("3"); break;
		case "충청북도" : $('#keyword').val("4"); break;
		case "경상북도" : $('#keyword').val("5"); break;
		case "경상남도" : $('#keyword').val("6"); break;
		case "전라남도" : $('#keyword').val("7"); break;
		case "전라북도" : $('#keyword').val("8"); break;
		}
	}
	url = url + "?searchType=" + $('#searchType').val();
	url = url + "&keyword=" + $('#keyword').val();
	branchsearch(url);
});
//전체보기
function allSearch(){
	branchlist();
	$('#seachAll').remove();
}
//페이징
function pageButton(totalPages, currentPage) {
	  $("#page").paging({
	    nowPage: currentPage + 1,
	    pageNum: totalPages,
	    buttonNum: 12,
	    callback: function(currentPage) {
	    	branchlist(currentPage - 1);
	      }
	  });
	}
//주소검색
function addressFind() {
	new daum.Postcode({
		oncomplete : function(data) {
			var addr = '';
			var extraAddr = '';
			if (data.userSelectedType === 'R') {
				addr = data.roadAddress;
			} else { 
				addr = data.jibunAddress;
			}
			document.getElementById("branch_address").value = addr;
			document.getElementById("branch_detailAddress").focus();
		}
	}).open();
}
// form => json
$.fn.serializeObject = function() {
	var result = {}
	var extend = function(i, element) {
		var node = result[element.name]
		if ("undefined" !== typeof node && node !== null) {
			if ($.isArray(node)) {
				node.push(element.value)
			} else {
				result[element.name] = [ node, element.value ]
			}
		} else {
			result[element.name] = element.value
		}
	}
	$.each(this.serializeArray(), extend)
	return result
}
//search
function branchsearch(searchUrl) {
	$.ajax({
		type : "GET",
		url : searchUrl,
		contentType : 'application/json',
		success : function(data) {
			var str = "";
			$.each(data,function(i, s) {
				str += '<tr><td>'+ data[i].branchIndex + '</td>';
				str += '<td>' + data[i].area +'</td>';
				str += '<td>' + data[i].branchName +'</td>';
				str += '<td>' + data[i].branchOwner +'</td>';
				str += '<td>' + data[i].branchValue +'</td>'
				str += '<td>' + data[i].branchAddr +'</td>';
				str	+= '<td>' + data[i].branchPhone + '</td>';
				str += "<td>" + `<input type='button' data-toggle='modal' data-target='#updateModal' value='수정' onclick='branchgetvalue(${JSON.stringify(data[i])})' />`;
				str += '<button onclick="branchdelete('+ data[i].branchIndex +' , '+ data[i].branchName +')">삭제</button></td>'
				str += '</tr>';
				});
			$("#tableListBody").html(str);
			var buttonAll = "";
			buttonAll += '<button id="allSearchB" onclick="allSearch()">전체보기</button>';
			$("#seachAll").html(buttonAll);
			pageButton(res.pagination.totalPages, res.pagination.currentPage);

		}
	});

}
// geoCoding
function geocoding(addr) {
	let ab;
	$.ajax({
		url : 'https://dapi.kakao.com/v2/local/search/address.json?query='
				+ addr,
		headers : {
			'Authorization' : 'KakaoAK dab56d279c7065ab0223c12e94ad64ea'
		},
		type : 'GET',
		async : false,
		success : function(r) {
			console.log("gecoding123");
			console.log(r.documents[0].road_address);
			ab = r.documents[0].road_address;
		},
		error : function(e) {
			console.log(e);
		}
	});
	return ab;
}
// insert
function branchinsert(insertData) {
	let branchName = $('[name=branchName]').val()
	var result = confirm(branchName +" 지점을 저장하겠습니까?");
	if(result){
	$.ajax({
		type : "POST",
		url : "/admin/branchmanage",
		data : insertData,
		contentType : 'application/json',
		success : function(data) {
			branchlist();
		}
	});
	alert("해당 지점 정보를 추가하였습니다.");
	}
}
//updateGetValue
function branchgetvalue(data){
	document.getElementById("areaIndex").value = data.areaIndex;;
	document.getElementById("updateAreaIndex").value = data.branchIndex;
	document.getElementById("branchArea1").value = data.area;
	document.getElementById("branchName1").value = data.branchName;
	document.getElementById("branchOwner1").value = data.branchOwner;
	document.getElementById("branchValue1").value = data.branchValue;
	document.getElementById("branchPhone1").value = data.branchPhone;
}
// update
function branchupdate(updateData) {
	var result = confirm("지점을 수정 하시겠습니까?");
	if(result){
	$.ajax({
		type : "PUT",
		url : "/admin/branchmanage/update",
		data : updateData,
		contentType : 'application/json',
		success : function(data) {
			branchlist();
		}
	});
	alert("해당 지점 정보를 수정하였습니다.");
	}
}
// delete
function branchdelete(idx, bname) {
	var result = confirm(bname +" 지점을 삭제하시겠습니까?");
	if(result){
	$.ajax({
		type : "DELETE",
		url : "/admin/branchmanage/delete/" + idx,
		data : {},
		success : function(data) {
			branchlist();
		}
	});
	alert("해당 지점 정보를 삭제하였습니다.");
	}
}
// list
function branchlist(selectPage) {
	$.ajax({
		url : "/admin/branchmanage/branchlist.do?page="+ selectPage,
		type: "get",
		data : {},
		success : function(res) {
				var str = "";
			$.each(res.data, function(key, value) {
				str += '<tr><td>'+ value.branchIndex+ '</td>';
				str += '<td>'+ value.area+ '</td>';
				str += '<td>'+ value.branchName+ '</td>';
				str += '<td>'+ value.branchOwner+ '</td>';
				str += '<td>'+ value.branchValue+ '</td>';
				str += '<td>'+ value.branchAddr+ '</td>';
				str += '<td>'+ value.branchPhone+ '</td>';
				str += "<td>"+ `<input type='button' data-toggle='modal' data-target='#updateModal' value='수정' onclick='branchgetvalue(${JSON.stringify(value)})' />`
				+ '<button onclick="branchdelete('+ value.branchIndex +`, '`+ value.branchName + `')">삭제</button></td>'+ '</tr>`;
				
			});
			$("#tableListBody").html(str);
			pageButton(res.pagination.totalPages, res.pagination.currentPage);
		}
	})
}