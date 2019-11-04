function paging(id, index, totalPage, totalCount) {
  $("#paging").empty();
  var getPerPageNum = 5.0;
  var displayPageNum = 10.0;
  var endPage = Math.ceil((index + 1.0) / displayPageNum) * displayPageNum;
  var startPage = endPage - displayPageNum + 1;

  var tempEndPage = Math.ceil(totalCount / 5.0);

  var nextPage = Math.ceil((index + 1.0) / displayPageNum) * 10 + 1;
  var prevPage = Math.ceil((index + 1.0) / displayPageNum) * 10 - 10;

  if (startPage <= 0) startPage = 1;

  if (endPage > tempEndPage) {
    endPage = tempEndPage;
  }

  var prev = startPage === 1 ? false : true;
  var next = endPage * getPerPageNum >= totalCount ? false : true;

  if (prev) {
    $("#paging").append('<li class="page-item"><a class="page-link" onClick="getUser(\'' + id + "' ," + prevPage + ')">' + "<<" + "&nbsp;</a></li>");
  }

  for (var i = startPage; i <= endPage; i++) {
    if (index + 1 === i) {
      $("#paging").append('<li class="page-item active">' + `<span class="page-link" onClick="getUser(id, i)">` + i + '<span class="sr-only">(current)</span></span>' + "&nbsp;</li>");
    } else {
      $("#paging").append('<li class="page-item"><a class="page-link" onClick="getUser(\'' + id + "' ," + i + ')">' + i + "&nbsp;</a></li>");
    }
  }

  if (next) {
    $("#paging").append('<li class="page-item"><a class="page-link" onClick="getUser(\'' + id + "' ," + nextPage + ')">' + ">>" + "&nbsp;</a></li>");
  }
}

function getUser(id, page) {
  $.ajax({
    url: "/hierarchy/getuser.do",
    type: "GET",
    data: {
      id: id,
      page: page,
    },
    dataType: "json",
    success: function(data) {
      var userData = "<tr>";
      var pageData = "";
      $.each(data.contents, function(i, s) {
        userData +=
          "<td>" +
          data.contents[i].userName +
          "</td>" +
          "<td>" +
          data.contents[i].userPosition +
          "</td>" +
          "<td>" +
          data.contents[i].userEmail +
          "</td>" +
          "<td>" +
          data.contents[i].userPhone +
          "</td>" +
          "</tr>";
      });

      $("#userTable").html(userData);

      paging(id, data.index, data.totalPage, data.totalCount);
    },
    error: function(error) {
      console.log(error);
    },
  });
}

$(function() {
  $("#jstree").jstree({
    plugins: ["wholerow"],
    core: {
      themes: {
        name: "proton",
        reponsive: true,
      },
      data: {
        url: "/hierarchy/gettree.do",
        data: function(node) {
          console.log("#node id : " + node);

          return { id: node.id };
        },
      },
    },
  });

  $("#jstree").on("changed.jstree", function(e, data) {
    var i,
      j,
      r = [];

    for (i = 0, j = data.selected.length; i < j; i++) {
      r.push(data.instance.get_node(data.selected[i]).id);
    }

    getUser(r.join(", "), 0);
  });
});
