<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>

  <head>
    <title>지점 관리 페이지</title>
  </head>
  <body>
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-md-2 col-md-6">
            <h1>지점 관리</h1>
          </div>
          <div class="col-md-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item">관리자 메뉴</li>
              <li class="breadcrumb-item active">지점 관리</li>
            </ol>
          </div>
        </div>
      </div>
      <!-- /.container-fluid -->
    </section>


    <section class="content">
      <div class="container-fluid ">
        <div class="row vh-80">
          <div class="col-md-2">
            <div class="card height100">
              <div class="card-header">
                <h3 class="card-title" style="height: 30px">조직도</h3>
              </div>

              <div class="card-body small height675px">
                <div
                  id="jstree"
                  class="myScrollableBlock scrollbar-outer"
                ></div>
              </div>
            </div>
          </div>

          <div class="col-md-10">
            <div class="card height100 ">
              <div class="card-header">
                <button
                  class=" btn btn-sm bg-olive"
                  data-toggle="modal"
                  data-target="#insertModal"
                >
                  지점 추가
                </button>

                <div class="card-tools">
                  <div class="input-group input-group-sm">
                    <select
                      class="col-4 small"
                      name="searchType"
                      id="searchType"
                    >
                      <option value="branchName" class="small">지점명</option>
                      <option value="branchAddr" class="small">주소</option>
										</select>
										
                    <input
                      class="col-sm-7 form-control form-control-navbar"
                      type="search"
                      placeholder="Search"
                      name="keyword"
                      id="keyword"
                      onkeypress="searchEnter()"
                    />
                    <div class="input-group-append">
                      <button
                        onclick="searchClick()"
                        class="btn btn-sm bg-olive"
                        name="btnSearch"
                        id="btnSearch"
                      >
                        <i class="fas fa-search"></i>
                      </button>
                    </div>
                  </div>
                </div>
              </div>


						<div
							class="card-body box-profile table-responsive p-0">
							<table class="table table-hover" id="tableTest">
								<thead class="theadblock">
									<tr>
										<th style="width: 8%">지역</th>
										<th style="width: 12%">지점명</th>
										<th style="width: 7%">지점장</th>
										<th style="width: 28%">주소</th>
										<th style="width: 15%">전화번호</th>
										<th style="width: 15%">운반비</th>
										<th style="width: 10%">수정/삭제</th>
									</tr>
								</thead>
								<tbody id="tableListBody" class="small"></tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			<div id="page"></div>
		</div>
	</section>
	
	<style rel="stylesheet" type="text/css">





@media screen and (max-width: 500px) {

.theadblock { background-color: #327a81; color: white; font-size: 1em; padding: 0 0 5px 70px; text-align: left; text-transform: uppercase;}

.table, tr, td { display: block; }

.table td:first-child { position: absolute; top: 50%; -webkit-transform: translateY(-50%);   transform: translateY(-50%); }

.table td:not(:first-child) { clear: both; margin-left: 100px; padding: 4px 20px 4px 90px; position: relative; text-align: center; }

.table td:not(:first-child):before { color: #91ced4; content: ''; display: block; left: 0; position: absolute; text-align: left; }

.table td:last-child { text-align: left; width:320px;}

.table td:nth-child(2):before { content: '지점명'; }

.table td:nth-child(3):before { content: '지점장'; }

.table td:nth-child(4):before { content: '주소'; }

.table td:nth-child(5):before { content: '전화번호'; }

.table td:nth-child(6):before { content: '운반비'; }

.table td:nth-child(7):before { content: '수정/삭제'; }

.table tr { padding: 10px 0; position: relative;  overflow: auto;}

.table tr:first-child { display: none;  }}

</style>

</body>


  <%@include file="/WEB-INF/jsp/alert.jsp" %> <%@include
  file="branchManageModal.jsp"%>

  <script src="/static/js/adminBranchManage.js"></script>
</html>
