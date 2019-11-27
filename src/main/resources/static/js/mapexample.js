// 다음 지도 사용
var map = new L.Map("map", {
  center: new L.LatLng(36.1358642, 128.0785804), //중심점 : 김천 위경도 좌표
  zoom: 0.5, //Leaflet.KoreanTmsProviders.js : resolutions기준 줌 레벨(Level 12)
  crs: L.Proj.CRS.Daum, //Leaflet.KoreanTmsProviders.js : 새로 정의된 Daum Map CRS
  worldCopyJump: false //https://leafletjs.com/reference-1.3.2.html#map-worldcopyjump 참조
});

var baseLayers = L.tileLayer.koreaProvider("DaumMap.Street").addTo(map);
baseLayers.on("load", function() {
  console.log("로딩");
});
