// 로딩바 구현
$(document)
  .ready(function() {
    $("#Progress_Loading").hide();
  })
  .ajaxStart(function() {
    $("#Progress_Loading").show();
  })
  .ajaxStop(function() {
    $("#Progress_Loading").hide();
  });

// 첫 시작
$(document).ready(function() {
  // userLoading();
  treeLoading();
});

// 사용자 추가 버튼 클릭
$("#InsertBtn").click(function() {
  var req = $("#userCreateForm").serializeObject();
  userCreate(req);

  alert("새로운 유저를 등록하였습니다.");
});

// insertModal 열릴 시
$("#insertModal").on("shown.bs.modal", function() {
  $("#myInput").trigger("focus");
  areaLoading();
});

// insertModal 닫힐 시
$("#insertModal").on("hidden.bs.modal", function() {
  $("#userCreateForm")[0].reset();
  var str = "<option value='' disabled selected>선택</option>";

  $("#insertModal")
    .find("#areaIndex")
    .html(str)
    .selectpicker("refresh");

  $("#insertModal")
    .find("#branchIndex")
    .html(str)
    .selectpicker("refresh");

  $("#insertModal")
    .find("#userPosition")
    .selectpicker("refresh");
});

// 모달 내에서 지역 선택 시
$("#areaIndex").change(function() {
  var selected = $(this)
    .children("option:selected")
    .val();

  branchLoading(selected);
});

// 페이지 버튼 생성
function pageButton(nodeType, nodeIndex, totalPages, currentPage) {
  $("#page").paging({
    nowPage: currentPage + 1,
    pageNum: totalPages,
    buttonNum: 12,
    callback: function(currentPage) {
      console.log(`${nodeType}:${nodeIndex}`);

      userLoading(`${nodeType}:${nodeIndex}`, currentPage - 1);
    },
  });
}

// 유저 로딩
function userLoading(treeId, selectPage) {
  $.ajax({
    url: "/admin/usermanage/userlist.do",
    type: "get",
    data: { id: treeId, page: selectPage },
    success: function(res) {
      var str = "";
      var count = "";

      count += `<li class="breadcrumb-item">관리자 페이지</a></li>`;
      count += `<li class="breadcrumb-item active">${res.pagination.totalElements}명</li>`;

      $.each(res.data, function(key, value) {
        str += "<tr>";
        str += "<td><input type='checkbox' name='userCheck' value='" + value.userIndex + "' /></td>";
        str += "<td style='display:none;'>" + value.userIndex + "</td>";
        str += "<td>" + value.userName + "</td>";
        str += "<td>" + value.branchName + "</td>";
        str += "<td>" + value.userPosition + "</td>";
        str += "<td>" + value.userId + "</td>";
        str += "<td>" + value.userEmail + "</td>";
        str += "<td>" + value.userPhone + "</td>";
        str += "<td>";
        str += "<input type='button' onclick='userUpdate(" + value.userIndex + ")' value='수정' />";
        str += "<input type='button' onclick='userDelete(" + value.userIndex + ")' value='삭제' />";
        str += "</td>";
        str += "</tr>";
      });

      $("#table")
        .find("#body")
        .html(str);

      $("#headerol").html(count);

      pageButton(res.pagination.nodeType, res.pagination.nodeIndex, res.pagination.totalPages, res.pagination.currentPage);
    },
  });
}

// 모달 내 지점 로딩
function branchLoading(selected) {
  $.ajax({
    url: "/admin/usermanage/branchlist.do",
    type: "get",
    data: { areaIndex: selected },
    success: function(res) {
      var str = "";

      str += "<option value='' disabled selected>선택</option>";

      $.each(res.data, function(key, value) {
        str += "<option value='" + value[0] + "'>";
        str += value[1] + "</option>";
      });

      $("#insertModal")
        .find("#branchIndex")
        .html(str)
        .selectpicker("refresh");
    },
  });
}

//모달 내 지역 로딩
function areaLoading() {
  $.ajax({
    url: "/admin/usermanage/arealist.do",
    type: "get",
    success: function(res) {
      var str = "";

      str += "<option value='' disabled selected>선택</option>";

      $("#insertModal")
        .find("#branchIndex")
        .html(str)
        .selectpicker("refresh");

      $.each(res.data, function(key, value) {
        str += "<option value='" + value[0] + "'>";
        str += value[1] + "</option>";
      });

      $("#insertModal")
        .find("#areaIndex")
        .html(str)
        .selectpicker("refresh");
    },
  });
}

// 폼 내용 Json으로 변경
$.fn.serializeObject = function() {
  var result = {};
  var extend = function(i, element) {
    var node = result[element.name];
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

// 회원 생성
function userCreate(req) {
  $.ajax({
    url: "/admin/usermanage",
    type: "post",
    contentType: "application/json",
    data: req,
    success: function(res) {
      console.log("#res : ");
      console.log(res);

      userLoading(`branch:${res.data.branchIndex}`, 0);
    },
  });
}

// 회원 삭제
function userDelete(userIndex) {
  var result = confirm("회원 정보를 삭제하시겠습니까?");

  if (result) {
    $.ajax({
      url: "/admin/usermanage/" + userIndex,
      type: "delete",
      success: function(res) {
        userLoading();
      },
    });

    alert("해당 회원을 삭제하였습니다.");
  }
}

// 회원 수정
function userUpdate(userIndex) {
  var result = confirm("회원의 비밀번호를 초기화하시겠습니까?");

  if (result) {
    $.ajax({
      url: "/admin/usermanage/" + userIndex,
      type: "put",
      success: function(res) {
        userLoading();
      },
    });

    alert("해당 회원의 패스워드를 초기화하였습니다.");
  }
}

//! JSTREE 부분 ====================

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
      url: "/admin/usermanage/treelist.do",
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

    if (data.node.children.length > 0) {
      $("#jstree")
        .jstree(true)
        .toggle_node(data.node);
    }

    userLoading(id, 0);
  });
}
