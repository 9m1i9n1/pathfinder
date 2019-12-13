<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Document</title>

<!-- Toggle checkbox -->
<link
	href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css"
	rel="stylesheet">
<script
	src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>
<!-- PAGE SCRIPTS -->
<script src="/static/dist/js/pages/dashboard2.js"></script>
</head>
<body>
	<!-- Content Header (Page header) -->
	<div class="content-header">
		<div class="container-fluid">
			<div class="row mb-2">
				<div class="col-sm-6">
					<h1 class="m-0 text-dark">Dashboard v2</h1>
				</div>
				<!-- /.col -->
				<div class="col-sm-6">
					<ol class="breadcrumb float-sm-right">
						<li class="breadcrumb-item"><a href="#">Home</a></li>
						<li class="breadcrumb-item active">Dashboard v2</li>
					</ol>
				</div>
				<!-- /.col -->
			</div>
			<!-- /.row -->
		</div>
		<!-- /.container-fluid -->
	</div>
	<!-- /.content-header -->

	<!-- Main content -->
	<section class="content">
		<div class="container-fluid">
			<!-- Info boxes -->
			<div class="row">
				<div class="col-12 col-sm-6 col-md-3">
					<div class="info-box">
						<span class="info-box-icon bg-info elevation-1"> <i
							class="fas fa-shipping-fast"></i></span>

						<div class="info-box-content">
							<span class="info-box-text">오늘의 배송 현황</span> <span
								class="info-box-number" id="todayPercent"> </span>
						</div>
						<!-- /.info-box-content -->
					</div>
					<!-- /.info-box -->
				</div>
				<!-- /.col -->
				<div class="col-12 col-sm-6 col-md-3">
					<div class="info-box mb-3">
						<span class="info-box-icon bg-danger elevation-1"><i
							class="fas fa-users"></i></span>

						<div class="info-box-content">
							<span class="info-box-text">전체 사용자</span> <span
								class="info-box-number" id="userCount"></span>
						</div>
						<!-- /.info-box-content -->
					</div>
					<!-- /.info-box -->
				</div>
				<!-- /.col -->

				<!-- fix for small devices only -->
				<div class="clearfix hidden-md-up"></div>

				<div class="col-12 col-sm-6 col-md-3">
					<div class="info-box mb-3">
						<span class="info-box-icon bg-success elevation-1"> <i
							class="far fa-building"></i></span>

						<div class="info-box-content">
							<span class="info-box-text">지점</span> <span
								class="info-box-number" id="branchCount"></span>
						</div>
						<!-- /.info-box-content -->
					</div>
					<!-- /.info-box -->
				</div>
				<!-- /.col -->
				<div class="col-12 col-sm-6 col-md-3">
					<div class="info-box mb-3">
						<span class="info-box-icon bg-warning elevation-1"> <i
							class="fas fa-history"></i></span>

						<div class="info-box-content">
							<span class="info-box-text">기록</span> <span
								class="info-box-number" id="totalHistoryCount"></span>
						</div>
						<!-- /.info-box-content -->
					</div>
					<!-- /.info-box -->
				</div>
				<!-- /.col -->
			</div>
			<!-- /.row -->



			<!-- Main row -->
			<div class="row">
				<!-- Left col -->
				<div class="col-md-8">
					<!-- MAP & BOX PANE -->
					<div class="card">
						<div class="card-header">
							<h3 class="card-title">지역별 운반비</h3>

							<div class="card-tools">
								<button type="button" class="btn btn-tool"
									data-card-widget="collapse">
									<i class="fas fa-minus"></i>
								</button>
								<button type="button" class="btn btn-tool"
									data-card-widget="remove">
									<i class="fas fa-times"></i>
								</button>
							</div>
						</div>
						<!-- /.card-header -->
						<div class="card-body p-0">
							<div
								class="row text-center justify-content-center align-items-center pr-5">
								<div class="col-md-5 ">
									<div>
										<div id="canvas" class="col-md-4">
											<div id="south"></div>
											<div id="seoul"></div>
											<div id="gygg"></div>
											<div id="incheon"></div>
											<div id="gangwon"></div>
											<div id="chungbuk"></div>
											<div id="chungnam"></div>
											<div id="daejeon"></div>
											<div id="sejong"></div>
											<div id="gwangju"></div>
											<div id="jeonbuk"></div>
											<div id="jeonnam"></div>
											<div id="gyeongbuk"></div>
											<div id="gyeongnam"></div>
											<div id="daegu"></div>
											<div id="busan"></div>
											<div id="ulsan"></div>
											<div id="jeju"></div>
										</div>
									</div>
								</div>
								<div class="col-md-7 justify-content-center align-items-center"
									id="branchFeeChartP">
									<!-- 여기가 옆쪽 -->
									<canvas id="branchFeeChart"
										class="chartjs-render-monitor col-md-8 "></canvas>
								</div>
							</div>
							<!-- /.d-md-flex -->
						</div>
						<!-- /.card-body -->
					</div>
					<!-- /.card -->
					<div class="row">
						<div class="col-md-12">
							<!-- USERS LIST -->
							<div class="card">
								<div class="card-header">
									<h3 class="card-title">Schedule</h3>

									<div class="card-tools">
										<button type="button" class="btn btn-tool"
											data-card-widget="collapse">
											<i class="fas fa-minus"></i>
										</button>
										<button type="button" class="btn btn-tool"
											data-card-widget="remove">
											<i class="fas fa-times"></i>
										</button>
									</div>
								</div>
								<!-- /.card-header -->
								<div class="card-body p-0">
									<ul class="nav nav-pills">
										<li class="nav-item"><a class="nav-link active"
											href="#todayHistory" data-toggle="tab"
											onclick="todayHistory()">오늘의 스케쥴</a></li>
										<li class="nav-item"><a class="nav-link"
											href="#recentlyHistory" data-toggle="tab"
											onclick="recentlyHistory()">나의 히스토리</a></li>
									</ul>
									<div class="table-responsive">
										<table class="table m-0">

											<thead>
												<tr>
													<th></th>
													<th>출발일자</th>
													<th>도착일자</th>
													<th>사용자</th>
													<th>출발지</th>
													<th>도착지</th>
													<th>차량번호</th>
												</tr>
											</thead>
											<tbody id="schedule">
											</tbody>
										</table>
									</div>
									<!-- /.table-responsive -->
									<!-- /.users-list -->
								</div>
								<!-- /.card-body -->
								<div class="card-footer text-center">
									<a href="/history" class="btn btn-sm btn-secondary float-right">전체보기</a>
								</div>
								<!-- /.card-footer -->
							</div>
							<!--/.card -->
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.col -->

				<div class="col-md-4">
					<div class="row ">
						<div class="col-md-12">
							<div class="card">
								<div class="card-header">
									<h5 class="card-title">최근 배송 현황(1 Month)</h5>

									<div class="card-tools">
										<input id="myDelivery" type="checkbox" data-toggle="toggle"
											data-size="small" data-on="내 배송송" data-off="전체" />
										<button type="button" class="btn btn-tool"
											data-card-widget="collapse">
											<i class="fas fa-minus"></i>
										</button>
										<button type="button" class="btn btn-tool"
											data-card-widget="remove">
											<i class="fas fa-times"></i>
										</button>
									</div>
								</div>
								<!-- /.card-header -->
								<div class="card-body">
									<div class="row">
										<div class="col-md-12">
											<div id="doughnutDiv" class="canvas">
												<!-- Sales Chart Canvas -->
												<canvas id="chart-area" class="chart-js-render-monitor"></canvas>
											</div>
											<!-- /.chart-responsive -->
										</div>
									</div>
									<!-- /.col -->
									<div class="row">
										<div class="col-md-12">
											<p class="text-center">
												<strong>진행현황</strong>
											</p>

											<div class="progress-group">
												배송예정 <span id="willProgress" class="float-right"></span>
												<div class="progress progress-sm active">
													<div id="willDiv" class="progress-bar bg-danger"></div>
												</div>
											</div>
											<!-- /.progress-group -->

											<div class="progress-group">
												배송중 <span id="ingProgress" class="float-right"></span>
												<div class="progress progress-sm active">
													<div id="ingDiv" class="progress-bar bg-warning"></div>
												</div>
											</div>

											<!-- /.progress-group -->
											<div class="progress-group">
												<span class="progress-text">배송완료</span> <span
													id="ppProgress" class="float-right"></span>
												<div class="progress progress-sm active">
													<div id="ppDiv" class="progress-bar bg-success"></div>
												</div>
											</div>
											<!-- /.progress-group -->
										</div>
										<!-- /.col -->

									</div>
									<!-- /.row -->
								</div>
								<!-- ./card-body -->
								<!-- <div class="card-footer">
							<div class="row">
								<div class="col-sm-3 col-6">
									<div class="description-block border-right">
										<span class="description-percentage text-success"><i
											class="fas fa-caret-up"></i> 17%</span>
										<h5 class="description-header">$35,210.43</h5>
										<span class="description-text">TOTAL REVENUE</span>
									</div>
									/.description-block
								</div>
								/.col
								<div class="col-sm-3 col-6">
									<div class="description-block border-right">
										<span class="description-percentage text-warning"><i
											class="fas fa-caret-left"></i> 0%</span>
										<h5 class="description-header">$10,390.90</h5>
										<span class="description-text">TOTAL COST</span>
									</div>
									/.description-block
								</div>
								/.col
								<div class="col-sm-3 col-6">
									<div class="description-block border-right">
										<span class="description-percentage text-success"><i
											class="fas fa-caret-up"></i> 20%</span>
										<h5 class="description-header">$24,813.53</h5>
										<span class="description-text">TOTAL PROFIT</span>
									</div>
									/.description-block
								</div>
								/.col
								<div class="col-sm-3 col-6">
									<div class="description-block">
										<span class="description-percentage text-danger"><i
											class="fas fa-caret-down"></i> 18%</span>
										<h5 class="description-header">1200</h5>
										<span class="description-text">GOAL COMPLETIONS</span>
									</div>
									/.description-block
								</div>
							</div>
							/.row
						</div> -->
								<!-- /.card-footer -->
							</div>
							<!-- /.card -->
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->

					<!-- 슬라이드 -->
					<div class="row ">
						<div class="col-md-12">
							<div class="card">
								<!-- div class="card-header">
									<h3 class="card-title">Carousel</h3>
								</div> -->
								<!-- /.card-header -->
								<div class="card-body">
									<div id="carouselExampleIndicators" class="carousel slide"
										data-ride="carousel">
										<ol class="carousel-indicators">
											<li data-target="#carouselExampleIndicators"
												data-slide-to="0" class=""></li>
											<li data-target="#carouselExampleIndicators"
												data-slide-to="1" class="active"></li>
											<li data-target="#carouselExampleIndicators"
												data-slide-to="2" class=""></li>
										</ol>
										<div class="carousel-inner">
											<div class="carousel-item">
												<img class="d-block w-100" 
													src="https://placehold.it/900x500/3333CC/ffffff&amp;text=PathFinder"
													alt="First slide">
											</div>
											<div class="carousel-item active" >
												<a href="http://www.douzone.com/">
												 <img
													class="d-block w-100"
													src="http://imgnews.naver.net/image/5046/2018/06/01/0000071590_001_20180601151004593.jpg"
													alt="Second slide">
												</a>
												홈페이지 바로가기
											</div>
											<div class="carousel-item">

												<img class="d-block w-100"
													src="https://placehold.it/900x500/f39c12/ffffff&amp;text=PathFinder"
													alt="Third slide">

											</div>
										</div>
										<a class="carousel-control-prev"
											href="#carouselExampleIndicators" role="button"
											data-slide="prev"> <span
											class="carousel-control-prev-icon" aria-hidden="true"></span>
											<span class="sr-only">Previous</span>
										</a> <a class="carousel-control-next"
											href="#carouselExampleIndicators" role="button"
											data-slide="next"> <span
											class="carousel-control-next-icon" aria-hidden="true"></span>
											<span class="sr-only">Next</span>
										</a>
									</div>
								</div>
								<!-- /.card-body -->
							</div>
						</div>
					</div>
					<!-- 슬라이드끝1 -->


				</div>
				<!-- /.col -->
			</div>
			<!-- /.row -->
		</div>
		<!--/. container-fluid -->
	</section>
	<!-- /.content -->

	<!--  한국지도 -->
	<script type="text/javascript" src="/static/js/test/raphael_min.js"></script>
	<script type="text/javascript"
		src="/static/js/test/raphael_path_s.korea.js"></script>
	<script>
		var sca = '01';
	</script>

	<style>
</style>

</body>
<script src="/static/js/home.js"></script>
</html>