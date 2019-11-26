<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
  <head>
    <title>회원 관리 페이지</title>
    <c:import url="/WEB-INF/jsp/layout/header.jsp" />
  </head>

  <body>
    <div class="container-fluid">
      <ol class="breadcrumb" id="headerol">
        <li class="breadcrumb-item">관리자 페이지 : 사용자 관리</li>
      </ol>
    </div>

    <div class="container-fluid">
      <div class="row">
        <div class="col-2">
          <div class="card">
            <div class="card-header">
              <h3 class="card-title">조직도</h3>
            </div>

            <div class="card-body">
              <div id="jstree"></div>
            </div>
          </div>
        </div>

        <div class="col-10">
          <div class="card">
            <div class="card-header">
              <h3 class="card-title">사용자 목록</h3>

              <div class="card-tools">
                <div class="input-group input-group-sm" style="width: 150px;">
                  <input
                    type="text"
                    name="table_search"
                    class="form-control float-right"
                    placeholder="Search"
                  />

                  <div class="input-group-append">
                    <button type="submit" class="btn btn-default">
                      <i class="fas fa-search"></i>
                    </button>
                  </div>
                </div>

                <button
                  class="btn btn-block bg-gradient-primary"
                  data-toggle="modal"
                  data-target="#insertModal"
                >
                  <i class="zmdi zmdi-plus"></i>사용자 추가
                </button>
              </div>
            </div>

            <div class="card-body table-responsive p-0">
              <table id="table" class="table table-hover">
                <thead>
                  <tr>
                    <th>
                      <label class="au-checkbox">
                        <input type="checkbox" />
                        <span class="au-checkmark"></span>
                      </label>
                    </th>
                    <th style="display: none;">번호</th>
                    <th>이름</th>
                    <th>지점</th>
                    <th>직책</th>
                    <th>아이디</th>
                    <th>이메일</th>
                    <th>전화번호</th>
                    <th>권한</th>
                    <th>수정/삭제</th>
                  </tr>
                </thead>

                <tbody id="body"></tbody>
              </table>
              
              <div id="page"></div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <%@include file="userManageModal.jsp"%>

    <script src="/static/js/adminUserManage.js"></script>

  </body>
</html>
