<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
  <head>
    <title>Document</title>
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

    <%-- modal --%>
<div class="modal fade" id="insertModal" tabindex="-1" role="dialog" aria-labelledby="insertModalTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="insertModalTitle">사용자 추가</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>

      <div class="modal-body">
        <form>
          <div class="form-group row">
            <label for="id" class="col-sm-2 col-form-label-sm">아이디</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" id="id">
            </div>
          </div>

          <div class="form-group row">
            <label for="name" class="col-sm-2 col-form-label-sm">이름</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" id="name">
            </div>
          </div>
          
          <div class="form-group row">
            <label for="email" class="col-sm-2 col-form-label">이메일</label>
            <div class="col-sm-10">
              <input type="email" class="form-control" id="email">
            </div>
          </div>

          <div class="form-group row">
            <label for="phone" class="col-sm-2 col-form-label">전화번호</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" id="phone">
            </div>
          </div>

          <div class="form-group row">
            <label for="id" class="col-sm-2 col-form-label">지역</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" id="id">
            </div>
          </div>

          <div class="form-group row">
            <label for="id" class="col-sm-2 col-form-label">지점</label>
            <div class="col-sm-10">
              <select class="selectpicker" data-live-search="true" id="id">
              <option data-subtext="Rep California">Tom Foolery</option>
              <option data-subtext="Sen California">Bill Gordon</option>
              <option data-subtext="Sen Massacusetts">Elizabeth Warren</option>
              </select>
            </div>
          </div>

          <div class="form-group row">
            <label for="id" class="col-sm-2 col-form-label">직책</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" id="id">
            </div>
          </div>

          <div class="form-group row">
            <label for="id" class="col-sm-2 col-form-label">권한</label>
            <div class="col-sm-10">
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="auth" id="authUser" value="user">
                <label class="form-check-label" for="authUser">일반 사용자</label>
              </div>
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="auth" id="authAdmin" value="admin"">
                <label class="form-check-label" for="authAdmin">관리자</label>
              </div>
            </div>
          </div>
        </form>
        
      </div>

      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary">등록</button>
      </div>
    </div>
  </div>
</div>

  <%@ include file="userManageS.jsp" %>
</html>
