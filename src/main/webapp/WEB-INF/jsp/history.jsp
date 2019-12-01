<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Document</title>
</head>
<body>
	<section class="content-header">
		<div class="container-fluid">
			<div class="row mb-2">
				<div class="col-md-2 col-md-6">
					<h1>조회내역</h1>
				</div>
				<div class="col-md-6">
					<ol class="breadcrumb float-sm-right">
						<li class="breadcrumb-item"><a href="#">사용자 메뉴</a></li>
						<li class="breadcrumb-item active">조회내역</li>
					</ol>
				</div>
			</div>
		</div>
		<!-- /.container-fluid -->
	</section>
	<div class="container-fluid ">
		<div class="card height100">

			<div class="card-header">
			
			<button class=" btn btn-primary btn-sm bg-gradient-primary "
								data-toggle="modal" data-target="#detailsModal">상세보기</button>
				<div class="card-tools ">
					<div class="input-group input-group-sm">
						<select class=" col-4 small " name="searchType" id="searchType">
							<option value="branchName" class="small">등록날짜</option>
							<option value="branchAddr" class="small">차량이름</option>
							<option value="branchAddr" class="small">출발지</option>
							<option value="branchAddr" class="small">도착지</option>
							<option value="branchAddr" class="small">사용자</option>

						</select> <input class="col-sm-7 form-control form-control-navbar"
							type="search" placeholder="Search" name="keyword" id="keyword" />
						<div class="input-group-append">
							<button class="btn btn-primary btn-sm" name="btnSearch"
								id="btnSearch">
								<i class="fas fa-search"></i>
							</button>

						</div>
					</div>
				</div>
			</div>

			<div class="card-body box-profile table-responsive p-0 height700px">
				<table class="table table-hover" id="tableTest">
					<thead>
						<tr>
							<th style="width: 10%">출발일자</th>
							<th style="width: 10%">사용자</th>
							<th style="width: 10%">출발지</th>
							<th style="width: 10%">도착지</th>
							<th style="width: 10%">차량번호</th>
							<th style="width: 10%">예약일자</th>
							<th style="width: 10%">상세보기</th>
						</tr>
					</thead>

					<tbody id="tableListBody" class="small"></tbody>

            <div class="card">
              <div class="card-header p-2">
                <ul class="nav nav-pills">
                  <li class="nav-item"><a class="nav-link" href="#todayList" data-toggle="tab">오늘거</a></li>
                  <li class="nav-item"><a class="nav-link active" href="#afterList" data-toggle="tab">이후꺼</a></li>
                  <li class="nav-item"><a class="nav-link" href="#beforeList" data-toggle="tab">이전꺼</a></li>
                </ul>
              </div><!-- /.card-header -->
              <div class="card-body">
                <div class="tab-content">
                  <div class="tab-pane" id="todayList">
                    <!-- Post -->
                    <div class="post">
                      <div class="user-block">
                        <img class="img-circle img-bordered-sm" src="../../dist/img/user1-128x128.jpg" alt="user image">
                        <span class="username">
                          <a href="#">Jonathan Burke Jr.</a>
                          <a href="#" class="float-right btn-tool"><i class="fas fa-times"></i></a>
                        </span>
                        <span class="description">Shared publicly - 7:30 PM today</span>
                      </div>
                      <!-- /.user-block -->
                      <p>
                        Lorem ipsum represents a long-held tradition for designers,
                        typographers and the like. Some people hate it and argue for
                        its demise, but others ignore the hate as they create awesome
                        tools to help create filler text for everyone from bacon lovers
                        to Charlie Sheen fans.
                      </p>

                      <p>
                        <a href="#" class="link-black text-sm mr-2"><i class="fas fa-share mr-1"></i> Share</a>
                        <a href="#" class="link-black text-sm"><i class="far fa-thumbs-up mr-1"></i> Like</a>
                        <span class="float-right">
                          <a href="#" class="link-black text-sm">
                            <i class="far fa-comments mr-1"></i> Comments (5)
                          </a>
                        </span>
                      </p>

                      <input class="form-control form-control-sm" type="text" placeholder="Type a comment">
                    </div>
                    <!-- /.post -->

                    <!-- Post -->
                    <div class="post clearfix">
                      <div class="user-block">
                        <img class="img-circle img-bordered-sm" src="../../dist/img/user7-128x128.jpg" alt="User Image">
                        <span class="username">
                          <a href="#">Sarah Ross</a>
                          <a href="#" class="float-right btn-tool"><i class="fas fa-times"></i></a>
                        </span>
                        <span class="description">Sent you a message - 3 days ago</span>
                      </div>
                      <!-- /.user-block -->
                      <p>
                        Lorem ipsum represents a long-held tradition for designers,
                        typographers and the like. Some people hate it and argue for
                        its demise, but others ignore the hate as they create awesome
                        tools to help create filler text for everyone from bacon lovers
                        to Charlie Sheen fans.
                      </p>

                      <form class="form-horizontal">
                        <div class="input-group input-group-sm mb-0">
                          <input class="form-control form-control-sm" placeholder="Response">
                          <div class="input-group-append">
                            <button type="submit" class="btn btn-danger">Send</button>
                          </div>
                        </div>
                      </form>
                    </div>
                    <!-- /.post -->

                    <!-- Post -->
                    <div class="post">
                      <div class="user-block">
                        <img class="img-circle img-bordered-sm" src="../../dist/img/user6-128x128.jpg" alt="User Image">
                        <span class="username">
                          <a href="#">Adam Jones</a>
                          <a href="#" class="float-right btn-tool"><i class="fas fa-times"></i></a>
                        </span>
                        <span class="description">Posted 5 photos - 5 days ago</span>
                      </div>
                      <!-- /.user-block -->
                      <div class="row mb-3">
                        <div class="col-sm-6">
                          <img class="img-fluid" src="../../dist/img/photo1.png" alt="Photo">
                        </div>
                        <!-- /.col -->
                        <div class="col-sm-6">
                          <div class="row">
                            <div class="col-sm-6">
                              <img class="img-fluid mb-3" src="../../dist/img/photo2.png" alt="Photo">
                              <img class="img-fluid" src="../../dist/img/photo3.jpg" alt="Photo">
                            </div>
                            <!-- /.col -->
                            <div class="col-sm-6">
                              <img class="img-fluid mb-3" src="../../dist/img/photo4.jpg" alt="Photo">
                              <img class="img-fluid" src="../../dist/img/photo1.png" alt="Photo">
                            </div>
                            <!-- /.col -->
                          </div>
                          <!-- /.row -->
                        </div>
                        <!-- /.col -->
                      </div>
                      <!-- /.row -->

                      <p>
                        <a href="#" class="link-black text-sm mr-2"><i class="fas fa-share mr-1"></i> Share</a>
                        <a href="#" class="link-black text-sm"><i class="far fa-thumbs-up mr-1"></i> Like</a>
                        <span class="float-right">
                          <a href="#" class="link-black text-sm">
                            <i class="far fa-comments mr-1"></i> Comments (5)
                          </a>
                        </span>
                      </p>

                      <input class="form-control form-control-sm" type="text" placeholder="Type a comment">
                    </div>
                    <!-- /.post -->
                  </div>
                  <!-- /.tab-pane -->
                  <div class="tab-pane active" id="afterList">
                    <!-- The timeline -->
                    <div class="timeline timeline-inverse">
                      <!-- timeline time label -->
                      <div class="time-label">
                        <span class="bg-danger">
                          10 Feb. 2014
                        </span>
                      </div>
                      <!-- /.timeline-label -->
                      <!-- timeline item -->
                      <div>
                        <i class="fas fa-envelope bg-primary"></i>

                        <div class="timeline-item">
                          <span class="time"><i class="far fa-clock"></i> 12:05</span>

                          <h3 class="timeline-header"><a href="#">Support Team</a> sent you an email</h3>

                          <div class="timeline-body">
                            Etsy doostang zoodles disqus groupon greplin oooj voxy zoodles,
                            weebly ning heekya handango imeem plugg dopplr jibjab, movity
                            jajah plickers sifteo edmodo ifttt zimbra. Babblely odeo kaboodle
                            quora plaxo ideeli hulu weebly balihoo...
                          </div>
                          <div class="timeline-footer">
                            <a href="#" class="btn btn-primary btn-sm">Read more</a>
                            <a href="#" class="btn btn-danger btn-sm">Delete</a>
                          </div>
                        </div>
                      </div>
                      <!-- END timeline item -->
                      <!-- timeline item -->
                      <div>
                        <i class="fas fa-user bg-info"></i>

                        <div class="timeline-item">
                          <span class="time"><i class="far fa-clock"></i> 5 mins ago</span>

                          <h3 class="timeline-header border-0"><a href="#">Sarah Young</a> accepted your friend request
                          </h3>
                        </div>
                      </div>
                      <!-- END timeline item -->
                      <!-- timeline item -->
                      <div>
                        <i class="fas fa-comments bg-warning"></i>

                        <div class="timeline-item">
                          <span class="time"><i class="far fa-clock"></i> 27 mins ago</span>

                          <h3 class="timeline-header"><a href="#">Jay White</a> commented on your post</h3>

                          <div class="timeline-body">
                            Take me to your leader!
                            Switzerland is small and neutral!
                            We are more like Germany, ambitious and misunderstood!
                          </div>
                          <div class="timeline-footer">
                            <a href="#" class="btn btn-warning btn-flat btn-sm">View comment</a>
                          </div>
                        </div>
                      </div>
                      <!-- END timeline item -->
                      <!-- timeline time label -->
                      <div class="time-label">
                        <span class="bg-success">
                          3 Jan. 2014
                        </span>
                      </div>
                      <!-- /.timeline-label -->
                      <!-- timeline item -->
                      <div>
                        <i class="fas fa-camera bg-purple"></i>

                        <div class="timeline-item">
                          <span class="time"><i class="far fa-clock"></i> 2 days ago</span>

                          <h3 class="timeline-header"><a href="#">Mina Lee</a> uploaded new photos</h3>

                          <div class="timeline-body">
                            <img src="http://placehold.it/150x100" alt="...">
                            <img src="http://placehold.it/150x100" alt="...">
                            <img src="http://placehold.it/150x100" alt="...">
                            <img src="http://placehold.it/150x100" alt="...">
                          </div>
                        </div>
                      </div>
                      <!-- END timeline item -->
                      <div>
                        <i class="far fa-clock bg-gray"></i>
                      </div>
                    </div>
                  </div>
                  <!-- /.tab-pane -->


                  <div class="tab-pane" id="beforeList">
                    <form class="form-horizontal">
                      <div class="form-group row">
                        <label for="inputName" class="col-sm-2 col-form-label">Name</label>
                        <div class="col-sm-10">
                          <input type="email" class="form-control" id="inputName" placeholder="Name">
                        </div>
                      </div>
                      <div class="form-group row">
                        <label for="inputEmail" class="col-sm-2 col-form-label">Email</label>
                        <div class="col-sm-10">
                          <input type="email" class="form-control" id="inputEmail" placeholder="Email">
                        </div>
                      </div>
                      <div class="form-group row">
                        <label for="inputName2" class="col-sm-2 col-form-label">Name</label>
                        <div class="col-sm-10">
                          <input type="text" class="form-control" id="inputName2" placeholder="Name">
                        </div>
                      </div>
                      <div class="form-group row">
                        <label for="inputExperience" class="col-sm-2 col-form-label">Experience</label>
                        <div class="col-sm-10">
                          <textarea class="form-control" id="inputExperience" placeholder="Experience"></textarea>
                        </div>
                      </div>
                      <div class="form-group row">
                        <label for="inputSkills" class="col-sm-2 col-form-label">Skills</label>
                        <div class="col-sm-10">
                          <input type="text" class="form-control" id="inputSkills" placeholder="Skills">
                        </div>
                      </div>
                      <div class="form-group row">
                        <div class="offset-sm-2 col-sm-10">
                          <div class="checkbox">
                            <label>
                              <input type="checkbox"> I agree to the <a href="#">terms and conditions</a>
                            </label>
                          </div>
                        </div>
                      </div>
                      <div class="form-group row">
                        <div class="offset-sm-2 col-sm-10">
                          <button type="submit" class="btn btn-danger">Submit</button>
                        </div>
                      </div>
                    </form>
                  </div>
                  <!-- /.tab-pane -->
                </div>
                <!-- /.tab-content -->
              </div><!-- /.card-body -->
            </div>
            <!-- /.nav-tabs-custom -->
          </div>
				</table>
				<div id="page"></div>
			</div>
		</div>
	</div>

</body>
<%@include file="historyModal.jsp"%>

<script src="/static/js/history.js"></script>
<script src="/static/js/hisoryModal.js"></script>
</html>