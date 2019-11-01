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

// 주소검색
function addressFind() {
	new daum.Postcode({
		oncomplete : function(data) {
			var addr = '';
			var extraAddr = '';
			if (data.userSelectedType === 'R') {
				addr = data.roadAddress;
			} else { // 사용자가 지번 주소를 선택했을 경우(J)
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
		url : "http://localhost:8181/admin/branchmanage",
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
		url : "http://localhost:8181/admin/branchmanage/update",
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
		url : "http://localhost:8181/admin/branchmanage/delete/" + idx,
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
				url : "http://localhost:8181/admin/branchmanage/branchlist.do?page="
						+ idx,
				data : {},
				success : function(data) {
					var str = '<tr>' + '<th>번호</th>' + '<th>지점명</th>'
							+ '<th>지점장</th>' + '<th>운반비</th>' + '<th>주소</th>'
							+ '<th>전화번호</th>' + '<th>수정/삭제</th>' + '</tr>';

					$
							.each(
									data,
									function(i, s) {
										str += '<tr>' + '<td>'
												+ data[i].branchIndex
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
					$("#tableTest").html(str);
				}
			})
}