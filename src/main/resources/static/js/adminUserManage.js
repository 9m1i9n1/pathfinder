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

// 페이지 버튼 생성
function pageButton(totalPages, currentPage) {
  $("#page").paging({
    nowPage: currentPage + 1,
    pageNum: totalPages,
    buttonNum: 12,
    callback: function(page) {
      sessionStorage.setItem("page", page - 1);

      userLoading();
    },
  });
}

// 유저 로딩
function userLoading() {
  let treeId = sessionStorage.getItem("treeId");
  let selectPage = sessionStorage.getItem("page");

  $.ajax({
    url: "/admin/usermanage/userlist.do",
    type: "get",
    data: { treeId: treeId, page: selectPage },
    success: function(res) {
      let str = "";
      let count = "";

      count += `<li class="breadcrumb-item">관리자 페이지</a></li>`;
      count += `<li class="breadcrumb-item active">${res.pagination.totalElements}명</li>`;

      $.each(res.data, function(key, value) {
        str += "<tr class='tr-shadow'>";
        str += `<td><label class='au-checkbox'><input type='checkbox' name='userCheck' value=${value.userIndex} /><span class='au-checkmark'></span></label></td>`;
        str += "<td style='display:none;'>" + value.userIndex + "</td>";
        str += "<td>" + value.userName + "</td>";
        str += "<td>" + value.branchName + "</td>";
        str += "<td>" + value.userPosition + "</td>";
        str += "<td class='desc'>" + value.userId + "</td>";
        str += "<td><span class='block-email'>" + value.userEmail + "</span></td>";
        str += "<td>" + value.userPhone + "</td>";
        str += "<td>" + (value.userAuth ? "관리자" : "사용자") + "</td>";
        str += "<td><div class='table-data-feature'>";
        str += `<button class="item" data-toggle="modal" data-target='#modifyModal' data-placement="top" title="Edit" onclick='modalUserLoading(${value.userIndex})' value='수정'><i class="zmdi zmdi-edit"></i></button>`;
        str += `<button class="item" data-toggle="tooltip" data-placement="top" title="Delete" onclick='userDelete(${value.userIndex})' value='삭제'><i class="zmdi zmdi-delete"></i></button>`;
        str += "</div></td>";
        str += "</tr>";
      });

      $("#table")
        .find("#body")
        .html(str);

      $("#headerol").html(count);

      pageButton(res.pagination.totalPages, res.pagination.currentPage);
    },
  });
}

// 회원 생성
function userCreate(req) {
  $.ajax({
    url: "/admin/usermanage",
    type: "post",
    contentType: "application/json",
    data: req,
    success: function(res) {
      userLoading(`branch:${res.data.branchIndex}`, 0);
    },
  });
}

// 회원 삭제
function userDelete(userIndex) {
  let result = confirm("회원 정보를 삭제하시겠습니까?");

  if (result) {
    $.ajax({
      url: "/admin/usermanage/" + userIndex,
      type: "delete",
      success: function() {
        userLoading();
      },
    });

    alert("해당 회원을 삭제하였습니다.");
  }
}

// 회원 수정
function userUpdate(req) {
  $.ajax({
    url: "/admin/usermanage",
    type: "put",
    contentType: "application/json",
    data: req,
    success: function(res) {
      userLoading();
    },
  });
}

// 비밀번호 초기화
function userPwReset(req) {
  let result = confirm("회원의 비밀번호를 초기화하시겠습니까?");

  if (result) {
    $.ajax({
      url: "/admin/usermanage",
      type: "patch",
      contentType: "application/json",
      data: req,
      success: function(res) {
        userLoading();
      },
    });

    alert("해당 회원의 패스워드를 초기화하였습니다.");
  }
}

