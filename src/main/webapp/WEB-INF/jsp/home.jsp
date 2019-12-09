<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Document</title>

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
						<span class="info-box-icon bg-info elevation-1"><i
							class="fas fa-cog"></i></span>

						<div class="info-box-content">
							<span class="info-box-text">오늘의 배송 현황</span> <span
								class="info-box-number" id="todayPercent"> 10 <small>%</small>
							</span>
						</div>
						<!-- /.info-box-content -->
					</div>
					<!-- /.info-box -->
				</div>
				<!-- /.col -->
				<div class="col-12 col-sm-6 col-md-3">
					<div class="info-box mb-3">
						<span class="info-box-icon bg-danger elevation-1"><i
							class="fas fa-thumbs-up"></i></span>

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
						<span class="info-box-icon bg-success elevation-1"><i
							class="fas fa-shopping-cart"></i></span>

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
						<span class="info-box-icon bg-warning elevation-1"><i
							class="fas fa-users"></i></span>

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

			<div class="row">
				<div class="col-md-12">
					<div class="card">
						<div class="card-header">
							<h5 class="card-title">최근 배송 현황(1 Month)</h5>

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
						<div class="card-body">
							<div class="row">
								<div class="col-md-8">
									<div class="canvas">
										<!-- Sales Chart Canvas -->
										<canvas id="chart-area" class="chart-js-render-monitor"></canvas>
									</div>
									<!-- /.chart-responsive -->
								</div>
								<!-- /.col -->
								<div class="col-md-4">
									<p class="text-center">
										<strong>진행현황</strong>
									</p>

									<div class="progress-group">
										배송예정 
										<span id="willProgress" class="float-right"></span>
										<div class="progress progress-sm">
											<div id="willDiv" class="progress-bar bg-danger"></div>
										</div>
									</div>
									<!-- /.progress-group -->

									<div class="progress-group">
										배송중
										<span id="ingProgress" class="float-right"></span>
										<div class="progress progress-sm">
											<div id="ingDiv" class="progress-bar bg-warning"></div>
										</div>
									</div>

									<!-- /.progress-group -->
									<div class="progress-group">
										<span class="progress-text">배송완료</span>
										<span id="ppProgress" class="float-right"></span>
										<div class="progress progress-sm">
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

			<!-- Main row -->
			<div class="row">
				<!-- Left col -->
				<div class="col-md-8">
					<!-- MAP & BOX PANE -->
					<div class="card">
						<div class="card-header">
							<h3 class="card-title">US-Visitors Report</h3>

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
							<div class="d-md-flex">
								<div class="p-1 flex-fill" style="overflow: hidden">
									<!-- Map will be created here -->
									<div id="world-map-markers"
										style="height: 325px; overflow: hidden">
										<div class="map"></div>
									</div>
								</div>
								<div class="card-pane-right bg-success pt-2 pb-2 pl-4 pr-4">
									<div class="description-block mb-4">
										<div class="sparkbar pad" data-color="#fff">90,70,90,70,75,80,70</div>
										<h5 class="description-header">8390</h5>
										<span class="description-text">Visits</span>
									</div>
									<!-- /.description-block -->
									<div class="description-block mb-4">
										<div class="sparkbar pad" data-color="#fff">90,50,90,70,61,83,63</div>
										<h5 class="description-header">30%</h5>
										<span class="description-text">Referrals</span>
									</div>
									<!-- /.description-block -->
									<div class="description-block">
										<div class="sparkbar pad" data-color="#fff">90,50,90,70,61,83,63</div>
										<h5 class="description-header">70%</h5>
										<span class="description-text">Organic</span>
									</div>
									<!-- /.description-block -->
								</div>
								<!-- /.card-pane-right -->
							</div>
							<!-- /.d-md-flex -->
						</div>
						<!-- /.card-body -->
					</div>
					<!-- /.card -->
					<div class="row">
						<div class="col-md-6">
							<!-- DIRECT CHAT -->
							<div class="card direct-chat direct-chat-warning">
								<div class="card-header">
									<h3 class="card-title">Direct Chat</h3>

									<div class="card-tools">
										<span data-toggle="tooltip" title="3 New Messages"
											class="badge badge-warning">3</span>
										<button type="button" class="btn btn-tool"
											data-card-widget="collapse">
											<i class="fas fa-minus"></i>
										</button>
										<button type="button" class="btn btn-tool"
											data-toggle="tooltip" title="Contacts"
											data-widget="chat-pane-toggle">
											<i class="fas fa-comments"></i>
										</button>
										<button type="button" class="btn btn-tool"
											data-card-widget="remove">
											<i class="fas fa-times"></i>
										</button>
									</div>
								</div>
								<!-- /.card-header -->
								<div class="card-body">
									<!-- Conversations are loaded here -->
									<div class="direct-chat-messages">
										<!-- Message. Default to the left -->
										<div class="direct-chat-msg">
											<div class="direct-chat-infos clearfix">
												<span class="direct-chat-name float-left">Alexander
													Pierce</span> <span class="direct-chat-timestamp float-right">23
													Jan 2:00 pm</span>
											</div>
											<!-- /.direct-chat-infos -->
											<img class="direct-chat-img"
												src="/static/dist/img/user1-128x128.jpg"
												alt="message user image">
											<!-- /.direct-chat-img -->
											<div class="direct-chat-text">Is this template really
												for free? That's unbelievable!</div>
											<!-- /.direct-chat-text -->
										</div>
										<!-- /.direct-chat-msg -->

										<!-- Message to the right -->
										<div class="direct-chat-msg right">
											<div class="direct-chat-infos clearfix">
												<span class="direct-chat-name float-right">Sarah
													Bullock</span> <span class="direct-chat-timestamp float-left">23
													Jan 2:05 pm</span>
											</div>
											<!-- /.direct-chat-infos -->
											<img class="direct-chat-img"
												src="/static/dist/img/user3-128x128.jpg"
												alt="message user image">
											<!-- /.direct-chat-img -->
											<div class="direct-chat-text">You better believe it!</div>
											<!-- /.direct-chat-text -->
										</div>
										<!-- /.direct-chat-msg -->

										<!-- Message. Default to the left -->
										<div class="direct-chat-msg">
											<div class="direct-chat-infos clearfix">
												<span class="direct-chat-name float-left">Alexander
													Pierce</span> <span class="direct-chat-timestamp float-right">23
													Jan 5:37 pm</span>
											</div>
											<!-- /.direct-chat-infos -->
											<img class="direct-chat-img"
												src="/static/dist/img/user1-128x128.jpg"
												alt="message user image">
											<!-- /.direct-chat-img -->
											<div class="direct-chat-text">Working with AdminLTE on
												a great new app! Wanna join?</div>
											<!-- /.direct-chat-text -->
										</div>
										<!-- /.direct-chat-msg -->

										<!-- Message to the right -->
										<div class="direct-chat-msg right">
											<div class="direct-chat-infos clearfix">
												<span class="direct-chat-name float-right">Sarah
													Bullock</span> <span class="direct-chat-timestamp float-left">23
													Jan 6:10 pm</span>
											</div>
											<!-- /.direct-chat-infos -->
											<img class="direct-chat-img"
												src="/static/dist/img/user3-128x128.jpg"
												alt="message user image">
											<!-- /.direct-chat-img -->
											<div class="direct-chat-text">I would love to.</div>
											<!-- /.direct-chat-text -->
										</div>
										<!-- /.direct-chat-msg -->

									</div>
									<!--/.direct-chat-messages-->

									<!-- Contacts are loaded here -->
									<div class="direct-chat-contacts">
										<ul class="contacts-list">
											<li><a href="#"> <img class="contacts-list-img"
													src="/static/dist/img/user1-128x128.jpg">

													<div class="contacts-list-info">
														<span class="contacts-list-name"> Count Dracula <small
															class="contacts-list-date float-right">2/28/2015</small>
														</span> <span class="contacts-list-msg">How have you been?
															I was...</span>
													</div> <!-- /.contacts-list-info -->
											</a></li>
											<!-- End Contact Item -->
											<li><a href="#"> <img class="contacts-list-img"
													src="/static/dist/img/user7-128x128.jpg">

													<div class="contacts-list-info">
														<span class="contacts-list-name"> Sarah Doe <small
															class="contacts-list-date float-right">2/23/2015</small>
														</span> <span class="contacts-list-msg">I will be waiting
															for...</span>
													</div> <!-- /.contacts-list-info -->
											</a></li>
											<!-- End Contact Item -->
											<li><a href="#"> <img class="contacts-list-img"
													src="/static/dist/img/user3-128x128.jpg">

													<div class="contacts-list-info">
														<span class="contacts-list-name"> Nadia Jolie <small
															class="contacts-list-date float-right">2/20/2015</small>
														</span> <span class="contacts-list-msg">I'll call you back
															at...</span>
													</div> <!-- /.contacts-list-info -->
											</a></li>
											<!-- End Contact Item -->
											<li><a href="#"> <img class="contacts-list-img"
													src="/static/dist/img/user5-128x128.jpg">

													<div class="contacts-list-info">
														<span class="contacts-list-name"> Nora S. Vans <small
															class="contacts-list-date float-right">2/10/2015</small>
														</span> <span class="contacts-list-msg">Where is your
															new...</span>
													</div> <!-- /.contacts-list-info -->
											</a></li>
											<!-- End Contact Item -->
											<li><a href="#"> <img class="contacts-list-img"
													src="/static/dist/img/user6-128x128.jpg">

													<div class="contacts-list-info">
														<span class="contacts-list-name"> John K. <small
															class="contacts-list-date float-right">1/27/2015</small>
														</span> <span class="contacts-list-msg">Can I take a look
															at...</span>
													</div> <!-- /.contacts-list-info -->
											</a></li>
											<!-- End Contact Item -->
											<li><a href="#"> <img class="contacts-list-img"
													src="/static/dist/img/user8-128x128.jpg">

													<div class="contacts-list-info">
														<span class="contacts-list-name"> Kenneth M. <small
															class="contacts-list-date float-right">1/4/2015</small>
														</span> <span class="contacts-list-msg">Never mind I
															found...</span>
													</div> <!-- /.contacts-list-info -->
											</a></li>
											<!-- End Contact Item -->
										</ul>
										<!-- /.contacts-list -->
									</div>
									<!-- /.direct-chat-pane -->
								</div>
								<!-- /.card-body -->
								<div class="card-footer">
									<form action="#" method="post">
										<div class="input-group">
											<input type="text" name="message"
												placeholder="Type Message ..." class="form-control">
											<span class="input-group-append">
												<button type="button" class="btn btn-warning">Send</button>
											</span>
										</div>
									</form>
								</div>
								<!-- /.card-footer-->
							</div>
							<!--/.direct-chat -->
						</div>
						<!-- /.col -->

						<div class="col-md-6">
							<!-- USERS LIST -->
							<div class="card">
								<div class="card-header">
									<h3 class="card-title">Latest Members</h3>

									<div class="card-tools">
										<span class="badge badge-danger">8 New Members</span>
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
									<ul class="users-list clearfix">
										<li><img src="/static/dist/img/user1-128x128.jpg"
											alt="User Image"> <a class="users-list-name" href="#">Alexander
												Pierce</a> <span class="users-list-date">Today</span></li>
										<li><img src="/static/dist/img/user8-128x128.jpg"
											alt="User Image"> <a class="users-list-name" href="#">Norman</a>
											<span class="users-list-date">Yesterday</span></li>
										<li><img src="/static/dist/img/user7-128x128.jpg"
											alt="User Image"> <a class="users-list-name" href="#">Jane</a>
											<span class="users-list-date">12 Jan</span></li>
										<li><img src="/static/dist/img/user6-128x128.jpg"
											alt="User Image"> <a class="users-list-name" href="#">John</a>
											<span class="users-list-date">12 Jan</span></li>
										<li><img src="/static/dist/img/user2-160x160.jpg"
											alt="User Image"> <a class="users-list-name" href="#">Alexander</a>
											<span class="users-list-date">13 Jan</span></li>
										<li><img src="/static/dist/img/user5-128x128.jpg"
											alt="User Image"> <a class="users-list-name" href="#">Sarah</a>
											<span class="users-list-date">14 Jan</span></li>
										<li><img src="/static/dist/img/user4-128x128.jpg"
											alt="User Image"> <a class="users-list-name" href="#">Nora</a>
											<span class="users-list-date">15 Jan</span></li>
										<li><img src="/static/dist/img/user3-128x128.jpg"
											alt="User Image"> <a class="users-list-name" href="#">Nadia</a>
											<span class="users-list-date">15 Jan</span></li>
									</ul>
									<!-- /.users-list -->
								</div>
								<!-- /.card-body -->
								<div class="card-footer text-center">
									<a href="javascript::">View All Users</a>
								</div>
								<!-- /.card-footer -->
							</div>
							<!--/.card -->
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->

					<!-- TABLE: LATEST ORDERS -->
					<div class="card">
						<div class="card-header border-transparent">
							<h3 class="card-title">Latest Orders</h3>

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
							<div class="table-responsive">
								<table class="table m-0">
									<thead>
										<tr>
											<th>Order ID</th>
											<th>Item</th>
											<th>Status</th>
											<th>Popularity</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td><a href="pages/examples/invoice.html">OR9842</a></td>
											<td>Call of Duty IV</td>
											<td><span class="badge badge-success">Shipped</span></td>
											<td>
												<div class="sparkbar" data-color="#00a65a" data-height="20">90,80,90,-70,61,-83,63</div>
											</td>
										</tr>
										<tr>
											<td><a href="pages/examples/invoice.html">OR1848</a></td>
											<td>Samsung Smart TV</td>
											<td><span class="badge badge-warning">Pending</span></td>
											<td>
												<div class="sparkbar" data-color="#f39c12" data-height="20">90,80,-90,70,61,-83,68</div>
											</td>
										</tr>
										<tr>
											<td><a href="pages/examples/invoice.html">OR7429</a></td>
											<td>iPhone 6 Plus</td>
											<td><span class="badge badge-danger">Delivered</span></td>
											<td>
												<div class="sparkbar" data-color="#f56954" data-height="20">90,-80,90,70,-61,83,63</div>
											</td>
										</tr>
										<tr>
											<td><a href="pages/examples/invoice.html">OR7429</a></td>
											<td>Samsung Smart TV</td>
											<td><span class="badge badge-info">Processing</span></td>
											<td>
												<div class="sparkbar" data-color="#00c0ef" data-height="20">90,80,-90,70,-61,83,63</div>
											</td>
										</tr>
										<tr>
											<td><a href="pages/examples/invoice.html">OR1848</a></td>
											<td>Samsung Smart TV</td>
											<td><span class="badge badge-warning">Pending</span></td>
											<td>
												<div class="sparkbar" data-color="#f39c12" data-height="20">90,80,-90,70,61,-83,68</div>
											</td>
										</tr>
										<tr>
											<td><a href="pages/examples/invoice.html">OR7429</a></td>
											<td>iPhone 6 Plus</td>
											<td><span class="badge badge-danger">Delivered</span></td>
											<td>
												<div class="sparkbar" data-color="#f56954" data-height="20">90,-80,90,70,-61,83,63</div>
											</td>
										</tr>
										<tr>
											<td><a href="pages/examples/invoice.html">OR9842</a></td>
											<td>Call of Duty IV</td>
											<td><span class="badge badge-success">Shipped</span></td>
											<td>
												<div class="sparkbar" data-color="#00a65a" data-height="20">90,80,90,-70,61,-83,63</div>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
							<!-- /.table-responsive -->
						</div>
						<!-- /.card-body -->
						<div class="card-footer clearfix">
							<a href="javascript:void(0)"
								class="btn btn-sm btn-info float-left">Place New Order</a> <a
								href="javascript:void(0)"
								class="btn btn-sm btn-secondary float-right">View All Orders</a>
						</div>
						<!-- /.card-footer -->
					</div>
					<!-- /.card -->
				</div>
				<!-- /.col -->

				<div class="col-md-4">
					<!-- Info Boxes Style 2 -->
					<div class="info-box mb-3 bg-warning">
						<span class="info-box-icon"><i class="fas fa-tag"></i></span>

						<div class="info-box-content">
							<span class="info-box-text">Inventory</span> <span
								class="info-box-number">5,200</span>
						</div>
						<!-- /.info-box-content -->
					</div>
					<!-- /.info-box -->
					<div class="info-box mb-3 bg-success">
						<span class="info-box-icon"><i class="far fa-heart"></i></span>

						<div class="info-box-content">
							<span class="info-box-text">Mentions</span> <span
								class="info-box-number">92,050</span>
						</div>
						<!-- /.info-box-content -->
					</div>
					<!-- /.info-box -->
					<div class="info-box mb-3 bg-danger">
						<span class="info-box-icon"><i
							class="fas fa-cloud-download-alt"></i></span>

						<div class="info-box-content">
							<span class="info-box-text">Downloads</span> <span
								class="info-box-number">114,381</span>
						</div>
						<!-- /.info-box-content -->
					</div>
					<!-- /.info-box -->
					<div class="info-box mb-3 bg-info">
						<span class="info-box-icon"><i class="far fa-comment"></i></span>

						<div class="info-box-content">
							<span class="info-box-text">Direct Messages</span> <span
								class="info-box-number">163,921</span>
						</div>
						<!-- /.info-box-content -->
					</div>
					<!-- /.info-box -->

					<div class="card">
						<div class="card-header">
							<h3 class="card-title">Browser Usage</h3>

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
						<div class="card-body">
							<div class="row">
								<div class="col-md-8">
									<div class="chart-responsive">
										<canvas id="pieChart" height="150"></canvas>
									</div>
									<!-- ./chart-responsive -->
								</div>
								<!-- /.col -->
								<div class="col-md-4">
									<ul class="chart-legend clearfix">
										<li><i class="far fa-circle text-danger"></i> Chrome</li>
										<li><i class="far fa-circle text-success"></i> IE</li>
										<li><i class="far fa-circle text-warning"></i> FireFox</li>
										<li><i class="far fa-circle text-info"></i> Safari</li>
										<li><i class="far fa-circle text-primary"></i> Opera</li>
										<li><i class="far fa-circle text-secondary"></i>
											Navigator</li>
									</ul>
								</div>
								<!-- /.col -->
							</div>
							<!-- /.row -->
						</div>
						<!-- /.card-body -->
						<div class="card-footer bg-white p-0">
							<ul class="nav nav-pills flex-column">
								<li class="nav-item"><a href="#" class="nav-link">
										United States of America <span class="float-right text-danger">
											<i class="fas fa-arrow-down text-sm"></i> 12%
									</span>
								</a></li>
								<li class="nav-item"><a href="#" class="nav-link">
										India <span class="float-right text-success"> <i
											class="fas fa-arrow-up text-sm"></i> 4%
									</span>
								</a></li>
								<li class="nav-item"><a href="#" class="nav-link">
										China <span class="float-right text-warning"> <i
											class="fas fa-arrow-left text-sm"></i> 0%
									</span>
								</a></li>
							</ul>
						</div>
						<!-- /.footer -->
					</div>
					<!-- /.card -->

					<!-- PRODUCT LIST -->
					<div class="card">
						<div class="card-header">
							<h3 class="card-title">Recently Added Products</h3>

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
							<ul class="products-list product-list-in-card pl-2 pr-2">
								<li class="item">
									<div class="product-img">
										<img src="/static/dist/img/default-150x150.png"
											alt="Product Image" class="img-size-50">
									</div>
									<div class="product-info">
										<a href="javascript:void(0)" class="product-title">Samsung
											TV <span class="badge badge-warning float-right">$1800</span>
										</a> <span class="product-description"> Samsung 32" 1080p
											60Hz LED Smart HDTV. </span>
									</div>
								</li>
								<!-- /.item -->
								<li class="item">
									<div class="product-img">
										<img src="/static/dist/img/default-150x150.png"
											alt="Product Image" class="img-size-50">
									</div>
									<div class="product-info">
										<a href="javascript:void(0)" class="product-title">Bicycle
											<span class="badge badge-info float-right">$700</span>
										</a> <span class="product-description"> 26" Mongoose
											Dolomite Men's 7-speed, Navy Blue. </span>
									</div>
								</li>
								<!-- /.item -->
								<li class="item">
									<div class="product-img">
										<img src="/static/dist/img/default-150x150.png"
											alt="Product Image" class="img-size-50">
									</div>
									<div class="product-info">
										<a href="javascript:void(0)" class="product-title"> Xbox
											One <span class="badge badge-danger float-right"> $350
										</span>
										</a> <span class="product-description"> Xbox One Console
											Bundle with Halo Master Chief Collection. </span>
									</div>
								</li>
								<!-- /.item -->
								<li class="item">
									<div class="product-img">
										<img src="/static/dist/img/default-150x150.png"
											alt="Product Image" class="img-size-50">
									</div>
									<div class="product-info">
										<a href="javascript:void(0)" class="product-title">PlayStation
											4 <span class="badge badge-success float-right">$399</span>
										</a> <span class="product-description"> PlayStation 4 500GB
											Console (PS4) </span>
									</div>
								</li>
								<!-- /.item -->
							</ul>
						</div>
						<!-- /.card-body -->
						<div class="card-footer text-center">
							<a href="javascript:void(0)" class="uppercase">View All
								Products</a>
						</div>
						<!-- /.card-footer -->
					</div>
					<!-- /.card -->
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
#canvas {
	float: left;
	position: relative;
	width: 320px;
	height: 400px;
	margin: 0
}

