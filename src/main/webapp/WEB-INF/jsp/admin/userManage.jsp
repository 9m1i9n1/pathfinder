<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
    <title>Document</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.9/dist/css/bootstrap-select.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.9/dist/js/bootstrap-select.min.js"></script>
  </head>
  <body>
    <h1>User</h1>

    <input type="button" data-toggle="modal" data-target="#insertModal" value="사용자 추가" />

    <table id="table" width="100%" border="1">
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

    <%@include file="userManageModal.jsp"%>
    <script src="/static/js/adminUserManage.js">
  </body>
</html>
