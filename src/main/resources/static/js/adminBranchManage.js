$(document).ready(function() {
	branchlist();
	treeLoading();
});
// 지점추가버튼
$('[name=branchInsertBtn]').click(function() {
	var formData = $('[name=branchInsertform]').serializeObject()
	let exitModal =document.getElementById('branchInsertBtn');
	if(branchInsertValid()===false){
		return false;
	}else{
		let Barea = formData.areaIndex;
		let geo = geocoding(formData.branchAddr);
		formData.branchLat = geo.y;
		formData.branchLng = geo.x;
		formData.areaIndex = areaNameTrans(Barea);
		branchinsert(JSON.stringify(formData), Barea)
		exitModal.setAttribute("data-dismiss","modal")
		};
})
// 지점수정버튼
$('[name=branchUpdateSaveBtn]').click(function() {
	var formData1 = $('[name=branchUpdateForm]').serializeObject();
	let Barea =formData1.branchArea;
	let exitModal1 = document.getElementById('branchUpdateBtn');
	if(branchUpdateValid()===false){
		return false;
	}else{
		branchupdate(JSON.stringify(formData1), Barea);
		exitModal1.setAttribute("data-dismiss","modal")
	}
})
// 검색버튼
$('#btnSearch').click(function(e){
	e.preventDefault();
	var url = "";    
	url = url + "?searchType=" + $('#searchType').val();
	url = url + "&keyword=" + $('#keyword').val();
	branchsearch(url);
});

// 추가 유효성검사 지점명
$('[name=branchName]').on('blur',function(){
	var NameForm =  /^[가-힣a-zA-Z]+$/;
	document.getElementById('branchNameVaild').innerHTML ="";
	if(NameForm.test($('[name=branchName]').val())===false){
		document.getElementById('branchNameVaild').innerHTML ="지점명 형식을 맞춰주세요."
	}
});

//추가 유효성검사 지점장
$('[name=branchOwner]').on('blur',function(){
	var OwnerForm =  /^[가-힣a-zA-Z]+$/;
	document.getElementById('branchOwnerVaild').innerHTML ="";
	if(OwnerForm.test($('[name=branchOwner]').val())===false){
		document.getElementById('branchOwnerVaild').innerHTML ="지점장 형식을 맞춰주세요."
	}
});

//추가 유효성검사 운반비
$('[name=branchValue]').on('blur',function(){
	var ValueForm = /^[0-9]{4,8}$/;
	document.getElementById('branchValueVaild').innerHTML ="";
	if(ValueForm.test($('[name=branchValue]').val())===false){
		document.getElementById('branchValueVaild').innerHTML ="운반비 4~8자리 사이로 입력하세요."
	}
});

//추가 유효성검사 주소
$('[name=branchAddr]').on('blur',function(){
	document.getElementById('branchAddrVaild').innerHTML ="";
	if($('[name=branchAddr]').val()==""){
		document.getElementById('branchAddrVaild').innerHTML ="주소를 입력하지 않았습니다."
	}
});

//추가 유효성검사 상세주소
$('[name=branchDaddr]').on('blur',function(){
	document.getElementById('branchDaddrVaild').innerHTML ="";
	if($('[name=branchDaddr]').val()==""){
		document.getElementById('branchDaddrVaild').innerHTML ="주소를 입력하지 않았습니다."
	}
});

//추가 유효성검사 전화번호
$('[name=branchPhone]').on('blur',function(){
	var PhoneForm = /^\d{3}-\d{4}-\d{4}$/;
	document.getElementById('branchPhoneVaild').innerHTML ="";
	if(PhoneForm.test($('[name=branchPhone]').val())===false){
		document.getElementById('branchPhoneVaild').innerHTML ="전화번호 형식을 맞춰주세요."
	}
});