function modalUserLoading(userIndex) {
  $.ajax({
    url: "/admin/usermanage/userread.do",
    data: { userIndex: userIndex },
    type: "get",
    success: function(res) {
      areaLoading("#modifyModal");

      $("#modifyModal #userIndex").val(res.data.userIndex);
      $("#modifyModal #userId").val(res.data.userId);
      $("#modifyModal #userName").val(res.data.userName);
      $("#modifyModal #userEmail").val(res.data.userEmail);
      $("#modifyModal #userPhone").val(res.data.userPhone);

      $("#modifyModal [name=userAuth][value=" + res.data.userAuth + "]").prop("checked", true);

      $("#modifyModal #areaIndex")
        .val(res.data.areaIndex)
        .selectpicker("refresh");

      branchLoading("#modifyModal", res.data.areaIndex);

      $("#modifyModal #branchIndex")
        .val(res.data.branchIndex)
        .selectpicker("refresh");

      $("#modifyModal #userPosition")
        .val(res.data.userPosition)
        .selectpicker("refresh");
    },
  });
}

//! Modal 관련 =======================

// insertModal 열릴 시
$("#insertModal").on("shown.bs.modal", function() {
  let name = $(this).get(0).id;

  $("#myInput").trigger("focus");
  areaLoading(`#${name}`);
});

// insertModal 닫힐 시
$("#insertModal").on("hidden.bs.modal", function() {
  $("#userCreateForm")[0].reset();

  let name = $(this).get(0).id;
  let str = "<option value='' disabled selected>선택</option>";

  $(`#${name}`)
    .find("#areaIndex")
    .html(str)
    .selectpicker("refresh");

  $(`#${name}`)
    .find("#branchIndex")
    .html(str)
    .selectpicker("refresh");

  $(`#${name}`)
    .find("#userPosition")
    .selectpicker("refresh");
});

// modifyModal 열릴 시
$("#modifyModal").on("shown.bs.modal", function() {
  let name = $(this).get(0).id;

  $("#myInput").trigger("focus");
  // areaLoading(`#${name}`);
});

// 모달 내에서 지역 선택 시
$("#insertModal")
  .find("#areaIndex")
  .change(function() {
    let selected = $(this)
      .children("option:selected")
      .val();

    branchLoading("#insertModal", selected);
  });

$("#modifyModal")
  .find("#areaIndex")
  .change(function() {
    let selected = $(this)
      .children("option:selected")
      .val();

    branchLoading("#modifyModal", selected);
  });

//모달 내 지역 로딩
function areaLoading(name) {
  $.ajax({
    url: "/admin/usermanage/arealist.do",
    type: "get",
    async: false,
    success: function(res) {
      let str = "";

      str += "<option value='' disabled selected>선택</option>";

      $(name)
        .find("#branchIndex")
        .html(str)
        .selectpicker("refresh");

      $.each(res.data, function(key, value) {
        str += "<option value='" + value[0] + "'>";
        str += value[1] + "</option>";
      });

      $(name)
        .find("#areaIndex")
        .html(str)
        .selectpicker("refresh");
    },
  });
}

// 모달 내 지점 로딩
function branchLoading(name, selected) {
  $.ajax({
    url: "/admin/usermanage/branchlist.do",
    type: "get",
    data: { areaIndex: selected },
    async: false,
    success: function(res) {
      let str = "";

      str += "<option value='' disabled selected>선택</option>";

      $.each(res.data, function(key, value) {
        str += "<option value='" + value[0] + "'>";
        str += value[1] + "</option>";
      });

      $(name)
        .find("#branchIndex")
        .html(str)
        .selectpicker("refresh");
    },
  });
}

// 모달 내 등록 버튼 클릭
$("#InsertBtn").click(function() {
  let req = $("#userCreateForm").serializeObject();
  userCreate(req);

  alert("새로운 유저를 등록하였습니다.");
});

// 모달 내 수정 버튼 클릭
$("#ModifyBtn").click(function() {
  let req = $("#userModifyForm").serializeObject();
  userUpdate(req);

  alert("해당 유저 정보를 수정하였습니다.");
});

// 폼 내용 Json으로 변경
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
    let result = "";

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

  $("#jstree")
    .on("changed.jstree", function(e, data) {
      let selectData = data.instance.get_node(data.selected);

      sessionStorage.setItem("treeId", selectData.id);
      sessionStorage.setItem("page", 0);

      if (selectData.children.length > 0) {
        $("#jstree")
          .jstree(true)
          .toggle_node(selectData);
      }

      userLoading();
    })
    .bind("open_node.jstree", function(e, data) {
      let nodesToKeepOpen = [];

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
