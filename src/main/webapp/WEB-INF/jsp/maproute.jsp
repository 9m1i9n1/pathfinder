<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@page import="java.util.List"%>

<!DOCTYPE html>
<html>
  <head>
    <title>CSS</title>

    <script src="/static/route/js/proj4.js"></script>
    <script src="/static/route/js/proj4leaflet.js"></script>
    <script src="/static/route/js/Leaflet.KoreanTmsProviders.js"></script>

    <script src="/static/js/swiper.min.js"></script>
    <link rel="stylesheet" href="/static/css/swiper.min.css" />

    <link href="/static/css/maproute.css" rel="stylesheet" />
  </head>

  <body>
    <div class="container-fluid">
      <ol class="breadcrumb">
        <li class="breadcrumb-item">경로탐색</li>
      </ol>
    </div>

    <div class="container-fluid">
      <div class="row">
        <div class="col-9">
          <div id="map"></div>
        </div>
        <div class="col-3">
          <div class="card">
            <div class="card-header">
              <b>검색</b>
              <input
                type="text"
                name="keyword"
                id="keyword"
                style="text-align: center; width: 60%"
              />
              <input
                type="button"
                name="btnSearch"
                id="btnSearch"
                value="확인"
                style="width: 20%"
              />
            </div>

            <div id="tableEdge">
              <table
                class="table table-hover table-mc-light-blue"
                style="text-align: center;"
                id="allDataTable"
              ></table>
            </div>

            <div class="card">
              <div class="card-header">
                <b>검색누른거</b>
              </div>
              <div id="tableEdge">
                <table
                  class="table table-hover table-mc-light-blue"
                  style="text-align: center;"
                  id="selectRoute"
                ></table>
              </div>
              <button type="button" id="submitroute">전송</button>
            </div>
          </div>
        </div>
      </div>

      <div class="row" style="margin-top: 5px;">
        <div class="col-9">
          <div class="card">
            <div class="card-header">
              <b>경로</b>
            </div>
            <div
              class="row flex-row flex-nowrap"
              id="box"
              class="box"
              style="min-height:200px; max-height: 200px;"
            ></div>
          </div>
        </div>

        <div class="col-3">
          <div class="card">
            <div class="card-header">
              <b>최종값</b>
            </div>
            <div class="card-body" style="min-height: 200px;">
              <div id="finalPathDiv"></div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </body>

  <script src="/static/js/routes.js"></script>
</html>

<%-- 
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">

    <script src="/static/route/js/proj4.js"></script>
    <script src="/static/route/js/proj4leaflet.js"></script>
    <script src="/static/route/js/Leaflet.KoreanTmsProviders.js"></script>

</head>
<body>
	<div id="map" style="height: 800px; background-color: rgba(0,0,255,.1)"
  >
	</div>

	<script src="/static/js/mapexample.js"></script>
</body>
</html> --%>