// 지역이름 숫자변환
function areaNameTrans(areaIndex){
	switch (areaIndex){
case "서울" : return 1; case "부산" : return 2;	case "대구" : return 3;case "인천" : return 4;
case "광주" : return 5; case "대전" : return 6;	case "울산" : return 7;case "경기" : return 8;
case "강원" : return 9; case "충북" : return 10; case "충남" : return 11;case "전북" : return 12;
case "전남" : return 13; case "경북" : return 14; case "경남" : return 15;case "제주" : return 16;	case "세종" : return 17;} 
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
			console.log(addr.substr(0,2))
			document.getElementById("branch_Area").value = addr.substr(0,2);
			document.getElementById('branchAddrVaild').innerHTML ="";
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
// 지점수정 유효성검사
function branchUpdateValid(){
	var bName = document.branchUpdateForm.branchName1;
	var bOwner = document.branchUpdateForm.branchOwner1;
	var bValue = document.branchUpdateForm.branchValue1;
	var bPhone = document.branchUpdateForm.branchPhone1;
	
	document.getElementById('branchNameVaild1').innerHTML ="";
	document.getElementById('branchOwnerVaild1').innerHTML ="";
	document.getElementById('branchValueVaild1').innerHTML ="";
	document.getElementById('branchPhoneVaild1').innerHTML ="";
	
	var NameForm =  /^[가-힣a-zA-Z]+$/;
	var OwnerForm =  /^[가-힣a-zA-Z]+$/;
	var ValueForm = /^[0-9]{4,8}$/;
	var PhoneForm = /^\d{3}-\d{4}-\d{4}$/;
	var errorValue= true;

	// 지점명
	if (NameForm.test(bName.value)===false) {
        document.getElementById('branchNameVaild1').innerHTML ="지점명 형식을 맞춰주세요."
        bName.focus()
        bName.select()
        errorValue = false;
    }
	
	// 지점장
	if (OwnerForm.test(bOwner.value)===false) {
		document.getElementById('branchOwnerVaild1').innerHTML ="지점장 형식을 맞춰주세요. "
        bOwner.focus()
        bOwner.select()
        errorValue = false;
    }
	
	// 운반비
	if (ValueForm.test(bValue.value)===false) {
		document.getElementById('branchValueVaild1').innerHTML ="운반비 4~8자리가지 입력가능합니다."
        bValue.focus()
        bValue.select()
        errorValue = false;
    }
    // 폰번호
    if (PhoneForm.test(bPhone.value)===false) {
		 document.getElementById('branchPhoneVaild1').innerHTML ="전화번호 형식을 맞춰주세요."
        bPhone.focus()
        bPhone.select()
        errorValue = false;
    }
    return errorValue;
}

// 지점추가 유효성검사
function branchInsertValid(){
	var bName = document.branchInsertform.branchName;
	var bOwner = document.branchInsertform.branchOwner;
	var bValue = document.branchInsertform.branchValue;
	var bAddr = document.branchInsertform.branch_address;
	var bDaddr = document.branchInsertform.branch_detailAddress;
	var bArea = document.branchInsertform.branch_Area;
	var bPhone = document.branchInsertform.branchPhone;
	
	document.getElementById('branchNameVaild').innerHTML ="";
	document.getElementById('branchOwnerVaild').innerHTML ="";
	document.getElementById('branchValueVaild').innerHTML ="";
	document.getElementById('branchAddrVaild').innerHTML ="";
	document.getElementById('branchDaddrVaild').innerHTML ="";
	document.getElementById('branchAreaVaild').innerHTML ="";
	document.getElementById('branchPhoneVaild').innerHTML ="";
	
	var NameForm =  /^[가-힣a-zA-Z]+$/;
	var OwnerForm =  /^[가-힣a-zA-Z]+$/;
	var ValueForm = /^[0-9]{4,8}$/;
	var PhoneForm = /^\d{3}-\d{4}-\d{4}$/;
	var errorValue= true;
	
	// 지점명
	if (NameForm.test(bName.value)===false) {
        document.getElementById('branchNameVaild').innerHTML ="지점명 형식을 맞춰주세요."
        bName.focus()
        bName.select()
        errorValue = false;
    }
	
	// 지점장
	if (OwnerForm.test(bOwner.value)===false) {
		document.getElementById('branchOwnerVaild').innerHTML ="지점장 형식을 맞춰주세요. "
        bOwner.focus()
        bOwner.select()
        errorValue = false;
    }
	
	// 운반비
	if (ValueForm.test(bValue.value)===false) {
		document.getElementById('branchValueVaild').innerHTML ="운반비 4~8자리가지 입력가능합니다."
        bValue.focus()
        bValue.select()
        errorValue = false;
    }
	
	// 상세주소
	if (!!bAddr.value == false) {
		 document.getElementById('branchAddrVaild').innerHTML ="주소를 입력하지 않았습니다."
         bAddr.focus()
         errorValue = false;
     }
	
	// 상세주소
	if (!!bDaddr.value == false) {
		 document.getElementById('branchDaddrVaild').innerHTML ="상세주소를 입력하지 않았습니다."
         bDaddr.focus()
         errorValue = false;
     }
	
	
    // 폰번호
    if (PhoneForm.test(bPhone.value)===false) {
		 document.getElementById('branchPhoneVaild').innerHTML ="전화번호 형식을 맞춰주세요."
        bPhone.focus()
        bPhone.select()
        errorValue = false;
    }
    return errorValue;
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
				str += `<tr class="tr-shadow"><td>` + value.area +'</td>';
				str += '<td>' + value.branchName +'</td>';
				str += '<td>' + value.branchOwner +'</td>';
				str += '<td>' + value.branchAddr +'</td>';
				str	+= '<td>' + value.branchPhone + '</td>';
				str += '<td>' + value.branchValue+" 원" +'</td>';
				str += "<td><div class='table-data-feature'>"
				str	+= `<button class="item" data-toggle='modal' data-placement="top" title="Edit" data-target='#updateModal' value='수정' onclick='branchgetvalue(${JSON.stringify(value)})' ><i class="zmdi zmdi-edit"></i><button>`;
				str += `<button class="item" data-toggle="tooltip" data-placement="top" title="Delete" onclick="branchdelete(`+ value.branchIndex +`, '` + value.branchName + `', '` + value.area + `')"><i class="zmdi zmdi-delete"></i></button>`;
				str += `</td>'+ '</tr>`;
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
			'Authorization' : 'KakaoAK bacb8df38d149556e4e1a137db9b8442'
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
function branchinsert(insertData, barea) {
	let branchName = $('[name=branchName]').val()
	var result = confirm(branchName +" 지점을 저장하겠습니까?");
	if(result){
	$.ajax({
		type : "POST",
		url : "/admin/branchmanage",
		data : insertData,
		contentType : 'application/json',
		success : function(data) {
			if(!!barea){
				let Bname =areaNameTrans(barea);
				console.log(Bname);
				 var url = "";   
				 url = url + "?searchType=area&keyword="+Bname;
				 branchsearch(url);
				}else{
				 branchlist();
				}
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
function branchupdate(updateData, barea) {
	var result = confirm("지점을 수정 하시겠습니까?");
	if(result){
	$.ajax({
		type : "PUT",
		url : "/admin/branchmanage/update",
		data : updateData,
		contentType : 'application/json',
		success : function() {
			if(!!barea){
				let Bname =areaNameTrans(barea);
				console.log(Bname);
				 var url = "";   
				 url = url + "?searchType=area&keyword="+Bname;
				 branchsearch(url);
				}else{
				 branchlist();
				}
		}
	});
	alert("해당 지점 정보를 수정하였습니다.");
	}
}
// 삭제
function branchdelete(idx, bname, barea) {
	var result = confirm(bname +" 지점을 삭제하시겠습니까?");
	if(result){
	$.ajax({
		type : "DELETE",
		url : "/admin/branchmanage/delete/" + idx,
		data : {},
		success :
			function() {
			if(!!barea){
			let Bname =areaNameTrans(barea);
			console.log(Bname);
			 var url = "";   
			 url = url + "?searchType=area&keyword="+Bname;
			 branchsearch(url);
			}else{
			 branchlist();
			}
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
				str += `<tr class="tr-shadow"><td>`+ value.area+ '</td>';
				str += '<td>'+ value.branchName+ '</td>';
				str += '<td>'+ value.branchOwner+ '</td>';
				str += '<td>'+ value.branchAddr+ '</td>';
				str += '<td>'+ value.branchPhone+ '</td>';
				str += '<td>'+ value.branchValue+ " 원"+'</td>';
				str += "<td><div class='table-data-feature'>";
				str += `<button class="item" data-toggle='modal' data-target='#updateModal' data-placement="top" title="Edit" value='수정' onclick='branchgetvalue(${JSON.stringify(value)})' ><i class="zmdi zmdi-edit"></i></button>`;
				str += `<button class="item" data-toggle="tooltip" data-placement="top" title="Delete" onclick="branchdelete(`+ value.branchIndex +`, '`+ value.branchName + `')"><i class="zmdi zmdi-delete"></button></div></td>'+ '</tr>`;
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
	    let vid = id.slice(5)
	    if(vid != "ny:1"){
	    if (data.node.children.length > 0) {
	      $("#jstree")
	        .jstree(true)
	        .toggle_node(data.node);
	    }
	    var url = "";   
	    url = url + "?searchType=area&keyword="+vid;
	    branchsearch(url)
	    }else{
	    	branchlist()
	    }
	  })
	  .bind("open_node.jstree", function(e, data) {
	      var nodesToKeepOpen = [];
	     
	      nodesToKeepOpen.push(data.node.id);
	      nodesToKeepOpen.push(data.node.parent);

	      $(".jstree-node").each(function() {
	        if (nodesToKeepOpen.indexOf(this.id) === -1) {
	          $("#jstree")
	            .jstree()
	            .close_node(this.id);
	        }
	      });
	    });
}

