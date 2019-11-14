$(document).ready(function() {
  treeLoading();
});

function pageButton(nodeType, nodeIndex, totalPages, currentPage, type) {
  $("#page").paging({
    nowPage: currentPage + 1,
    pageNum: totalPages,
    buttonNum: 12,
    callback: function(currentPage) {
    	if (type === "list")
    		getUser(`${nodeType}:${nodeIndex}`, currentPage - 1);
    	else 
    		getSearch(`${nodeType}:${nodeIndex}`, currentPage - 1);
    },
  });
}

function userSearch(treeId, selectPage) {
	$("#searchButton").unbind().bind('click', function (e) {		
		getSearch(treeId, selectPage);
	});
}

function getSearch(treeId, selectPage) {
	let type = $("select#searchType").val();
	let value = $("#searchInput").val();
	
	$.ajax({
		url : "/hierarchy/userlist.do",
		type : "get",
		data : { 
					id : treeId,
					page : selectPage,
					searchType : type,
					searchValue : value
				},
	    beforeSend: function(req) {
	    	req.setRequestHeader("Authorization", "pathfinder " + document.cookie.substring(6));
	    },
		success: function(res) {
	      let str = "";
	      let count = "";

	      count += `<li class="breadcrumb-item">조직도 패이지 /&nbsp</a></li>`;
	      count += `<li class="breadcrumb-list">${res.pagination.totalElements}명</li>`;

	      $.each(res.data, function(key, value) {
	    	str += `<tr class="tr-shadow">`;
	        str += "<td>" + value.userName + "</td>";
	        str += "<td>" + value.userEmail + "</td>";
	        str += "<td>" + value.userPhone + "</td>";
	        str += "<td>" + value.branchName + "</td>";
	        str += "<td>" + value.userPosition + "</td>";
	        str += "</tr>";
	      });

	      $("#userTable").html(str);
	      $("#headInfo").html(count);

	      pageButton(res.pagination.nodeType, res.pagination.nodeIndex,
	    		  res.pagination.totalPages, res.pagination.currentPage, "search");
		}
	});
}

function getUser(treeId, selectPage) {
  $.ajax({
    url: "/hierarchy/userlist.do",
    type: "get",
    beforeSend: function(req) {
  	  req.setRequestHeader("Authorization", "pathfinder " + document.cookie.substring(6));
    },
    data: { id: treeId, page: selectPage },
    success: function(res) {
      let str = "";
      let count = "";

      count += `<li class="breadcrumb-item">조직도 패이지 /&nbsp</a></li>`;
      count += `<li class="breadcrumb-list">${res.pagination.totalElements}명</li>`;

      $.each(res.data, function(key, value) {
    	str += `<tr class="tr-shadow">`;
        str += "<td>" + value.userName + "</td>";
        str += "<td>" + value.userEmail + "</td>";
        str += "<td>" + value.userPhone + "</td>";
        str += "<td>" + value.branchName + "</td>";
        str += "<td>" + value.userPosition + "</td>";
        str += "</tr>";
      });

      $("#userTable").html(str);

      $("#headInfo").html(count);

      pageButton(res.pagination.nodeType, res.pagination.nodeIndex,
    		  res.pagination.totalPages, res.pagination.currentPage, "list");
    }
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
      let selectedData = data.instance.get_node(data.selected);

      if (selectedData.children.length > 0) {
        $("#jstree")
          .jstree(true)
          .toggle_node(selectedData);
      }

      getUser(selectedData.id, 0);
      userSearch(selectedData.id, 0);
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

  function treeData(id) {
    let result = "";

    $.ajax({
      url: "/hierarchy/treelist.do",
      type: "get",
      data: { id },
      beforeSend: function(req) {
    	  req.setRequestHeader("Authorization", "pathfinder " + document.cookie.substring(6));
      },
      async: false,
      success: function(res) {
        result = res.data;
      },
    });

    return result;
  }
}