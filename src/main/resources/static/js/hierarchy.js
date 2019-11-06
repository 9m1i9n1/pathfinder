$(document).ready(function() {
  treeLoading();
});

function pageButton(nodeType, nodeIndex, totalPages, currentPage) {
  $("#page").paging({
    nowPage: currentPage + 1,
    pageNum: totalPages,
    buttonNum: 12,
    callback: function(currentPage) {
      getUser(`${nodeType}:${nodeIndex}`, currentPage - 1);
    },
  });
}

function getUser(treeId, selectPage) {
  $.ajax({
    url: "/hierarchy/userlist.do",
    type: "get",
    data: { id: treeId, page: selectPage },
    success: function(res) {
      var str = "";
      var count = "";

      count += `<li class="breadcrumb-item">조직도 패이지 /&nbsp</a></li>`;
      count += `<li class="breadcrumb-list">${res.pagination.totalElements}명</li>`;

      $.each(res.data, function(key, value) {
        str += "<tr>";
        str += "<td>" + value.userName + "</td>";
        str += "<td>" + value.userEmail + "</td>";
        str += "<td>" + value.userPhone + "</td>";
        str += "<td>" + value.branchName + "</td>";
        str += "<td>" + value.userPosition + "</td>";
        str += "</tr>";
      });

      $("#userTable").html(str);

      $("#headInfo").html(count);

      pageButton(res.pagination.nodeType, res.pagination.nodeIndex, res.pagination.totalPages, res.pagination.currentPage);
    },
  });
}

function treeLoading() {
  $("#jstree")
    .jstree({
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
    })
    .bind("changed.jstree", function(e, data) {
      var data = data.instance.get_node(data.selected);

      if (data.children.length > 0) {
        $("#jstree")
          .jstree(true)
          .toggle_node(data);
      }

      getUser(data.id, 0);
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

  function treeData(id) {
    var result = "";

    $.ajax({
      url: "/hierarchy/treelist.do",
      type: "get",
      data: { id },
      async: false,
      success: function(res) {
        result = res.data;
      },
    });

    return result;
  }
}
