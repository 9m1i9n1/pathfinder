<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
$(function() {
	setNavigation();
})

function setNavigation() {
	let path = window.location.pathname;

	splitUrl = path.split('/');
	let [depth1, depth2] = ['/' + splitUrl[1], splitUrl[2]]
	
	$(".nav .nav-link").each(function() {
		let href = $(this).attr('href');
		
		if(path.substring(0, href.length) === href) {
			$(this).addClass('active');

			if(depth2 !== undefined) {
				$('#adminmenu').addClass('menu-open')
				$('#adminmenu #adminmenu-sub').addClass('active')
			}
		}
	})
}
</script>

<aside class="main-sidebar elevation-4 sidebar-dark-secondary">
	<!-- Brand Logo -->
	<sec:authorize access="isAuthenticated()">
		<a href="/home" id="/home" class="brand-link navbar-olive"> <img
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
					<a href="<c:url value='/logout'/>">로그아웃</a>
				</div>
			</div>

			<!-- Sidebar Menu -->
			<nav class="mt-2">
				<ul class="nav nav-pills nav-sidebar flex-column nav-flat"
					data-widget="treeview" role="menu" data-accordion="false">


					<!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->


					<li class="nav-header">사용자 메뉴</li>

					<li class="nav-item"><a id="home" href="/home"
						class="menu nav-link"> <i
							class="nav-icon fas fa-tachometer-alt"></i>
							<p>홈</p>
					</a></li>

					<li class="nav-item"><a id="maproute" href="/maproute"
						class="menu nav-link"> <i
							class="nav-icon fas fa-truck"></i>
							<p>경로탐색</p>
					</a></li>

					<li class="nav-item"><a id="history" href="/history" class="menu nav-link"
						> <i
							class="nav-icon fas fa-book"></i>
							<p>조회내역</p>
					</a></li>

					<li class="nav-item"><a id="hierarchy" href="/hierarchy"
						class="menu nav-link"> <i
							class="nav-icon fas fa-table"></i>
							<p>조직도</p>
					</a></li>

					<!-- 권한이 관리자인 사용자만 표시 -->
					<sec:authorize access="hasRole('ADMIN')">
						<li class="nav-header">관리자 메뉴</li>
						<li class="nav-item has-treeview" id="adminmenu"><a class="nav-link" id="#adminmenu-sub" href="#">
								<i class="nav-icon fas fa-cogs"></i>
								<p>
									관리자 설정 <i class="right fas fa-angle-left"></i>
								</p>
						</a>
							<ul class="nav nav-treeview">
								<li class="nav-item"><a href="/admin/usermanage"
									 class="nav-link"> <i
										class="submenu far fa-circle nav-icon"></i>
										사용자 관리
								</a></li>
								<li class="nav-item"><a href="/admin/branchmanage"
									 class="nav-link ">
										<i class="submenu far fa-circle nav-icon"></i>
										지점 관리
								</a></li>
								<li class="nav-item"><a href="/admin/carmanage"
									 class="nav-link"> <i
										class="submenu far fa-circle nav-icon"></i>
										차량 관리
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
