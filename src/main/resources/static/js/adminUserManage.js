$(document).ready(function() {
  userLoading();
});

$("[name=InsertBtn]").click(function() {
  userCreate();
});

$("#modal").on("shown.bs.modal", function() {
  $.ajax({
    url: "/admin/usermanage/modalLoding.do",
    type: "get",
    data: req,
    success: function(data) {
      userLoading();
    },
  });

  $("#myInput").trigger("focus");
});

function userLoading() {
  $.ajax({
    url: "/admin/usermanage/list.do",
    type: "get",
    success: function(data) {
      console.log("#data : " + data);

      var str = "";

      $.each(data, function(key, value) {
        str += "<tr>";
        str += "<td>" + value.userIndex + "</td>";
        str += "<td>" + value.userId + "</td>";
        str += "<td>" + value.userName + "</td>";
        str += "<td>" + value.userEmail + "</td>";
        str += "<td>" + value.userPhone + "</td>";
        str += "<td>" + value.branch.branchName + "</td>";
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
      console.log("#data : " + data);

      var str = "";

      $.each(data, function(key, value) {
        str += "<tr>";
        str += "<td>" + value.userIndex + "</td>";
        str += "<td>" + value.userId + "</td>";
        str += "<td>" + value.userName + "</td>";
        str += "<td>" + value.userEmail + "</td>";
        str += "<td>" + value.userPhone + "</td>";
        str += "<td>" + value.branch.branchName + "</td>";
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

function userCreate(req) {
  $.ajax({
    url: "/admin/usermanage/create.do",
    type: "post",
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
