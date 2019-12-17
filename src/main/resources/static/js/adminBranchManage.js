$(document).ready(function() {
	branchlist();
	treeLoading();
});

// insertModal 닫힐 시
$("#insertModal").on("hidden.bs.modal", function() { 
  $("#branchInsertform")[0].reset();
  branchInsertValid.resetForm();
});

// updateModal 닫힐 시
$("#updateModal").on("hidden.bs.modal", function() {
  branchUpdateValid.resetForm();
});


// 검색버튼
$('#btnSearch').click(function(e){
	e.preventDefault();
	var treeId = sessionStorage.getItem("treeId");
	
	var url = "";    
	url = url + "?searchType=" + $('#searchType').val();
	url = url + "&keyword=" + $('#keyword').val();
	url = url + "&selectedArea="+treeId;
	console.log(url)
	branchsearch(url);
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
			$("#branch_Addr").val(addr);
			$("#branch_Addr").blur();
			
			console.log(addr.substr(0,2));
			$("#branch_Area").val(addr.substr(0,2));
			$("#branch_Area").blur();
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
	console.log("여기")
	console.log(searchUrl)
	$.ajax({
		type : "GET",
		url : "/admin/branchmanage/search" + searchUrl +"&page=" +searchpage ,
		contentType : 'application/json',
		success : function(res) {
			var str = "";
			if (res.resultCode !== "ERROR") {
				$.each(res.data,function(key, value) {
					str += `<tr class="tr-shadow"><td>` + value.area +'</td>';
					str += '<td>' + value.branchName +'</td>';
					str += '<td>' + value.branchOwner +'</td>';
					str += '<td>' + value.branchAddr +'</td>';
					str	+= '<td>' + value.branchPhone + '</td>';
					str += '<td>' + (value.branchValue).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+" 원" +'</td>';
					str += "<td><div class='table-data-feature'>"
					str	+= `<button class="item btn btn-primary-outline btn-sm" data-toggle='modal' data-placement="top" title="Edit" data-target='#updateModal' value='수정' onclick='branchgetvalue(${JSON.stringify(value)})' ><i class="fas fa-edit"></i></button>`;
					str += `<button class="item btn btn-primary-outline btn-sm" data-toggle="tooltip" data-placement="top" title="Delete" onclick="branchdelete(`+ value.branchIndex +`, '` + value.branchName + `', '` + value.area + `')"><i class="fas fa-trash-alt"></i></button>`;
					str += `</td>'+ '</tr>`;
					});
			} else {	
					str += `<tr class="tr-shadow">`;
					str += `<td colspan="8">`;
					str += `${res.description}`;
					str += `</td>`;
					str += `</tr>`;
					
				}
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
		beforeSend : function(req) {
			req.setRequestHeader('Authorization', 'KakaoAK bacb8df38d149556e4e1a137db9b8442')
		},
		url : 'https://dapi.kakao.com/v2/local/search/address.json?query='
				+ addr,
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
			console.log(" 테스트")
			console.log(barea);
			if(barea==="제주특별자치도"){
				barea="제주";
			}
			if(barea==="세종특별자치시"){
				barea="세종"
			}
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
			if(barea==="제주특별자치도"){
				barea="제주";
			}
			if(barea==="세종특별자치시"){
				barea="세종"
			}
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
				str += '<td>'+(value.branchValue).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+ " 원"+'</td>';
				str += "<td><div class='table-data-feature'>";
				str += `<button class="item btn btn-primary-outline btn-sm" data-toggle='modal' data-target='#updateModal' data-placement="top" title="Edit" value='수정' onclick='branchgetvalue(${JSON.stringify(value)})' ><i class="fas fa-edit"></i></button>`;
				str += `<button class="item btn btn-primary-outline btn-sm" data-toggle="tooltip" data-placement="top" title="Delete" onclick="branchdelete(`+ value.branchIndex +`, '`+ value.branchName + `')"><i class="fas fa-trash-alt"></i></button></div></td>'+ '</tr>`;
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
	    sessionStorage.setItem("treeId", id);
	    console.log(id,"wlwlwlwl")
	    let vid = id.slice(5)
	    if(vid != "ny:1"){
	    if (data.node.children.length > 0) {
	      $("#jstree")
	        .jstree(true)
	        .toggle_node(data.node);
	    }
	    var url = "";   
	    url = url + "?searchType=area&keyword="+vid+"&selectedArea="+id;
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

$("#branch_Addr").on("propertychange change keyup paste input", function() {
	console.log("change")
	
	 var $el = $(":focus");
	 $(this).blur();
	 $el.focus();
});


// 추가 유효성검사
//TODO JavaScript 다시 선언시 Const 중복 에러발생 
var branchInsertValid = $('#branchInsertform').validate({
	onkeyup:false,
	rules : {
		branchName: {
			required: true,
			rangelength:[3, 15],
			pattern:/^[가-힣a-zA-Z]+$/,
			remote:"/admin/branchmanage/branchcheck.do"
		},
		branchOwner: {
			required: true,
			rangelength:[2, 10],
			pattern:/^[가-힣a-zA-Z]+$/
		},
		branchValue:{
			required: true,
			rangelength:[3, 10]
			
		},
		branchAddr:{
			required: true,

		},
		branchDaddr:{
			required: true
		},
		areaIndex:{
			required: true
		},
		branchPhone:{
			required:true,
			pattern: /^(0(2|3[1-3]|4[1-4]|5[1-5]|6[1-4]))-(\d{3,4})-(\d{4})$/

		}
	},
	messages:{
		branchName:{
			required:"지점명을 입력하세요",
			rangelength: jQuery.validator.format(
			     "지점명을 {0}자 이상 {1}자 이하로 입력해주세요."
				),
			pattern:"형식에 다릅니다.",
			remote: "존재하는 지점명입니다."
		},
		branchOwner:{
			required:"지점장을 입력하세요",
			rangelength: jQuery.validator.format(
				  "지점장을 {0}자 이상 {1}자 이하로 입력해주세요."
			),
			pattern:"형식에 다릅니다."
		},
		branchValue:{
			required:"운반비를 입력하세요",
			rangelength:jQuery.validator.format(
			        "운반비를 {0}자 이상 {1}자 이하로 입력해주세요."
		      ),
		    step:"천 단위로 입력해주세요."
		   
		},
		branchAddr:{
			required: "주소를 입력하세요."
		},
		branchDaddr:{
			required: "상세주소를 입력하세요."
		},
		areaIndex:{
			required: "지역을 입력하세요."
		},
		branchPhone:{
			required: "전화번호를 입력하세요.",
			pattern:"형식이 맞지않습니다 ex)02-123-5678"
				
		}
	},
	invalidHandler: function(form, validator) {
	     console.log("invaild 접속");
	     var errors = validator.numberOfInvalids();
	     if (errors) {
	       alert(validator.errorList[0].message);
	       validator.errorList[0].element.focus();
	     }
	},
	submitHandler: function(form) {
	     event.preventDefault();
	     console.log("인서트 접속");
	 	 var formData = $('[name=branchInsertform]').serializeObject()
	 	 let Barea = formData.areaIndex;
	 	 let geo = geocoding(formData.branchAddr);
	 	 console.log(geo)
	 	 formData.branchLat = geo.y;
	 	 formData.branchLng = geo.x;
	     formData.areaIndex = areaNameTrans(Barea);
	 	 branchinsert(JSON.stringify(formData), Barea)
	 	 $('#insertModal').modal("hide");
	 	 branchInsertValid.resetForm();
	     return false;
	   }
})

// 수정 유효성검사
//TODO JavaScript 다시 선언시 Const 중복 에러발생 
var branchUpdateValid = $('#branchUpdateForm').validate({
	onkeyup:false,
	ignore: ':hidden, [readonly=readonly]',
	rules : { 
		branchName: {
			required: true,
			rangelength:[3, 15],
			pattern:/^[가-힣a-zA-Z]+$/,
			remote:"/admin/branchmanage/branchcheck.do"
		},
		branchOwner: {
			required: true,
			rangelength:[2, 10],
			pattern:/^[가-힣a-zA-Z]+$/
		},
		branchValue:{
			required: true,
			rangelength:[3, 10]
		},
		branchPhone:{
			required:true,
			pattern: /^(0(2|3[1-3]|4[1-4]|5[1-5]|6[1-4]))-(\d{3,4})-(\d{4})$/
		}
	},
	messages:{
		branchName:{
			required:"지점명을 입력하세요",
			rangelength: jQuery.validator.format(
			     "지점명을 {0}자 이상 {1}자 이하로 입력해주세요."
				),
			pattern:"형식에 다릅니다.",
			remote: "존재하는 지점명입니다."
		},
		branchOwner:{
			required:"지점장을 입력하세요",
			rangelength: jQuery.validator.format(
				  "지점장을 {0}자 이상 {1}자 이하로 입력해주세요."
			),
			pattern:"형식에 다릅니다."
		},
		branchValue:{
			required:"운반비를 입력하세요",
			rangelength:jQuery.validator.format(
			        "운반비를 {0}자 이상 {1}자 이하로 입력해주세요."
		      ),
		    step:"천 단위로 입력해주세요."
		},
		branchPhone:{
			required: "전화번호를 입역하세요.",
			pattern:"형식이 맞지않습니다 ex)02-123-5678"
				
		}
	},
	invalidHandler: function(form, validator) {
	     console.log("invaild 접속");
	     var errors = validator.numberOfInvalids();
	     if (errors) {
	       alert(validator.errorList[0].message);
	       validator.errorList[0].element.focus();
	     }
	},
	submitHandler: function(form) {
	     event.preventDefault();
	     console.log("인서트 접속");
	 	 var formData1 = $('[name=branchUpdateForm]').serializeObject();
		 console.log(formData1);
	 	 
	 	 let Barea =formData1.branchArea;
		 branchupdate(JSON.stringify(formData1), Barea);
	 	 $('#updateModal').modal("hide");
	 	 branchUpdateValid.resetForm();
	     return false;
	   }
})
