<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<ul class="sidebar navbar-nav toggled">
	<li class="nav-item active"><a class="nav-link" id="/home">
			<i class="fas fa-fw fa-tachometer-alt"></i> <span>메인화면</span>
	</a>
	</li>
	<li class="nav-item"><a class="nav-link" id="/maproute"> <i
			class="fas fa-fw fa-chart-area"></i> <span>경로탐색</span></a></li>
	<li class="nav-item"><a class="nav-link" id="/history"> <i
			class="fas fa-fw fa-table"></i> <span>조회내역</span></a></li>
	<li class="nav-item"><a class="nav-link" id="/hierarchy"> <i
			class="fas fa-fw fa-table"></i> <span>조직도</span></a></li>
	<li class="nav-item dropdown"><a class="nav-link dropdown-toggle"
		href="#" id="pagesDropdown" role="button" data-toggle="dropdown"
		aria-haspopup="true" aria-expanded="false"> <i
			class="fas fa-fw fa-folder"></i> <span>관리자 설정</span>
	</a>
		<div class="dropdown-menu" aria-labelledby="pagesDropdown">
			<a class="dropdown-item" href="/admin/usermanage">사용자 관리</a>
			<a class="dropdown-item"
				href="/admin/branchmanage">지점 관리</a>
			<a class="dropdown-item" href="/admin/carmanage">차량 관리</a>
		</div></li>
</ul>

<script type="text/javascript">
	/* 수정필요 */
	$(document).ready(function () {
		$('a').click(function() {
			$.ajax({
				url : this.id + "/ajax",
			    type: "get",
			    beforeSend: function(req) {
			  	  req.setRequestHeader("Authorization", "pathfinder " + document.cookie.substring(6));
			    },
		        success : function(res) {
		        	console.log(res);
		        	$(document).html(res);
			      /* $("#content-wrapper").html(res); */
			    },
			    error : function(e) {
			      console.log(e);
			    }
			})
		})
	})
</script>