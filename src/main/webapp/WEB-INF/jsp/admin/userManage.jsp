<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
    <title>Document</title>
    <link rel="stylesheet" href="/static/css/loadingbar.css">
  </head>
  <body>
    	<div class="container-fluid">
        <ol class="breadcrumb" id=headerol>
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

          <div id = "Progress_Loading">
          <img src="/static/pic/loading.gif"/>
        </div>
      <div id="page">
      </div>
  </div>
</div>

    <%@include file="userManageModal.jsp"%>
    <script src="/static/js/adminUserManage.js">
  </body>
</html>