#south {
	width: 320px;
	height: 400px;
	position: absolute;
	top: 0px;
	left: 0;
}

#canvas h2 {
	padding: 0;
	margin: 0;
	font-size: 12px;
}

#seoul, #gygg, #incheon, #gangwon, #chungbuk, #chungnam, #daejeon,
	#sejong, #jeonbuk, #jeonnam, #gwangju, #gyeongbuk, #gyeongnam, #daegu,
	#busan, #ulsan, #jeju {
	display: none;
	position: absolute;
	height: 16px;
	background-color: #000;
	color: #fff;
	padding: 2px 5px;
	text-align: center;
}

/* #seoul{ left:80px; top:75px; }
#gygg{ left:80px; top:45px; }
#incheon{ left:60px; top:75px; }
#gangwon{ left:150px; top:45px; }
#chungbuk{ left:120px; top:145px; }
#chungnam{ left:60px; top:165px; }
#daejeon{ left:80px; top:165px; }
#sejong{ left:70px; top:145px; }
#jeonbuk{ left:60px; top:205px; }
#jeonnam{ left:60px; top:260px; }
#gwangju{ left:	60px; top:260px; }
#gyeongbuk{ left:150px; top:165px; }
#gyeongnam{ left:130px; top:240px; }
#daegu{ left:170px; top:210px; }
#busan{ left:190px; top:250px; }
#ulsan{ left:200px; top:225px; }
#jeju{ left:80px; top:340px; } */
</style>

	<div style="width: 100%; height: 400px;">
		<div id="canvas">
			<div id="south"></div>
			<div id="seoul">
				<h2>서울특별시</h2>
			</div>
			<div id="gygg">
				<h2>경기도</h2>
			</div>
			<div id="incheon">
				<h2>인천광역시</h2>
			</div>
			<div id="gangwon">
				<h2>강원도</h2>
			</div>
			<div id="chungbuk">
				<h2>충청북도</h2>
			</div>
			<div id="chungnam">
				<h2>충청남도</h2>
			</div>
			<div id="daejeon">
				<h2>대전광역시</h2>
			</div>
			<div id="sejong">
				<h2>세종특별자치시</h2>
			</div>
			<div id="gwangju">
				<h2>광주광역시</h2>
			</div>
			<div id="jeonbuk">
				<h2>전라북도</h2>
			</div>
			<div id="jeonnam">
				<h2>전라남도</h2>
			</div>
			<div id="gyeongbuk">
				<h2>경상북도</h2>
			</div>
			<div id="gyeongnam">
				<h2>경상남도</h2>
			</div>
			<div id="daegu">
				<h2>대구광역시</h2>
			</div>
			<div id="busan">
				<h2>부산광역시</h2>
			</div>
			<div id="ulsan">
				<h2>울산광역시</h2>
			</div>
			<div id="jeju">
				<h2>제주특별자치도</h2>
			</div>
		</div>
	</div>

	<div class="card">
		<div class="card-header border-transparent">
			<h3 class="card-title">잇힝 잇힝 &gt_&ltv</h3>
			<div class="card-tools">
				<button type="button" class="btn btn-tool"
					data-card-widget="collapse">
					<i class="fas fa-minus"></i>
				</button>
				<button type="button" class="btn btn-tool" data-card-widget="remove">
					<i class="fas fa-times"></i>
				</button>
			</div>
		</div>

		<!-- /.card-header -->
		<div class="card-body p-0">
			<ul class="nav nav-pills">
				<li class="nav-item"><a class="nav-link active"
					href="#todayHistory" data-toggle="tab" onclick="todayHistory()">오늘의
						스케쥴</a></li>
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
		</div>
		<!-- /.card-body -->
		<div class="card-footer clearfix">
			<a href="/history" class="btn btn-sm btn-secondary float-right">전체보기</a>
		</div>
		<!-- /.card-footer -->
	</div>

</body>
<script src="/static/js/home.js"></script>
</html>