<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- Modal -->
<!-- 추가모달 -->
<div class="modal fade" id="insertModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel">지점 추가</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form name="branchInsertform">

					<div class="form-group row">
						<label for="b1" class="col-sm-2 col-form-label-sm">지점명 </label>
						<div class="col-sm-10">
							<input type="text" name="branchName">
						</div>
					</div>

					<div class="form-group row">
						<label for="b2" class="col-sm-2 col-form-label-sm">지점장 </label>
						<div class="col-sm-10">
							<input type="text" name="branchOwner">
						</div>
					</div>

					<div class="form-group row">
						<label for="b3" class="col-sm-2 col-form-label-sm">운반비</label>
						<div class="col-sm-10">
							<input type="number" name="branchValue">
						</div>
					</div>

					<div class="form-group row">
						<label for="b4" class="col-sm-2 col-form-label-sm">주소</label>
						<div class="col-sm-10">
							<input type="text" id="branch_address" name="branchAddr"
								placeholder="주소" readonly> <input type="button"
								onclick="addressFind()" value="주소 찾기">
						</div>
					</div>

					<div class="form-group row">
						<label for="b5" class="col-sm-2 col-form-label-sm">상세주소</label>
						<div class="col-sm-10">
							<input type="text" id="branch_detailAddress" name="branchDaddr"
								placeholder="상세주소">
							</p>
						</div>
					</div>

					<div class="form-group row">
						<label for="b7" class="col-sm-2 col-form-label-sm"> 지역</label>
						<div class="col-sm-10">
							<input readonly type="text" id="branch_Area" name="areaIndex">
						</div>
					</div>
					
					<div class="form-group row">
						<label for="b6" class="col-sm-2 col-form-label-sm"> 전화번호</label>
						<div class="col-sm-10">
							<input type="text" name="branchPhone">
						</div>
					</div>


					<input hidden type="text" name="branchLat"> <input hidden
						type="text" name="branchLng">

				</form>
			</div>

			<div class="modal-footer">
				<input type="button" class="btn btn-default" data-dismiss="modal"
					value="취소"> <input type="button" name="branchInsertBtn"
					data-dismiss="modal" class="btn btn-primary" value="등록">
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
				<form name="branchUpdateForm" method="post">

					<input hidden type="text" id="updateAreaIndex" name="branchIndex">
					<input hidden type="text" id="areaIndex" name="areaIndex">
					<p>
						<strong>지역</strong> <input type="text" id="branchArea1"
							name="branchArea" readonly>
					</p>
					<p>
						<strong>지점명</strong> <input type="text" id="branchName1"
							name="branchName" readonly>
					</p>
					<p>
						<strong>지점장</strong> <input type="text" id="branchOwner1"
							name="branchOwner">
					</p>
					<p>
						<strong>운반비</strong> <input type="text" id="branchValue1"
							name="branchValue">
					</p>
					<p>
						<strong>전화번호</strong> <input type="text" id="branchPhone1"
							name="branchPhone">
					</p>


					<input type="button" name="branchUpdateSaveBtn"
						data-dismiss="modal" value="수정"> <input type="button"
						class="btn btn-default" data-dismiss="modal" value="닫기">

				</form>
			</div>
		</div>
	</div>
</div>

