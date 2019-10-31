$(document).ready(function() {
  userLoading();
});

$("#InsertBtn").click(function() {
  var data = $("#userCreateForm").serializeObject();
  $("#userCreateForm")[0].reset();
  userCreate(data);

  alert("새로운 유저를 등록하였습니다.");
});

$("#insertModal").on("shown.bs.modal", function() {
  $("#myInput").trigger("focus");
  branchLoading();
});

function userLoading() {
  $.ajax({
    url: "/admin/usermanage/userlist.do",
    type: "get",
    success: function(data) {
      var str = "";

      $.each(data, function(key, value) {
        str += "<tr>";
        str += "<td>" + value.userIndex + "</td>";
        str += "<td>" + value.userId + "</td>";
        str += "<td>" + value.userName + "</td>";
        str += "<td>" + value.userEmail + "</td>";
        str += "<td>" + value.userPhone + "</td>";
        str += "<td>" + value.branchName + "</td>";
        str += "<td>" + value.userPosition + "</td>";
        str += "<td>";
        str += "<input type='button' onclick='userUpdate(" + value.userIndex + ")' value='초기화' />";
        str += "<input type='button' onclick='userDelete(" + value.userIndex + ")' value='삭제' />";
        str += "</td>";
        str += "</tr>";
      });

      $("#table")
        .find("#body")
        .html(str);
    },
  });
}

function branchLoading() {
  $.ajax({
    url: "/admin/usermanage/branchlist.do",
    type: "get",
    success: function(data) {
      var str = "";

      $.each(data, function(key, value) {
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

function userCreate(req) {
  $.ajax({
    url: "/admin/usermanage",
    type: "post",
    contentType: "application/json",
    data: req,
    success: function(data) {
      userLoading();
    },
  });
}

function userDelete(userIndex) {
  var result = confirm("회원 정보를 삭제하시겠습니까?");

  if (result) {
    $.ajax({
      url: "/admin/usermanage/" + userIndex,
      type: "delete",
      success: function(data) {
        userLoading();
      },
    });

    alert("해당 회원을 삭제하였습니다.");
  }
}

function userUpdate(userIndex) {
  var result = confirm("회원의 비밀번호를 초기화하시겠습니까?");

  if (result) {
    $.ajax({
      url: "/admin/usermanage/" + userIndex,
      type: "put",
      success: function(data) {
        userLoading();
      },
    });

    alert("해당 회원의 패스워드를 초기화하였습니다.");
  }
}
