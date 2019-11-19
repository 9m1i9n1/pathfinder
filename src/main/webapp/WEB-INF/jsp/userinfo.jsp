<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
	
<!DOCTYPE html>
<html>
<head>
<title>Document</title>
</head>
<body>
<section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>Profile</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">User Profile</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>
	<section class="content">
		<div class="container-fluid">
			<div class="row">
				<div class="col-md-5">

					<!-- Profile Image -->
					<div class="card card-primary card-outline">
						<div class="card-body box-profile">
							<div class="text-center">
							<div class="ribbon-wrapper ribbon-rg">
                        <div class="ribbon bg-info text-rg">
                          Info
                        </div>
                      </div>
								<img class="profile-user-img img-fluid img-circle elevation-2"
									src="https://imgnn.seoul.co.kr/img//upload/2017/01/24/SSI_20170124151021_V.jpg"
									alt="User profile picture">
							</div>
							<h3 class="profile-username text-center"><sec:authentication property="principal.userFullName"/></h3>
							<p class="text-muted text-center">회사이름</p>

							<ul class="list-group list-group-unbordered mb-3">
								<li class="ml-3 mr-3 list-group-item"><b>이름</b> <a
									class="float-right mr-3"><sec:authentication property="principal.userFullName"/></a></li>
								<li class="ml-3 mr-3 list-group-item"><b>ID</b> <a
									class="float-right mr-3"><sec:authentication property="principal.username"/></a></li>
								<li class="ml-3 mr-3 list-group-item"><b>이메일</b> <a
									class="float-right mr-3"><sec:authentication property="principal.userEmail"/></a></li>
								<li class="ml-3 mr-3 list-group-item"><b>전화번호</b> <a
									class="float-right mr-3"><sec:authentication property="principal.userPhone"/></a></li>
							</ul>

						</div>
						<!-- /.card-body -->
					</div>
					<!-- /.card -->

					<!-- About Me Box -->
					<div class="card card-primary">
						<div class="card-header">
							<h3 class="card-title">About Me</h3>
						</div>
						<!-- /.card-header -->
						<div class="card-body">

							<strong><i class="fas fa-map-marker-alt mr-1"></i>
								Location</strong>

							<p class="text-muted ml-4 mr-3"><sec:authentication property="principal.userArea"/></p>
							<hr>

							<strong><i class="fas fa-hotel mr-1"></i> Branch</strong>

							<p class="text-muted">
								<span class="tag tag-danger ml-4 mr-3"><sec:authentication property="principal.userBranch"/></span>
							</p>

							<hr>
							<strong><i class="fas fa-user mr-1"></i>Position</strong>

							<p class="text-muted ml-4 mr-3"><sec:authentication property="principal.userPosition"/></p>

							<hr>
							<strong><i class="fas fa-user-cog mr-1"></i>
								Authorization</strong>
							<p class="text-muted ml-4 mr-3"><sec:authentication property="principal.authorities"/></p>
							<hr>
						</div>
						<!-- /.card-body -->
					</div>
					<!-- /.card -->
				</div>
				<!-- /.col -->
				<div class="col-md-7">
					<div class="card">
						<div class="widget-user-header bg-teal"><div class="nav-link" ><h4><b>Settings</b></h4></div></div>
						<!-- /.card-header -->
						
						<div class="card-body">
							<div class="tab-pane" id="settings">
								<form class="form-horizontal">
									<div class="form-group row">
										<label for="inputName" class="col-sm-2 col-form-label">이름</label>
										<div class="col-sm-10">
											<input type="email" class="form-control" id="inputName"
												placeholder="Name" readonly>
										</div>
									</div>
									<div class="form-group row">
										<label for="inputID" class="col-sm-2 col-form-label">아이디</label>
										<div class="col-sm-10">
											<input type="email" class="form-control" id="inputId"
												placeholder="ID" readonly>
										</div>
									</div>
									<div class="form-group row">
										<label for="inputPassword" class="col-sm-2 col-form-label">비밀번호</label>
										<div class="col-sm-10">
											<input type="text" class="form-control" id="inputPassword"
												placeholder="Password">
										</div>
									</div>
										<div class="form-group row">
										<label for="inputPasswordCheck" class="col-sm-2 col-form-label">비밀번호 확인</label>
										<div class="col-sm-10">
											<input type="text" class="form-control" id="inputPasswordCheck"
												placeholder="PasswordCheck">
										</div>
									</div>
									<div class="form-group row">
										<label for="inputEmail" class="col-sm-2 col-form-label">이메일</label>
										<div class="col-sm-10">
											<input type="text" class="form-control" id="inputEmail"
												placeholder="Email">
										</div>
									</div>
									<div class="form-group row">
										<label for="inputPhone" class="col-sm-2 col-form-label">전화번호</label>
										<div class="col-sm-10">
											<input type="text" class="form-control" id="inputLocation"
												placeholder="Phone">
										</div>
									</div>
									<div class="form-group row">
										<div class="offset-sm-2 col-sm-10">
											<button type="submit" class="btn btn-danger float-right">수정</button>
										</div>
									</div>
								</form>
							</div>
							<div class="tab-content">

								<!-- /.tab-pane -->

								<!-- /.tab-pane -->
							</div>
							<!-- /.tab-content -->
						</div>
						<!-- /.card-body -->
					</div>
					<!-- /.nav-tabs-custom -->
				</div>
				<!-- /.col -->
			</div>
			<!-- /.row -->
		</div>
		<!-- /.container-fluid -->
	</section>
</body>
</html>