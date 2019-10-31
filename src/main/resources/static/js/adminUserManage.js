$(document).ready(function() {
  userLoading();
});

$("#InsertBtn").click(function() {
  var data = $("#userCreateForm").serializeObject();
  console.log("#create form : ");
  console.log(data);

  userCreate(data);
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
        str += "<input type='button' value='초기화' />";
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
        str += "<option value='" + key + "'>";
        str += value + "</option>";
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
  $.ajax({
    url: "/admin/usermanage/delete/" + userIndex,
    type: "delete",
    success: function(data) {
      userLoading();
    },
  });
}
