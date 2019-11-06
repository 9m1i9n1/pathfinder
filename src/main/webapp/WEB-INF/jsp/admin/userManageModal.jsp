<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%-- Insert Modal --%>
<div class="modal fade" id="insertModal" tabindex="-1" role="dialog" aria-labelledby="insertModalTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="title">사용자 추가</h5>
      </div>

      <div class="modal-body">
        <form id="userCreateForm">
          <div class="form-group row">
            <label for="userId" class="col-sm-3 col-form-label-sm">아이디</label>
            <div class="col-sm-8">
              <input type="text" class="form-control" id="userId" name="userId" />
            </div>
          </div>

          <div class="form-group row">
            <label for="userName" class="col-sm-3 col-form-label-sm">이름</label>
            <div class="col-sm-8">
              <input type="text" class="form-control" id="userName" name="userName"/>
            </div>
          </div>

          <div class="form-group row">
            <label for="userEmail" class="col-sm-3 col-form-label-sm">이메일</label>
            <div class="col-sm-8">
              <input type="userEmail" class="form-control" id="userEmail" name="userEmail"/>
            </div>
          </div>

          <div class="form-group row">
            <label for="userPhone" class="col-sm-3 col-form-label-sm">전화번호</label>
            <div class="col-sm-8">
              <input type="text" class="form-control" id="userPhone" name="userPhone"/>
            </div>
          </div>

          <div class="form-group row">
            <label for="areaIndex" class="col-sm-3 col-form-label-sm">지역</label>
            <div class="col-sm-8">
              <select class="selectpicker" data-live-search="true" id="areaIndex" name="areaIndex">
              </select>
            </div>
          </div>

          <div class="form-group row">
            <label for="branchIndex" class="col-sm-3 col-form-label-sm">지점</label>
            <div class="col-sm-8">
              <select class="selectpicker" data-live-search="true" id="branchIndex" name="branchIndex">
              </select>
            </div>
          </div>

          <div class="form-group row">
            <label for="userPosition" class="col-sm-3 col-form-label-sm">직책</label>
            <div class="col-sm-8">
              <select class="selectpicker" data-live-search="true" id="userPosition" name="userPosition">
                <option value="" disabled selected>선택</option>
                <option value="사원">사원</option>
                <option value="대리">대리</option>
                <option value="과장">과장</option>
                <option value="차장">차장</option>
                <option value="부장">부장</option>
                <option value="임원">임원</option>
              </select>
            </div>
          </div>

          <div class="form-group row">
            <label for="userAuth" class="col-sm-3 col-form-label-sm">권한</label>
            <div class="col-sm-8">
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="userAuth" id="authUser" value="false" />
                <label class="form-check-label" for="authUser">일반 사용자</label>
              </div>
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="userAuth" id="authAdmin" value="true">
                <label class="form-check-label" for="authAdmin">관리자</label>
              </div>
            </div>
          </div>
        </form>
      </div>

      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary" data-dismiss="modal" id="InsertBtn">등록</button>
      </div>
    </div>
  </div>
</div>

<%-- Modify Modal --%>
<div class="modal fade" id="modifyModal" tabindex="-1" role="dialog" aria-labelledby="modifyModalTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="title">사용자 수정</h5>
      </div>

      <div class="modal-body">
        <form id="userModifyForm">
          <div class="form-group row" style="display:none;">
            <label for="userIndex" class="col-sm-3 col-form-label-sm">번호</label>
            <div class="col-sm-8">
              <input type="text" class="form-control" id="userIndex" name="userIndex" readonly />
            </div>
          </div>

          <div class="form-group row">
            <label for="userId" class="col-sm-3 col-form-label-sm">아이디</label>
            <div class="col-sm-8">
              <input type="text" class="form-control" id="userId" name="userId" readonly />
            </div>
          </div>

          <div class="form-group row">
            <label for="userName" class="col-sm-3 col-form-label-sm">이름</label>
            <div class="col-sm-8">
              <input type="text" class="form-control" id="userName" name="userName"/>
            </div>
          </div>

          <div class="form-group row">
            <label for="userEmail" class="col-sm-3 col-form-label-sm">이메일</label>
            <div class="col-sm-8">
              <input type="userEmail" class="form-control" id="userEmail" name="userEmail"/>
            </div>
          </div>

          <div class="form-group row">
            <label for="userPhone" class="col-sm-3 col-form-label-sm">전화번호</label>
            <div class="col-sm-8">
              <input type="text" class="form-control" id="userPhone" name="userPhone"/>
            </div>
          </div>

          <div class="form-group row">
            <label for="areaIndex" class="col-sm-3 col-form-label-sm">지역</label>
            <div class="col-sm-8">
              <select class="selectpicker" data-live-search="true" id="areaIndex" name="areaIndex">
              </select>
            </div>
          </div>

          <div class="form-group row">
            <label for="branchIndex" class="col-sm-3 col-form-label-sm">지점</label>
            <div class="col-sm-8">
              <select class="selectpicker" data-live-search="true" id="branchIndex" name="branchIndex">
              </select>
            </div>
          </div>

          <div class="form-group row">
            <label for="userPosition" class="col-sm-3 col-form-label-sm">직책</label>
            <div class="col-sm-8">
              <select class="selectpicker" data-live-search="true" id="userPosition" name="userPosition">
                <option value='' disabled selected>선택</option>
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
            <label for="userAuth" class="col-sm-3 col-form-label-sm">권한</label>
            <div class="col-sm-8">
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="userAuth" id="authUser" value="false" />
                <label class="form-check-label" for="authUser">일반 사용자</label>
              </div>
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="userAuth" id="authAdmin" value="true">
                <label class="form-check-label" for="authAdmin">관리자</label>
              </div>
            </div>
          </div>
        </form>
      </div>

      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary" data-dismiss="modal" id="ModifyBtn">수정</button>
      </div>
    </div>
  </div>
</div>