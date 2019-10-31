<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%-- modal --%>
<div class="modal fade" id="insertModal" tabindex="-1" role="dialog" aria-labelledby="insertModalTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="title">사용자 추가</h5>
      </div>

      <div class="modal-body">
        <form id="exampleForm">
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
            <label for="email" class="col-sm-2 col-form-label-sm">이메일</label>
            <div class="col-sm-10">
              <input type="email" class="form-control" id="email">
            </div>
          </div>

          <div class="form-group row">
            <label for="phone" class="col-sm-2 col-form-label-sm">전화번호</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" id="phone">
            </div>
          </div>

          <div class="form-group row">
            <label for="area" class="col-sm-2 col-form-label-sm">지역</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" id="area">
            </div>
          </div>

          <div class="form-group row">
            <label for="branch" class="col-sm-2 col-form-label-sm">지점</label>
            <div class="col-sm-10">
            <select class="selectpicker" data-live-search="true" id="branch">
              <option>0</option>
              <option>1</option>
              <option>2</option>
              <option>3</option>
              <option>4</option>
              <option>5</option>
            </select>
            </div>
          </div>

          <div class="form-group row">
            <label for="position" class="col-sm-2 col-form-label-sm">직책</label>
            <div class="col-sm-10">
              <select class="selectpicker" data-live-search="true" id="position">
                <option>사원</option>
                <option>대리</option>
                <option>과장</option>
                <option>차장</option>
                <option>부장</option>
                <option>임원</option>
              </select>

            </div>
          </div>

          <div class="form-group row">
            <label for="auth" class="col-sm-2 col-form-label-sm">권한</label>
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
        <button type="button" class="btn btn-primary" name="InsertBtn">등록</button>
      </div>
    </div>
  </div>
</div>