<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<ul class="sidebar navbar-nav">
	<li class="nav-item active"><a class="nav-link" href="http://localhost:8181/">
			<i class="fas fa-fw fa-tachometer-alt"></i> <span>메인화면</span>
	</a>
	</li>
	<li class="nav-item"><a class="nav-link" href="http://localhost:8181/maproute"> <i
			class="fas fa-fw fa-chart-area"></i> <span>경로탐색</span></a></li>
	<li class="nav-item"><a class="nav-link" href="http://localhost:8181/history"> <i
			class="fas fa-fw fa-table"></i> <span>조회내역</span></a></li>
	<li class="nav-item"><a class="nav-link" href="http://localhost:8181/hierarchy"> <i
			class="fas fa-fw fa-table"></i> <span>조직도</span></a></li>
	<li class="nav-item dropdown"><a class="nav-link dropdown-toggle"
		href="#" id="pagesDropdown" role="button" data-toggle="dropdown"
		aria-haspopup="true" aria-expanded="false"> <i
			class="fas fa-fw fa-folder"></i> <span>관리자 설정</span>
	</a>
		<div class="dropdown-menu" aria-labelledby="pagesDropdown">
			<a class="dropdown-item" href="http://localhost:8181/admin/usermanage">사용자 관리</a>
			<a class="dropdown-item"
				href="http://localhost:8181/admin/branchmanage">지점 관리</a>
			<a class="dropdown-item" href="http://localhost:8181/admin/carmanage">차량 관리</a>
		</div></li>
</ul>