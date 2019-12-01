$(function() {
  let todayDate = moment().format("YYYY[-]MM[-]DD");

  $("#calendar").calendar({
    width: 280,
    height: 280,
    // 	zIndex: 1,
    // 	trigger: null,
    date: new Date(),
    // format:'yyyy-MM-dd',
    // view: 'date',
    startWeek: 0,
    selectedRang: [todayDate],
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
    ]
  });
});
