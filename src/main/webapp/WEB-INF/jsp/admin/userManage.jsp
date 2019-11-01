<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
    <title>Document</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.9/dist/css/bootstrap-select.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.9/dist/js/bootstrap-select.min.js"></script>
  </head>
  <body>
    	<div class="container-fluid">
        <ol class="breadcrumb" id=headerol>
          <li class="breadcrumb-item">관리자 페이지</a></li>
        </ol>
      </div>
  
  <div class="col">
    <div class="card">
      <div class="card-header">
        <b>사용자 관리</b>

        <input type="button" data-toggle="modal" data-target="#insertModal" value="사용자 추가" />
      </div>

    <table id="table" class="table table-hover table-mc-light-blue" style="text-align: center; boarder: 1px solid #ddddd">
      <thead>
        <tr>
          <th>번호</th>
          <th>아이디</th>
          <th>이름</th>
          <th>이메일</th>
          <th>전화번호</th>
          <th>지점</th>
          <th>직책</th>
          <th>초기화/삭제</th>
        </tr>
      </thead>

      <tbody id="body"></tbody>
    </table>
  </div>
</div>

    <%@include file="userManageModal.jsp"%>
    <script src="/static/js/adminUserManage.js">
  </body>
</html>
