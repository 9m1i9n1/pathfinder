$(document).ready(function() {
	carlist();
	treeLoading();
});
// insertModal 닫힐 시
$("#insertModal").on("hidden.bs.modal", function() { 
  $("#carCreateForm")[0].reset();
// carCreateValid.resetForm();
});

// 검색버튼
$('#btnSearch').click(function(e){
	e.preventDefault();
	var url = "";    
	url = url + "?searchType=" + $('#searchType').val();
	url = url + "&keyword=" + $('#keyword').val();
	carsearch(url);
});


// 지역이름 숫자변환
function areaNameTrans(carArea){
	switch (carArea){
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
	    	carlist(currentPage - 1);
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
	    	carsearch(url, currentPage - 1);
	      }
	  });
	}

//폼 내용 Json으로 변경
$.fn.serializeObject = function() {
  let result = {};
  let extend = function(i, element) {
    let node = result[element.name];
    if ("undefined" !== typeof node && node !== null) {
      if ($.isArray(node)) {
        node.push(element.value);
      } else {
        result[element.name] = [node, element.value];
      }
    } else {
      result[element.name] = element.value;
    }
  };

  $.each(this.serializeArray(), extend);
  return JSON.stringify(result);
};
// 검색뷰
function carsearch(searchUrl, searchpage=0) {
	$.ajax({
		type : "GET",
		url : "/admin/carmanage/search" + searchUrl +"&page=" +searchpage ,
		contentType : 'application/json',
		success : function(res) {
			var str = "";
			var buttonAll = "";
			if (res.resultCode !== "ERROR") {
				$.each(res.data,function(key, value) {
					str += `<tr class="tr-shadow"><td>` + value.carArea +'</td>';
					str += '<td>' + value.carNumber +'</td>';
					str += '<td>' + value.carName +'톤 카고</td>';
					str	+= '<td>' + value.carFuel + '</td>';
					str	+= '<td>' + value.carBuy.year +'.'+value.carBuy.month+'.'+value.carBuy.day+ '</td>';
					str += "<td><div class='table-data-feature'>"
					str += `<button class="item btn btn-primary-outline btn-sm" data-toggle="tooltip" data-placement="top" title="Delete" onclick="cardelete(`+ value.carIndex +`, '` + value.carName+ `', '` + value.area + `')"><i class="fas fa-trash-alt"></i></button>`;
					str += `</td>'+ '</tr>`;
					});
				buttonAll += '<button id="allSearchB" onclick="allSearch()">전체보기</button>';
				pageButton1(res.pagination.totalPages, res.pagination.currentPage, searchUrl);
			} else {
				str += `<tr class="tr-shadow">`;
				str += `<td colspan="8">`;
				str += `${res.description}`;
				str += `</td>`;
				str += `</tr>`;
			}
			
			$("#seachAll").html(buttonAll);
			$("#tableListBody").html(str);
		}
	});
}

// 추가
function carinsert(insertData) {
	let carName = $('[name=carName]').val()
	var result = confirm(carName +" 차량을 추가하시겠습니까?");
	if(result){
	$.ajax({
		type : "POST",
		url : "/admin/carmanage",
		data : insertData,
		contentType : 'application/json',
		success : function(data) {
		carlist();
		},
		error: function(request, status, error) {
		      alert(
		        "code:" +
		          request.status +
		          "\n" +
		          "message:" +
		          request.responseText +
		          "\n" +
		          "error:" +
		          error
		      );
		    }
	});
	alert("해당 차량 정보를 추가하였습니다.");
	}
}

// 삭제
function cardelete(idx, carname, cararea) {
	var result = confirm(carname +" 차량이 맞습니까?");
	if(result){
	$.ajax({
		type : "DELETE",
		url : "/admin/carmanage/delete/" + idx,
		data : {},
		success :
			function() {
			if(!!cararea){
			let Cname =areaNameTrans(cararea)
			 var url = "";
			 url = url + "?searchType=area&keyword="+Cname;
			 carlist();
			}else{
			 carlist();
			}
		}
	});
	alert("해당 차량 정보를 삭제하였습니다.");
	}
}

