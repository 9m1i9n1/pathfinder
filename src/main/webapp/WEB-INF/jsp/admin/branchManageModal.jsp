<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Modal -->
<!-- 추가모달 -->
<div class="modal fade" id="insertModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
      <h4 class="modal-title" id="myModalLabel">지점 추가</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      </div>
      <div class="modal-body">
		 <form name="branchInsertform">
                  <p>
                     <strong>지점명</strong> <input type="text" name="branchName">
                  </p>
                  <p>
                     <strong>지점장</strong> <input type="text" name="branchOwner">
                  </p>
                  <p>
                     <strong>운반비</strong> <input type="number" name="branchValue">
                  </p>
                  
                  <p>
                  <strong>주소</strong>
                  <input type="text" id="branch_address" name="branchAddr" placeholder="주소">
                  <input type="button" onclick="addressFind()" value="주소 찾기"><br>
                  <strong>상세주소</strong>
                  <input type="text" id="branch_detailAddress" name="branchDaddr" placeholder="상세주소"></p>
                  
                  <p>
                     <strong>전화번호</strong> <input type="text" name="branchPhone">
                  </p>

                  <p>
                     <strong>지역</strong> <select name="areaIndex">
                        <option value=1>경기도</option>
                        <option value=2>강원도</option>
                        <option value=3>충청남도</option>
                        <option value=4>충청북도</option>
                        <option value=5>경상북도</option>
                        <option value=6>경상남도</option>
                        <option value=7>전라남도</option>
                        <option value=8>전라북도</option>
                     </select>
                  </p>

                  <p hidden>
                     <strong>위도</strong> <input type="text" name="branchLat">
                  </p>
                  <p hidden>
                     <strong>경도</strong> <input type="text" name="branchLng">
                  </p>  
                  </form>    
                  </div>
                  
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" name="branchInsertBtn" class="btn btn-primary">Save</button>
      </div>
    </div>
  </div>
</div>

<!-- 수정 모달 -->
   <div class="modal fade" id="updateModal">
      <div class="modal-dialog">
         <div class="modal-content">
            <!-- header -->
            <div class="modal-header">
               <h4 class="modal-title">지점 수정</h4>
               <!-- 닫기(x) 버튼 -->
               <button type="button" class="close" data-dismiss="modal">×</button>
               <!-- header title -->

            </div>
            <!-- body -->
            <div class="modal-body">
               <form name="branchUpdateForm"
                  method="post">
                  
                  <input hidden type="text" id="updateAreaIndex" name="branchIndex">
                  <input hidden type="text" id="areaIndex" name="areaIndex">
                  
                  <p>
                     <strong>지역</strong> <input type="text" id="branchArea1" name="branchArea" readonly>
                  </p>
                  <p>
                     <strong>지점명</strong> <input type="text" id="branchName1" name="branchName" readonly>
                  </p>
                  <p>
                     <strong>지점장</strong> <input type="text" id="branchOwner1" name="branchOwner">
                  </p>
                  <p>
                     <strong>운반비</strong> <input type="text" id="branchValue1" name="branchValue">
                  </p>
                  <p>
                     <strong>전화번호</strong> <input type="text" id="branchPhone1" name="branchPhone" >
                  </p>


                  <input type="button" name="branchUpdateSaveBtn" value="수정">
                  <input type="button" class="btn btn-default" data-dismiss="modal" value="닫기">

               </form>
            </div>
         </div>
      </div>
   </div>

