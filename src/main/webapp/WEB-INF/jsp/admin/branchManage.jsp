<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
  <head>
    <title>지점관리페이지</title>
  </head>
  <body>
    <div class="container-fluid">
      <ol class="breadcrumb">
        <li class="breadcrumb-item">관리자 페이지</li>
        <li class="breadcrumb-item active">지점 관리</li>
      </ol>
    </div>
    <div class="container-fluid">
      <div class="row">
        <div class="col-2">
          <div class="card">
            <div class="card-header">
              <b>조직도</b>
            </div>
            <div class="card-body">
              <div id="jstree"></div>
            </div>
          </div>
        </div>
        <div class="col-10">
          <div class="card">
            <div class="card-header">
              <b>지점 목록</b>
              <button
                class="au-btn au-btn-icon au-btn--blue au-btn--small"
                data-toggle="modal"
                data-target="#insertModal"
                value="지점 추가"
              >
                <i class="zmdi zmdi-plus"></i>지점 추가
              </button>
              <div style="float: right;">
                <select class="selectpicker" name="searchType" id="searchType">
                  <option value="branchName">지점명</option>
                  <option value="branchAddr">주소</option>
                </select>
                <input type="text" name="keyword" id="keyword" />
                <button class="btn btn-primary" name="btnSearch" id="btnSearch">
                  <i class="fas fa-search"></i>
                </button>
              </div>
            </div>
            <div class="table-responsive table-responsive-data2">
              <table class="table table-data2" id="tableTest">
                <thead>
                  <tr>
                    <th>지역</th>
                    <th>지점명</th>
                    <th>지점장</th>
                    <th>주소</th>
                    <th>전화번호</th>
                    <th>운반비</th>
                    <th>수정/삭제</th>
                  </tr>
                </thead>
                <tbody id="tableListBody"></tbody>
              </table>
              <div id="page"></div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </body>
  <%@include file="branchManageModal.jsp"%>
  <script src="/static/js/adminBranchManage.js"></script>
</html>
