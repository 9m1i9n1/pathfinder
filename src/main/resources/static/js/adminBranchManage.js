$(document).ready(function() {
	branchlist(0);
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
		default: console.log("안댐");
		}
	}
	url = url + "?searchType=" + $('#searchType').val();
	url = url + "&keyword=" + $('#keyword').val();
	branchsearch(url);
	
});

// 전체보기
function allSearch(){
	branchlist(0);
	$('#seachAll').remove();
}

// 주소검색
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
			$
					.each(
							data,
							function(i, s) {
								str += '<tr>' + '<td>'
										+ data[i].branchIndex
										+ '</td>'
										+ '<td>'
										+ data[i].area
										+ '</td>'
										+ '<td>'
										+ data[i].branchName
										+ '</td>'
										+ '<td>'
										+ data[i].branchOwner
										+ '</td>'
										+ '<td>'
										+ data[i].branchValue
										+ '</td>'
										+ '<td>'
										+ data[i].branchAddr
										+ '</td>'
										+ '<td>'
										+ data[i].branchPhone
										+ '</td>'
										+ "<td>"
										+ `<input type='button' data-toggle='modal' data-target='#updateModal' value='수정' onclick='branchgetvalue(${JSON.stringify(data[i])})' />`
										+ '<button onclick="branchdelete('
										+ data[i].branchIndex
										+ ')">삭제</button></td>'
										+ '</tr>';
							});
			$("#tableListBody").html(str);
			var buttonAll = "";
			buttonAll += '<button id="allSearchB" onclick="allSearch()">전체보기</button>';
			$("#seachAll").html(buttonAll)
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
	$.ajax({
		type : "POST",
		url : "/admin/branchmanage",
		data : insertData,
		contentType : 'application/json',
		success : function(data) {
			branchlist(0);
		}
	});

}

//updateGetValue
function branchgetvalue(data){
	console.log("data")
	console.log(data);
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
	$.ajax({
		type : "PUT",
		url : "/admin/branchmanage/update",
		data : updateData,
		contentType : 'application/json',
		success : function(data) {
			branchlist(0);
		}
	});
}

// delete
function branchdelete(idx) {
	$.ajax({
		type : "DELETE",
		url : "/admin/branchmanage/delete/" + idx,
		data : {},
		success : function(data) {
			branchlist(0);
		}
	});
}

// list
function branchlist(idx) {
	$
			.ajax({
				url : "/admin/branchmanage/branchlist.do?page="
						+ idx,
				data : {},
				success : function(data) {
					var str = "";
					$
							.each(
									data,
									function(i, s) {
										str += '<tr>' + '<td>'
												+ data[i].branchIndex
												+ '</td>'
												+ '<td>'
												+ data[i].area
												+ '</td>'
												+ '<td>'
												+ data[i].branchName
												+ '</td>'
												+ '<td>'
												+ data[i].branchOwner
												+ '</td>'
												+ '<td>'
												+ data[i].branchValue
												+ '</td>'
												+ '<td>'
												+ data[i].branchAddr
												+ '</td>'
												+ '<td>'
												+ data[i].branchPhone
												+ '</td>'
												+ "<td>"
												+ `<input type='button' data-toggle='modal' data-target='#updateModal' value='수정' onclick='branchgetvalue(${JSON.stringify(data[i])})' />`
												+ '<button onclick="branchdelete('
												+ data[i].branchIndex
												+ ')">삭제</button></td>'
												+ '</tr>';
									});
					$("#tableListBody").html(str);
				}
			})
}