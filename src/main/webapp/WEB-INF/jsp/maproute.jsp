<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@page import="java.util.List"%>

<!DOCTYPE html>
<html>
  <head>
    <title>CSS</title>

    <!-- 한국 지도 표시 -->
    <script src="/static/route/js/proj4.js"></script>
    <script src="/static/route/js/proj4leaflet.js"></script>
    <script src="/static/route/js/Leaflet.KoreanTmsProviders.js"></script>

    <!-- 캘린더 표시 -->
    <link rel="stylesheet" href="/static/route/css/calendar.css" />
    <script src="/static/route/js/calendar.js"></script>

    <script src="/static/js/swiper.min.js"></script>
    <link href="/static/css/swiper.min.css" rel="stylesheet" />

    <link href="/static/route/css/maproute.css" rel="stylesheet" />
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
          <div class="accordion md-accordion" id="accordion-select">
            <%-- 출발지점 선택 --%>
            <div class="card">
              <div class="card-header" id="headingDep">
                <h3
                  class="card-title"
                  data-toggle="collapse show"
                  data-target="#col-selectDep"
                  aria-expanded="false"
                  aria-controls="col-selectDep"
                >
                  1. 출발 지점 선택
                </h3>
              </div>

              <div
                id="col-selectDep"
                class="collapse show"
                aria-labelledby="headingDep"
                data-parent="#accordion-select"
              >
                <div class="card-body">
                  <select id="depSelect">
                    <option></option>
                  </select>
                </div>

                <div class="card-footer">
                  <button
                    class="btn btn-primary"
                    type="button"
                    data-toggle="collapse"
                    data-target="#col-selectCar"
                    aria-expanded="false"
                    aria-controls="col-selectCar"
                  >
                    다음
                  </button>
                </div>
              </div>
            </div>

            <!-- 차량 선택 -->
            <div class="card">
              <div class="card-header" id="headingCar">
                <h3 class="card-title">
                  2. 차량 선택
                </h3>
              </div>

              <div
                id="col-selectCar"
                class="collapse multi-collapse1"
                aria-labelledby="headingCar"
                data-parent="#accordion-select"
              >
                <div class="card-body">
                  <select id="carSelect">
                    <option></option>
                  </select>
                </div>

                <div class="card-footer">
                  <button
                    class="btn btn-primary"
                    type="button"
                    data-toggle="collapse"
                    data-target="#col-selectDep"
                    aria-expanded="false"
                    aria-controls="col-selectDep"
                  >
                    이전
                  </button>
                  <button
                    class="btn btn-primary"
                    id="nextCarButton"
                    type="button"
                    data-toggle="collapse"
                    data-target="#col-selectDate"
                    aria-expanded="false"
                    aria-controls="col-selectDate"
                  >
                    다음
                  </button>
                </div>
              </div>
            </div>

            <!-- 날짜선택 -->
            <div class="card">
              <div class="card-header" id="headingDate">
                <h3 class="card-title">
                  3. 예약 날짜 선택
                </h3>
              </div>

              <div
                id="col-selectDate"
                class="collapse"
                aria-labelledby="headingDate"
                data-parent="#accordion-select"
              >
                <div class="card-body" id="calendarcard">
                  <div id="calendarBox"></div>

                  <div class="alert alert-light" role="alert" id="selectDate">
                    배송날짜를 선택해주세요!
                  </div>
                </div>

                <div class="card-footer">
                  <button
                    class="btn btn-primary"
                    type="button"
                    data-toggle="collapse"
                    data-target="#col-selectCar"
                    aria-expanded="false"
                    aria-controls="col-selectCar"
                  >
                    이전
                  </button>
                  <button
                    class="btn btn-primary"
                    type="button"
                    data-toggle="collapse"
                    data-target="#col-selectBranch"
                    aria-expanded="false"
                    aria-controls="col-selectBranch"
                    onclick="branchlist(selectBranchlist)"
                  >
                    다음
                  </button>
                </div>
              </div>
            </div>

            <!-- 지점 선택 -->
            <div class="card">
              <div class="card-header" id="headingBranch">
                <h3 class="card-title">
                  4. 경유 지점 선택
                </h3>

                <%-- 이전 검색. class명 확인차 주석 --%> <%--
                <div class="card-header">
                  검색
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
                --%>
              </div>

              <div
                id="col-selectBranch"
                class="collapse"
                aria-labelledby="headingBranch"
                data-parent="#accordion-select"
              >
                <div class="card-body">
                  <select id="branchSelect" multiple="multiple">
                    <option></option>
                  </select>
                </div>
                <div class="card-footer">
                  <button
                    class="btn btn-primary"
                    type="button"
                    data-toggle="collapse"
                    data-target="#col-selectDate"
                    aria-expanded="false"
                    aria-controls="col-selectDate"
                  >
                    이전
                  </button>
                  <button
                    class="btn btn-primary"
                    type="button"
                    data-toggle="collapse"
                    data-target="#col-selectRoad"
                    aria-expanded="false"
                    aria-controls="col-selectRoad"
                  >
                    다음
                  </button>
                </div>
              </div>
              <%--
              <div>
                <div class="card-header">
                  <h3 class="card-title">지점 목록</h3>

                  <div class="card-tools">
                    <div
                      class="input-group input-group-sm"
                      style="width: 150px;"
                    >
                      <input
                        type="text"
                        name="selected_search"
                        class="form-control float-right"
                        placeholder="검색"
                      />

                      <div class="input-group-append">
                        <button type="submit" class="btn btn-default">
                          <i class="fas fa-search"></i>
                        </button>
                      </div>
                    </div>
                  </div>
                  <div id="tableEdge">
                    <table
                      class="table table-hover table-mc-light-blue"
                      style="text-align: center;"
                      id="selectRoute"
                    ></table>
                  </div>
                </div>

                <div id="tableEdge">
                  <table
                    class="table table-hover table-mc-light-blue"
                    style="text-align: center;"
                    id="allDataTable"
                  ></table>
                </div>
              </div>

              <div class="card-header">
                <h3 class="card-title">선택된 지점</h3>

                <div class="card-tools">
                  <div class="input-group input-group-sm" style="width: 150px;">
                    <input
                      type="text"
                      name="selected_search"
                      class="form-control float-right"
                      placeholder="검색"
                    />

                    <div class="input-group-append">
                      <button type="submit" class="btn btn-default">
                        <i class="fas fa-search"></i>
                      </button>
                    </div>
                  </div>
                </div>
                <div id="tableEdge">
                  <table
                    class="table table-hover table-mc-light-blue"
                    style="text-align: center;"
                    id="selectRoute"
                  ></table>
                </div>
                --%>
              </div>

              <!-- 차량 선택 -->
              <div class="card">
                <div class="card-header" id="headingRoad">
                  <h3 class="card-title">
                    5. 추천 경로
                  </h3>
                </div>

                <div
                  id="col-selectRoad"
                  class="collapse"
                  aria-labelledby="headingRoad"
                  data-parent="#accordion-select"
                >
                  <div class="card-body">
                    <div id="Carselect"></div>
                  </div>

                  <div class="card-footer">
                    <button
                      class="btn btn-primary"
                      type="button"
                      data-toggle="collapse"
                      data-target="#col-selectBranch"
                      aria-expanded="false"
                      aria-controls="col-selectBranch"
                    >
                      이전
                    </button>
                  </div>
                </div>
              </div>
              <!--  accordion div -->
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

    <script src="/static/js/routes.js"></script>
  </body>
</html>
