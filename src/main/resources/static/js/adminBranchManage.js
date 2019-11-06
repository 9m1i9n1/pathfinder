$(document).ready(function() {
	branchlist();
	treeLoading();
});
// 지점추가버튼
$('[name=branchInsertBtn]').click(function() {
	var formData = $('[name=branchInsertform]').serializeObject()
	let geo = geocoding(formData.branchAddr);
	formData.branchLat = geo.y;
	formData.branchLng = geo.x;
	branchinsert(JSON.stringify(formData));
})
// 지점수정버튼
$('[name=branchUpdateSaveBtn]').click(function() {
	var formData1 = $('[name=branchUpdateForm]').serializeObject()
	branchupdate(JSON.stringify(formData1));
})
// 검색버튼
$('#btnSearch').click(function(e){
	e.preventDefault();
	var url = "";    
	url = url + "?searchType=" + $('#searchType').val();
	url = url + "&keyword=" + $('#keyword').val();
	branchsearch(url);
});
// 전체보기
function allSearch(){
	branchlist();
	$('#seachAll').remove();
}
// 페이징
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
// 검색페이징
function pageButton1(totalPages, currentPage, url) {
	  $("#page").paging({
	    nowPage: currentPage + 1,
	    pageNum: totalPages,
	    buttonNum: 12,
	    callback: function(currentPage) {
	    	branchsearch(url, currentPage - 1);
	      }
	  });
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
// 폼 json변환
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
// 검색뷰
function branchsearch(searchUrl, searchpage=0) {
	$.ajax({
		type : "GET",
		url : "/admin/branchmanage/search" + searchUrl +"&page=" +searchpage ,
		contentType : 'application/json',
		success : function(res) {
			var str = "";
			$.each(res.data,function(key, value) {
				str += '<tr><td>'+ value.branchIndex + '</td>';
				str += '<td>' + value.area +'</td>';
				str += '<td>' + value.branchName +'</td>';
				str += '<td>' + value.branchOwner +'</td>';
				str += '<td>' + value.branchValue +'</td>'
				str += '<td>' + value.branchAddr +'</td>';
				str	+= '<td>' + value.branchPhone + '</td>';
				str += "<td>" + `<input type='button' data-toggle='modal' data-target='#updateModal' value='수정' onclick='branchgetvalue(${JSON.stringify(value)})' />`;
				str += '<button onclick="branchdelete('+ value.branchIndex +' , '+ value.branchName +')">삭제</button></td>'
				str += '</tr>';
				});
			$("#tableListBody").html(str);
			var buttonAll = "";
			buttonAll += '<button id="allSearchB" onclick="allSearch()">전체보기</button>';
			$("#seachAll").html(buttonAll);
			pageButton1(res.pagination.totalPages, res.pagination.currentPage, searchUrl);
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
			ab = r.documents[0].road_address;
		},
		error : function(e) {
		}
	});
	return ab;
}
// 추가
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
// 수정 초기값
function branchgetvalue(data){
	document.getElementById("areaIndex").value = data.areaIndex;;
	document.getElementById("updateAreaIndex").value = data.branchIndex;
	document.getElementById("branchArea1").value = data.area;
	document.getElementById("branchName1").value = data.branchName;
	document.getElementById("branchOwner1").value = data.branchOwner;
	document.getElementById("branchValue1").value = data.branchValue;
	document.getElementById("branchPhone1").value = data.branchPhone;
}
// 수정
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
// 삭제
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
// 첫페이지
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
// jstree 로딩
function treeLoading() {
  $("#jstree").jstree({
    plugins: ["wholerow"],
    core: {
      themes: {
        name: "proton",
        reponsive: true,
      },
      data: function(node, callback) {
        callback(treeData(node.id));
      },
    },
  });

  // jstree 값 받아오기
  function treeData(id) {
    var result = "";

    $.ajax({
      url: "/admin/branchmanage/treelist.do",
      type: "get",
      data: { id: id },
      async: false,
      success: function(res) {
        result = res.data;
      },
    });
    return result;
  }
  $("#jstree").on("select_node.jstree", function(e, data) {
	    var id = data.instance.get_node(data.selected).id;
	    id = id.slice(5)
	    if (data.node.children.length > 0) {
	      $("#jstree")
	        .jstree(true)
	        .toggle_node(data.node);
	    }
	    var url = "";   
	    url = url + "?searchType=area&keyword="+id;
	    branchsearch(url)
	  });
}