// 첫페이지
function carlist(selectPage) {
	$.ajax({
		url : "/admin/carmanage/carlist.do?page="+ selectPage,
		type: "get",
		data : {},
		success : function(res) {
			var str = "";
			$.each(res.data,function(key, value) {
				
				str += `<tr class="tr-shadow"><td>` + value.carArea +'</td>';
				str += '<td>' + value.carNumber +'</td>';
				str += '<td>' + value.carName +'톤 카고</td>';
				str	+= '<td>' + value.carFuel + ' km </td>';
				str	+= '<td>' + value.carBuy.year +'.'+value.carBuy.month+'.'+value.carBuy.day+ '</td>';
				str += "<td><div class='table-data-feature'>"
				str += `<button class="item btn btn-primary-outline btn-sm" data-toggle="tooltip" data-placement="top" title="Delete" onclick="cardelete(`+ value.carIndex +`, '` + value.carName + `')"><i class="fas fa-trash-alt"></i></button>`;
				str += `</td>'+ '</tr>`;
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
	    carsearch(url)
	    }else{
	    	carlist()
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
	
	 var $el = $(":focus");
	 $(this).blur();
	 $el.focus();
});

// ! Modal 관련 =======================
// TODO JavaScript 다시 선언시 Const 중복 에러발생
var insertModal = $("#insertModal");

// insertModal 열릴 시
insertModal.on("shown.bs.modal", function() {
  $("#myInput").trigger("focus");
  areaLoading(insertModal);
});

// insertModal 닫힐 시
insertModal.on("hidden.bs.modal", function() {
  $("#carCreateForm")[0].reset();
  insertModal.find(".formCheck").html("");

  let str = "<option value='' disabled selected>선택</option>";

  insertModal
    .find("#carArea")
    .html(str)
    .selectpicker("refresh");

  insertModal.find("#carNumber").selectpicker("refresh");
  insertModal.find("#carName").selectpicker("refresh");
  insertModal.find("#carFuel").selectpicker("refresh");
  insertModal.find("#carBuy").selectpicker("refresh");
  $("#carCreateForm")
    .validate()
    .resetForm();
});

// 모달 내에서 지역 선택 시
insertModal.find("#carArea").change(function() {
  let selected = $(this)
    .children("option:selected")
    .val();

  // branchLoading(insertModal, selected);
});

insertModal.find('#carBuy').click(function(){
	let selected = $(this);
	selected.datepicker({
		changeYear:true,
		changeMonth:true,
		dateFormat:'yy-mm-dd',
		nextText: '다음 달',
        prevText: '이전 달',
		dayNamesMin:['일','월','화','수','목','금','토'],
		monthNamesShort:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
	});
})

// 모달 내 지역 로딩
function arrayToObject(array) {
  return array.reduce(function(result, item) {
    let obj = {};
    obj.id = item[0];
    obj.text = item[1];

    result.push(obj);

    return result;
  }, []);
}

function areaLoading(modal) {
  $.ajax({
    url: "/admin/usermanage/arealist.do",
    type: "get",
    async: false,
    success: function(res) {
    	console.log("@@@@@@@@")
      let areaData = arrayToObject(res.data);

      modal.find("#carArea").html("<option></option>");
      modal.find("#carArea").select2({
        width: "100%",
        placeholder: "지역 선택",
        data: areaData
      });

      selectInit(modal);
    },
    error: function(request, status, error) {
      alert(
        "code:" +
          request.status +
          "\n" +
          "message:" +
          request.responseText +
          "\n" +
          "error:" +
          error
      );
    }
  });
}

const selectInit = modal => {
	  // init
	  modal.find("#carArea").select2({
	    width: "100%",
	    placeholder: "지역 선택"
	  });

	  modal.find("#carName").select2({
	    width: "100%",
	    placeholder: "차종 선택"
	  });
	};

	
	

// ! validation ====================
// select 포커스 문제 해결
$(".selectpicker").on("change", function() {
  $(this).blur();
});

// 모든 폼 valid 적용
$("form").each(function() {
  $(this).validate({
    onkeyup: false,
    ignore: ":hidden, [readonly]",
	rules : {
		carArea: {
			required: true
		},
		
		carName: {
			required: true
		},
		carNumber:{
			required: true,
			rangelength:[7,9],
			pattern:/^([가-힣ㄱ-ㅎㅏ-ㅣ\x20]{2})?\d{2}[가-힣ㄱ-ㅎㅏ-ㅣ\x20]\d{4}$/,
				// 중복체크
			remote:"/admin/carmanage/carcheck.do"
			
		},
		carFuel:{
			required: true

		},
		carBuy:{
			required: true,
			pattern:/^(19|20)\d{2}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])$/
		}
	},
	messages:{
		carArea:{
			required:"지역을 선택하세요."
		},
		
		carName:{
			required:"차종을 입력하세요.",
		},
		carNumber:{
			required:"차량번호를 입력하세요.",
			rangelength:"7 ~ 9자",
			pattern:"형식이 올바르지 않습니다. ex)00가0000 or 서울 00가0000",
			remote:"등록된 차량번호입니다."
		},
		carFuel:{
			required:"연비를 입력하세요."
		},
		carBuy:{
			required:"구매 날짜를 입력하세요.",
			pattern:"형식이 올바르지 않습니다. ex)yyyy-mm-dd"
		},
	},

    // 에러 위치 조정
    errorPlacement: function(error, element) {
      if (element.is(":radio") || element.is("select")) {
        error.appendTo(element.parents(".col-sm-8"));
      } else {
        error.insertAfter(element);
      }
    },

    // valid 실패시
    invalidHandler: function(form, validator) {
      var errors = validator.numberOfInvalids();

      if (errors) {
        alert(validator.errorList[0].message);
        validator.errorList[0].element.focus();
      }
    },

    // valid 성공시
    submitHandler: function(form) {
      var formId = $(form).attr("id");
      var req = $(form).serializeObject();

      switch (formId) {
        case "carCreateForm":{
        	carinsert(req);
        	insertModal.modal("hide");
        	break;
        }
        
        default:{
        	alert("valid 에러");
        	break;
        }
      }

      return false;
    }
  });
});


