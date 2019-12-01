<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="modal fade" id="detailsModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel">상세정보</h4>
			</div>
			<div class="modal-body">
				<h4 id="index">번호</h4>
				<h6 id="regdate"></h6>
				<h6 id="username"></h6>
				<hr>
				<h6 id="depandarvl"></h6>
				<table class="table table-hover" id="tableTest">
					<thead>
						<tr>
							<th style="width: 10%">번호</th>
							<th style="width: 10%">출발지</th>
							<th style="width: 10%">도착지</th>
							<th style="width: 10%">거리</th>
							<th style="width: 10%">시간</th>
							<th style="width: 10%">비용</th>
						</tr>
					</thead>
					<tbody id="routesListBody" class="small"></tbody>
				</table>
			</div>
			<div class="modal-footer">
				<h6 id="dist"></h6>
				<h6>총 시간: 00:10:00</h6>
				<h6 id="fee"></h6>
				<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>