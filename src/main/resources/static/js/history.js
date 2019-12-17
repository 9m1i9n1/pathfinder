$(document).ready(function() {
  getHistory(0, "ing");
  checkEvent();
  datePicker();
});

function pageButton(totalPages, currentPage, id) {
  $("#page").paging({
    nowPage: currentPage + 1,
    pageNum: totalPages,
    buttonNum: 12,
    callback: function(currentPage) {
      getHistory(currentPage - 1, id);
    }
  });
}

function datePicker() {
  $("#calendar").calendar({
    width: 280,
    height: 280,
    trigger: "#keyword",
    zIndex: 999,
    format: "yyyy-mm-dd",
    offset: [-95, 3],
    weekArray: ["일", "월", "화", "수", "목", "금", "토"],
    monthArray: [
      "1월",
      "2월",
      "3월",
      "4월",
      "5월",
      "6월",
      "7월",
      "8월",
      "9월",
      "10월",
      "11월",
      "12월"
    ],
    onClose: function(view, date, data) {
      $("#keyword").val(moment(date).format("YYYY-MM-DD"));
    }
  });
}

function checkEvent(selectPage, id) {
  $("#myhistory").change(function() {
    let checked = $(this).prop("checked");
    let tabId = sessionStorage.getItem("tabId");

    getHistory(0, tabId);
  });
}

function getHistory(selectPage, id) {
  let tabId = sessionStorage.setItem("tabId", id);

  $("#keyword").val("");

  printHistory(selectPage, id);
}

function printHistory(selectPage, id, keyword) {
  let isChecked = $("#myhistory").bootstrapToggle()[0].checked;

  $.ajax({
    url: "/history/gethistory.do",
    type: "get",
    data: {
      page: selectPage,
      id: id,
      myhistory: isChecked,
      keyword: keyword
    },
    success: function(res) {
      let str = "";

      if (res.resultCode !== "ERROR") {
        $.each(res.data, function(key, value) {
          str += `<tr class="tr-shadow">`;
          str += "<td>" + value.regdate + "</td>";
          str += "<td>" + value.username + "</td>";
          str += "<td>" + value.dep + "</td>";
          str += "<td>" + value.arvl + "</td>";
          str += "<td>" + value.dlvrdate + "</td>";
          str += "<td>" + value.arrivedate + "</td>";
          str += "<td>" + value.carname + "</td>";
          str +=
            "<td><button class='btn btn-primary btn-sm bg-gradient-primary'" +
            "data-toggle='modal' data-target='#detailsModal'" +
            "onclick='getRoutes(" +
            JSON.stringify(value) +
            ")'><i class='fas fa-search'></i>상세보기</button></td>";
          str += "</tr>";
        });
        pageButton(res.pagination.totalPages, res.pagination.currentPage, id);
      } else {
        $("#tableListBody").html("");
        $("#page").html("");

        str += `<tr class="tr-shadow">`;
        str += `<td colspan="8">`;
        str += `${res.description}`;
        str += `</td>`;
        str += `</tr>`;
      }
      $("#tableListBody").html(str);
    }
  });
}

function getSearch() {
  let tabId = sessionStorage.getItem("tabId");
  let keyword = $("#keyword").val();

  printHistory(0, tabId, keyword);
}

// Modal
var detailsModal = $("#detailsModal");

function removeRoutes(history) {
  let alertBox = confirm("해당 기록을 삭제하시겠습니까?");

  if (alertBox) {
    $.ajax({
      url: "/history/removeroutes.do",
      type: "delete",
      data: JSON.stringify(history.id),
      contentType: "application/json; charset=UTF-8",
      success: function(res) {
        alert("삭제 되었습니다.");
        $("#detailsModal").modal("hide");

        let tabId = sessionStorage.getItem("tabId");
        getHistory(0, tabId);
      }
    });
  }
}

function getRoutes(routes) {
  let imgSrc = routes.imgSrc;

  $.ajax({
    url: "/history/getroutes.do",
    type: "get",
    data: {
      routesIndex: routes.routes
    },
    success: function(res) {
      let str = "";
      let count = 0;
      let totalTime = 0;
      $.each(res.data, function(key, value) {
        str += `<tr class="tr-shadow" id="ModalTr">`;
        str += "<td>" + ++count + "</td>";
        str += "<td>" + value.rdep + "</td>";
        str += "<td>" + value.rarvl + "</td>";
        str += "<td>" + value.rdist + "Km" + "</td>";
        str += "<td>" + value.rtime + "</td>";
        str += "<td>" + value.rfee + "</td>";
        str += "</tr>";

        totalTime += parseFloat(value.rtime);
      });

      if (userAuth === "[ROLE_ADMIN]" || userName === routes.username) {
        $("#deleteBtn").show();
      } else {
        $("#deleteBtn").hide();
      }

      $("#deleteBtn")
        .off()
        .on("click", function() {
          removeRoutes(routes);
        });

      $("#routesListBody").html(str);

      detailsModal.find("#mapImg").attr("src", routes.imgSrc);

      detailsModal.find("#index").text("총 소요시간 " + routes.index);

      detailsModal
        .find("#totalTime")
        .text("총 소요시간 : " + Number(totalTime).toFixed(1));

      detailsModal.find("#regdate").text(routes.regdate);

      detailsModal.find("#username").text(routes.username);

      detailsModal.find("#carname").text(routes.carname);

      detailsModal.find("#dep").text(routes.dep);

      detailsModal.find("#arvl").text(routes.arvl);

      detailsModal.find("#dist").text("총 거리 : " + routes.dist + " Km");

      detailsModal.find("#fee").text("전체 비용 : " + routes.fee + " 원");
    }
  });
}

$("#printBtn").on("click", function() {
  let domClone = $("#printThis").clone();
  let $printSection = $("#printSection").get(0);

  if (!$printSection) {
    $printSection = $('<div id="printSection"></div>');

    $(document.body).append($printSection);
  }

  $("#printSection").html("");
  $("#printSection").append(domClone);

  window.print();
});
