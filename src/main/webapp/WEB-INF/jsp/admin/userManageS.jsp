<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
  $(document).ready(function() {
    userLoading();
  });

  $("#modal").on("shown.bs.modal", function() {
    $("#myInput").trigger("focus");
  });

  var page = "page=1";

  function userLoading() {
    $.ajax({
      url: "/admin/usermanage.do",
      type: "get",
      success: function(data) {
        console.log("#data : " + data.userList);

        var str = "";

        $.each(data, function(key, value) {
          str += "<tr>";
          str += "<td>" + value.user_index + "</td>";
          str += "<td>" + value.user_id + "</td>";
          str += "<td>" + value.user_name + "</td>";
          str += "<td>" + value.user_email + "</td>";
          str += "<td>" + value.user_phone + "</td>";
          str += "<td>" + value.branch.branch_name + "</td>";
          str += "<td>" + value.user_position + "</td>";
          str += "<td>";
          str += "<input type='button' value='초기화' />";
          str += "<input type='button' onclick='userDelete(" + value.user_index + ")' value='삭제' />";
          str += "</td>";
          str += "</tr>";

          console.log("#value : " + value.user_index);
        });

        $("#table")
          .find("#body")
          .html(str);
      },
    });
  }

  function userInsert(req) {
    $.ajax({
      url: "/admin/usermanage/insert.do",
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
</script>
