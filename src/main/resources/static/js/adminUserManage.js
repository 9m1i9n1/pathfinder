// 첫 시작
$(document).ready(function() {
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
    }
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

      count += `<li class="breadcrumb-item">사용자 관리</a></li>`;
      count += `<li class="breadcrumb-item active">${res.pagination.totalElements}명</li>`;

      $.each(res.data, function(key, value) {
        str += "<tr class='tr-shadow'>";

        str += `<td><label class='au-checkbox'><input type='checkbox' name='userCheck' value=${value.userIndex} /><span class='au-checkmark'></span></label></td>`;
        str += "<td style='display:none;'>" + value.userIndex + "</td>";
        str += "<td>" + value.userName + "</td>";
        str += "<td>" + value.branchName + "</td>";
        str += "<td>" + value.userPosition + "</td>";
        str += "<td class='desc'>" + value.userId + "</td>";
        str +=
          "<td><span class='block-email'>" + value.userEmail + "</span></td>";
        str += "<td>" + value.userPhone + "</td>";
        str += "<td>" + (value.userAuth ? "관리자" : "사용자") + "</td>";

        str += "<td><div class='table-data-feature'>";
        str += `<button class="item btn btn-primary-outline btn-sm" data-toggle="modal" data-target='#modifyModal' data-placement="top" title="Edit" onclick='modalUserLoading(${value.userIndex})' value='수정'><i class="fas fa-user-edit"></i></button>`;
        str += `<button class="item btn btn-primary-outline btn-sm" data-toggle="tooltip" data-placement="top" title="Delete" onclick='userDelete(${value.userIndex})' value='삭제'><i class="fas fa-user-minus"></i></button>`;
        str += "</div></td>";
        str += "</tr>";

        str += "<tr class='spacer'></tr>";
      });

      $("#table #body").html(str);

      $("#headerol").html(count);

      pageButton(res.pagination.totalPages, res.pagination.currentPage);
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

// 회원 생성
function userCreate(req) {
  $.ajax({
    url: "/admin/usermanage",
    type: "post",
    contentType: "application/json",
    async: false,
    data: req,
    success: function(res) {
      if (res.resultCode === "ERROR") {
        insertModal.find("#serverFormCheck").html("잘못된 값 요청");

        for (var key in res.errorList) {
          console.log(key + " : " + res.errorList[key]);
        }
      } else {
        userLoading();
        alert("새로운 유저를 등록하였습니다.");
      }
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

// 회원 삭제
function userDelete(userIndex) {
  let result = confirm("회원 정보를 삭제하시겠습니까?");

  if (result) {
    $.ajax({
      url: "/admin/usermanage",
      type: "delete",
      data: { userIndex: userIndex },
      success: function() {
        userLoading();
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
      if (res.resultCode === "ERROR") {
        modifyModal.find(".formError").html("잘못된 값을 요청하였습니다.");

        for (var key in res.description) {
          console.log(key + " : " + res.description[key]);
        }
      } else {
        userLoading();
        alert("해당 유저 정보를 수정하였습니다.");
      }
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

// 비밀번호 초기화
function userPwReset(userIndex) {
  console.log(userIndex);

  $.ajax({
    url: "/admin/usermanage",
    type: "patch",
    data: { userIndex: userIndex },
    success: function(res) {
      alert("해당 회원의 패스워드를 초기화하였습니다.");
      userLoading();
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

//! Modal 관련 =======================
//TODO JavaScript 다시 선언시 Const 중복 에러발생
var insertModal = $("#insertModal");
var modifyModal = $("#modifyModal");

const selectInit = modal => {
  // init
  modal.find("#branchIndex").select2({
    width: "100%",
    placeholder: "지점 선택"
  });

  modal.find("#userPosition").select2({
    width: "100%",
    placeholder: "직책 선택"
  });
};

// insertModal 열릴 시
insertModal.on("shown.bs.modal", function() {
  $("#myInput").trigger("focus");
  areaLoading(insertModal);
});

// insertModal 닫힐 시
insertModal.on("hidden.bs.modal", function() {
  $("#userCreateForm")[0].reset();
  insertModal.find(".formCheck").html("");

  insertModal.find("#areaIndex").empty();
  insertModal.find("#branchIndex").empty();
  insertModal.find("#userPosition").trigger("change");

  $("#userCreateForm")
    .validate()
    .resetForm();
});

// modifyModal 열릴 시
modifyModal.on("shown.bs.modal", function() {
  $("#myInput").trigger("focus");
});

// modifyModal 닫힐 시
modifyModal.on("hidden.bs.modal", function() {
  $("#userCreateForm")[0].reset();
  modifyModal.find(".formCheck").html("");

  $("#userModifyForm")
    .validate()
    .resetForm();
});

insertModal.find("#areaIndex").on("select2:select", function(e) {
  let selectData = e.params.data;
  branchLoading(insertModal, selectData.id);
});

modifyModal.find("#areaIndex").on("select2:select", function(e) {
  let selectData = e.params.data;
  branchLoading(modifyModal, selectData.id);
});

function arrayToObject(array) {
  return array.reduce(function(result, item) {
    let obj = {};
    obj.id = item[0];
    obj.text = item[1];

    result.push(obj);

    return result;
  }, []);
}

//모달 내 지역 로딩
function areaLoading(modal) {
  $.ajax({
    url: "/admin/usermanage/arealist.do",
    type: "get",
    async: false,
    success: function(res) {
      let areaData = arrayToObject(res.data);

      modal.find("#areaIndex").html("<option></option>");
      modal.find("#areaIndex").select2({
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

// 모달 내 지점 로딩
function branchLoading(modal, selected) {
  $.ajax({
    url: "/admin/usermanage/branchlist.do",
    type: "get",
    data: { areaIndex: selected },
    async: false,
    success: function(res) {
      let branchData = arrayToObject(res.data);

      modal.find("#branchIndex").empty();
      modal.find("#branchIndex").html("<option></option>");
      modal.find("#branchIndex").select2({
        width: "100%",
        placeholder: "지점 선택",
        data: branchData
      });
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

// 모달 내 패스워드 초기화 버튼 클릭
modifyModal.find("#userPw").click(function() {
  let userIndex = $("#userModifyForm #userIndex").val();
  let result = confirm("해당 회원의 비밀번호를 초기화하시겠습니까?");

  if (result) {
    userPwReset(userIndex);
  }
});

// 수정 폼 모달 데이터 로딩
function modalUserLoading(userIndex) {
  $.ajax({
    url: "/admin/usermanage/userread.do",
    data: { userIndex: userIndex },
    type: "get",
    success: function(res) {
      res = res.data;

      modifyModal.find("#userIndex").val(res.userIndex);
      modifyModal.find("#userId").val(res.userId);
      modifyModal.find("#userName").val(res.userName);
      modifyModal.find("#userEmail").val(res.userEmail);
      modifyModal.find("#userPhone").val(res.userPhone);
      modifyModal
        .find("[name=userAuth][value=" + res.userAuth + "]")
        .prop("checked", true);

      areaLoading(modifyModal);
      modifyModal.find("#areaIndex").val(res.areaIndex);
      modifyModal.find("#areaIndex").trigger("change");

      branchLoading(modifyModal, res.areaIndex);
      modifyModal.find("#branchIndex").val(res.branchIndex);
      modifyModal.find("#branchIndex").trigger("change");

      modifyModal.find("#userPosition").val(res.userPosition);
      modifyModal.find("#userPosition").trigger("change");
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
        reponsive: true
      },
      data: function(node, callback) {
        callback(treeData(node.id));
      }
    }
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

//! validation ====================
// select 포커스 문제 해결
$(".selectpicker").on("change", function() {
  $(this).blur();
});

// 모든 폼 valid 적용
$("form").each(function() {
  $(this).validate({
    onkeyup: false,
    ignore: ":hidden, [readonly]",
    rules: {
      userId: {
        required: true,
        rangelength: [3, 15],
        remote: "/admin/usermanage/idcheck.do"
      },
      userName: {
        required: true,
        rangelength: [2, 10]
      },
      userEmail: {
        required: true,
        email: true
      },
      userPhone: {
        required: true,
        pattern: /^\d{3}-\d{4}-\d{4}$/
      },
      areaIndex: {
        required: true
      },
      branchIndex: {
        required: true
      },
      userPosition: {
        required: true
      },
      userAuth: {
        required: true
      }
    },
    messages: {
      userId: {
        required: "아이디를 입력하세요.",
        rangelength: jQuery.validator.format(
          "아이디는 {0}자 이상 {1}자 이하로 입력해주세요."
        ),
        remote: "이미 존재하는 아이디입니다."
      },
      userName: {
        required: "이름을 입력하세요.",
        rangelength: jQuery.validator.format(
          "이름은 {0}자 이상 {1}자 이하로 입력해주세요."
        )
      },
      userEmail: {
        required: "이메일을 입력하세요.",
        email: "이메일 형식이 맞지 않습니다."
      },
      userPhone: {
        required: "연락처를 입력하세요.",
        pattern: "연락처 형식이 맞지 않습니다."
      },
      areaIndex: {
        required: "지역을 선택하세요."
      },
      branchIndex: {
        required: "지점을 선택하세요."
      },
      userPosition: {
        required: "직책을 선택하세요."
      },
      userAuth: {
        required: "권한을 선택하세요."
      }
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
      const formId = $(form).attr("id");
      const req = $(form).serializeObject();

      switch (formId) {
        case "userCreateForm":
          userCreate(req);
          insertModal.modal("hide");
          break;

        case "userModifyForm":
          userUpdate(req);
          modifyModal.modal("hide");
          break;
        default:
          alert("valid 에러");
          break;
      }

      return false;
    }
  });
});
