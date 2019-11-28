<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- <script type="text/javascript">
	function changeView(element) {
		let id = $(element).attr("id");

		$.ajax({
			url : id,
			type : "get",
			success : function(res) {
				$("#layoutContent").html(res);
			},
			error : function(request, status, error) {
				alert(
        "code:" +
          request.status +
          "\n" +
          "message:" +
          request.responseText +
          "\n" +
          "error:" +
          error
      );
			}
		})
	}
</script> -->

<aside class="main-sidebar elevation-4 sidebar-dark-yellow">
	<!-- Brand Logo -->
	<sec:authorize access="isAuthenticated()">
		<a href="/home" id="/home" class="brand-link navbar-purple"> <img
			src="/static/dist/img/AdminLTELogo.png" alt="AdminLTE Logo"
			class="brand-image img-circle elevation-3" style="opacity: .8">
			<span class="brand-text font-weight-bold">PathFinder</span>
		</a>
		<!-- Sidebar -->
		<div class="sidebar">
			<!-- Sidebar user panel (optional) -->
			<div class="user-panel mt-3 pb-3 mb-3 d-flex">
				<div class="image">
					<img src="/static/dist/img/user2-160x160.jpg"
						class="img-circle elevation-2" alt="User Image">
				</div>
				<div class="info">
					<a href="/userinfo" class="d-block"> <!-- 로그인한 유저 정보 가져오기 --> <sec:authentication
							property="principal.userFullName" />
					</a>
				</div>
			</div>

			<!-- Sidebar Menu -->
			<nav class="mt-2">
				<ul class="nav nav-pills nav-sidebar flex-column nav-legacy"
					data-widget="treeview" role="menu" data-accordion="false">


					<!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->


					<li class="nav-header">사용자 메뉴</li>

					<li class="nav-item"><a id="home" href="#"
						class="menu nav-link" onclick="pageSubmitFn('home')"> <i
							class="nav-icon fas fa-tachometer-alt"></i>
							<p>홈</p>
					</a></li>

					<li class="nav-item"><a id="maproute" href="#"
						class="menu nav-link" onclick="pageSubmitFn('maproute')"> <i
							class="nav-icon fas fa-truck"></i>
							<p>경로탐색</p>
					</a></li>

					<li class="nav-item"><a id="history" href="#" class="menu nav-link"
						onclick="pageSubmitFn('history')"> <i
							class="nav-icon fas fa-book"></i>
							<p>조회내역</p>
					</a></li>

					<li class="nav-item"><a id="hierarchy" href="#"
						class="menu nav-link" onclick="pageSubmitFn('hierarchy')"> <i
							class="nav-icon fas fa-table"></i>
							<p>조직도</p>
					</a></li>

					<!-- 권한이 관리자인 사용자만 표시 -->
					<sec:authorize access="hasRole('ADMIN')">
						<li class="nav-header">관리자 메뉴</li>
						<li class="nav-item has-treeview"><a id="#" class="nav-link">
								<i class="nav-icon fas fa-cogs"></i>
								<p>
									관리자 설정 <i class="right fas fa-angle-left"></i>
								</p>
						</a>
							<ul class="nav nav-treeview">
								<li class="nav-item"><a href="#"
									onclick="subMenuSubmit('usermanage')" class="nav-link"> <i
										class="submenu far fa-circle nav-icon"></i>
										<p>사용자 관리</p>
								</a></li>
								<li class="nav-item"><a href="#"
									onclick="subMenuSubmit('branchmanage')" class="nav-link ">
										<i class="submenu far fa-circle nav-icon"></i>
										<p>지점 관리</p>
								</a></li>
								<li class="nav-item"><a href="#"
									onclick="subMenuSubmit('carmanage')" class="nav-link"> <i
										class="submenu far fa-circle nav-icon"></i>
										<p>차량 관리</p>
								</a></li>
							</ul></li>
					</sec:authorize>
				</ul>
			</nav>
			<!-- /.sidebar-menu -->
		</div>
		<!-- /.sidebar -->
	</sec:authorize>
</aside>

<script>
	const pageSubmitFn = function(menu) {
		if (menu === "home") {
			location.href = "/home?pageName=home";
		} else if (menu === "maproute") {
			location.href = "/maproute?pageName=maproute";
		} else if (menu === "history") {
			location.href = "/history?pageName=history";
		} else if (menu === "hierarchy") {
			location.href = "/hierarchy?pageName=hierarchy";
		}
	}
	const subMenuSubmit = function(menu) {
		if (menu === "usermanage") {
			location.href = "/admin/usermanage?pageName=usermanage";

		} else if (menu === "branchmanage") {
			location.href = "/admin/branchmanage?pageName=branchmanage ";

		} else if (menu === "carmanage") {
			location.href = "/admin/carmanage?pageName=carmanage";
		}
	}

	$(function() {

			console.log("asd");
			$(".menu").removeClass("active");
			var pageName = "<c:out value = '${param.pageName}' />";
			$("#" + pageName).addClass("active")
	})
	
	/* 	function subChange() {
	 $(".submenu").removeClass(" far fa-circle");
	 var pageName = "<c:out value = '${param.pageName}' />";
	 $("#" + pageName).addClass(" fas fa-circle");
	 } */
</script>