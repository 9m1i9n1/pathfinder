<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!-- Modal -->
<!-- 추가모달 -->
<div class="modal fade" id="insertModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel">지점 추가</h4>
			</div>

			<div class="modal-body">
				<form name="branchInsertform" id="branchInsertform">

					<div class="form-group row">
						<label for="b1" class="col-sm-2 col-form-label-sm">지점명 </label>
						<div class="col-sm-8">
							<input type="text" class="form-control" name="branchName"
								id="branchName" >
						</div>
					</div>

					<div class="form-group row">
						<label for="b2" class="col-sm-2 col-form-label-sm">지점장 </label>
						<div class="col-sm-8">
							<input type="text" class="form-control" name="branchOwner"
								id="branchOwner" >
						</div>
					</div>

					<div class="form-group row">
						<label for="b3" class="col-sm-2 col-form-label-sm">운반비</label>
						<div class="col-sm-8">
							<input type="number" class="form-control" name="branchValue"
								id="branchValue" step="1000" >
						</div>
					</div>


					<div class="form-group row">
						<label for="b4" class="col-sm-2 col-form-label-sm">주소</label>
						<div class="col-sm-8">
							<input type="button" onclick="addressFind()" value="주소 검색" />
							 <input
								type="text" class="form-control" id="branch_Addr"
								name="branchAddr" placeholder="주소" readonly  />
						</div>
					</div>

					<div class="form-group row">
						<label for="b5" class="col-sm-2 col-form-label-sm">상세주소</label>
						<div class="col-sm-8">
							<input type="text" id="branchDaddr" class="form-control"
								name="branchDaddr" placeholder="상세주소" >
						</div>
					</div>

					<div class="form-group row">
						<label for="b7" class="col-sm-2 col-form-label-sm"> 지역</label>
						<div class="col-sm-8">
							<input readonly type="text" id="branch_Area" class="form-control"
								name="areaIndex" >
						</div>
					</div>

					<div class="form-group row">
						<label for="b6" class="col-sm-2 col-form-label-sm"> 전화번호</label>
						<div class="col-sm-8">
							<input type="text" class="form-control" name="branchPhone"
								id="branchPhone" placeholder="ex) 010-1234-5676" >
						</div>
					</div>
					<div id="branchPhoneVaild"></div>

					<input hidden type="text" name="branchLat"> <input hidden
						type="text" name="branchLng">


					<div class="modal-footer">
						<input type="button" class="btn btn-default" data-dismiss="modal"
							value="취소"> <input type="submit" name="branchInsertBtn"
							id="branchInsertBtn" class="btn btn-primary" value="등록">

					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<%-- data-dismiss="modal" --%>

<!-- 수정 모달 -->
<div class="modal fade" id="updateModal" tabindex="-1" role="dialog"
	aria-labelledby="modifyModalTitle" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">지점 수정</h4>
				<button type="button" class="close" data-dismiss="modal">×</button>
			</div>

			<div class="modal-body">
				<form name="branchUpdateForm" id="branchUpdateForm">

					<input hidden type="text" id="updateAreaIndex" name="branchIndex">
					<input hidden type="text" id="areaIndex" name="areaIndex">

					<div class="form-group row">
						<label for="branchArea" class="col-sm-3 col-form-label-sm">지역
						</label>
						<div class="col-sm-8">
							<input type="text" class="form-control" id="branchArea1"
								name="branchArea" readonly>
						</div>
					</div>

					<div class="form-group row">
						<label for="branchName" class="col-sm-3 col-form-label-sm">
							지점명 </label>
						<div class="col-sm-8">
							<input type="text" class="form-control" id="branchName1"
								name="branchName">
						</div>
					</div>

					<div class="form-group row">
						<label for="branchOwner" class="col-sm-3 col-form-label-sm">
							지점장</label>
						<div class="col-sm-8">
							<input type="text" class="form-control" id="branchOwner1"
								name="branchOwner">
						</div>
					</div>

					<div class="form-group row">
						<label for="branchValue" class="col-sm-3 col-form-label-sm">운반비</label>
						<div class="col-sm-8">
							<input type="number" step="1000" class="form-control"
								id="branchValue1" name="branchValue">
						</div>
					</div>

					<div class="form-group row">
						<label for="branchPhone" class="col-sm-3 col-form-label-sm">전화번호</label>
						<div class="col-sm-8">
							<input type="text" class="form-control" id="branchPhone1"
								name="branchPhone">
						</div>
					</div>
					<div class="modal-footer">
						<input type="submit" name="branchUpdateSaveBtn"
							class="btn btn-primary" value="수정" id="branchUpdateBtn">
						<input type="button" class="btn btn-secondary"
							data-dismiss="modal" value="닫기">
					</div>
				</form>

			</div>
		</div>
	</div>
</div>

