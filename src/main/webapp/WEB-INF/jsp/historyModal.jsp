<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="modal fade tableScroll" id="detailsModal" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-dialog-centered"
		role="document">
		<div class="modal-content" id="modal-content">
			<div id="printThis">
				<div class="modal-header">
					<h4 class="modal-title" id="myModalLabel">상세정보</h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-md-5">
							<div class="form-group row">
								<label for="branchName" class="col-sm-3 col-form-label-sm">
									예약일자 </label>
								<div class="col-sm-8">
									<h2 class="form-control" id="regdate"></h2>
								</div>
							</div>

							<div class="form-group row">
								<label for="branchOwner" class="col-sm-3 col-form-label-sm">
									사용자</label>
								<div class="col-sm-8">
									<h2 class="form-control" id="username"></h2>
								</div>
							</div>
							<div class="form-group row">
								<label for="branchArea"
									class="col-sm-3 col-form-label-sm center">차량번호 </label>
								<div class="col-sm-8">
									<h2 class="form-control" id="carname"></h2>
								</div>
							</div>
							<div class="form-group row">
								<label for="branchValue" class="col-sm-3 col-form-label-sm">출발지</label>
								<div class="col-sm-8">
									<h2 class="form-control" id="dep"></h2>
								</div>
							</div>

							<div class="form-group row">
								<label for="branchPhone" class="col-sm-3 col-form-label-sm">도착지</label>
								<div class="col-sm-8">
									<h2 class="form-control" id="arvl"></h2>
								</div>
							</div>
						</div>

						<div class="col-md-7">
							<img id="mapImg" width="100%" height="100%" class="pb-4">
						</div>
					</div>


					<table class=" table table-hover " id="tableTest">
						<thead>
							<tr>
								<th>번호</th>
								<th>출발지</th>
								<th>도착지</th>
								<th>거리</th>
								<th>시간</th>
								<th>비용</th>
							</tr>
						</thead>

						<tbody id="routesListBody"></tbody>
					</table>

					<div>
						<div class="row">
							<div class="col-md-4">
								<div class="small-box bg-teal">
									<div class="inner">
										<h5>총거리</h5>
										<p id="dist"></p>
										<div class="icon">
											<i class="fas fa-truck fa-lg"></i>
										</div>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="small-box bg-primary">
									<div class="inner">
										<h5>소요 시간</h5>
										<p id="totalTime"></p>
										<div class="icon">
											<i class="far fa-clock fa-lg"></i>
										</div>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="small-box bg-olive">
									<div class="inner">
										<h5>비용</h5>
										<p id="fee"></p>
										<div class="icon">
											<i class="fas fa-coins  fa-lg"></i>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="modal-footer">
				<button class="btn btn-secondary" type="button" id='printBtn'>인쇄</button>
				<button class="btn btn-secondary" type="button" id="deleteBtn">삭제</button>
				<button class="btn btn-secondary" type="button" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>