<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

	  <aside class="main-sidebar elevation-4 sidebar-dark-yellow">
    <!-- Brand Logo -->
    <a href="/home" class="brand-link navbar-olive">
      <img src="/static/dist/img/AdminLTELogo.png" alt="AdminLTE Logo" class="brand-image img-circle elevation-3"
           style="opacity: .8">
      <span class="brand-text font-weight-light">PathFinder</span>
    </a>

    <!-- Sidebar -->
    <div class="sidebar">
      <!-- Sidebar user panel (optional) -->
      <div class="user-panel mt-3 pb-3 mb-3 d-flex">
        <div class="image">
          <img src="/static/dist/img/user2-160x160.jpg" class="img-circle elevation-2" alt="User Image">
        </div>
        <div class="info">
          <a href="#" class="d-block">정지원못생겼다는 거짓말</a>
        </div>
      </div>

      <!-- Sidebar Menu -->
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column nav-legacy" data-widget="treeview" role="menu" data-accordion="false">
          <!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->
					<li class="nav-header">사용자 메뉴</li>
          
          <li class="nav-item">
            <a href="/home" class="nav-link active">
              <i class="nav-icon fas fa-tachometer-alt"></i>
              <p>
                홈
              </p>
            </a>
          </li>

					<li class="nav-item">
            <a href="/maproute" class="nav-link">
              <i class="nav-icon fas fa-truck"></i>
              <p>
                경로탐색
              </p>
            </a>
          </li>

					<li class="nav-item">
            <a href="/history" class="nav-link">
              <i class="nav-icon fas fa-book"></i>
              <p>
                조회내역
              </p>
            </a>
          </li>

					<li class="nav-item">
            <a href="/hierarchy" class="nav-link">
              <i class="nav-icon fas fa-table"></i>
              <p>
                조직도
              </p>
            </a>
          </li>

          <li class="nav-header">관리자 메뉴</li>

          <li class="nav-item has-treeview">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-cogs"></i>
              <p>
                관리자 설정
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="/admin/usermanage" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>사용자 관리</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="/admin/branchmanage" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>지점 관리</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="/admin/carmanage" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>차량 관리</p>
                </a>
              </li>
            </ul>
          </li>
        </ul>
      </nav>
      <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
  </aside>