<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
</head>
<body>Hierarchy
<body>
	<div class="container-fluid">
		<div class="row">
			<div class="col-3">
				<div class="card">
					<div class="card-header">
						<b>부서 조직도</b>
					</div>
					<div class="card-body">
							<div id="jstree">
							</div>
					</div>
					</div>
				</div>
			<div class="col-9">
				<div class="card">
					<div class="card-header">
						<b>사용자 리스트</b>
					</div>
					<div class="card-body">
						<table class="table table-hover table-mc-light-blue"
							style="text-align: center; boarder: 1px solid #ddddd">
							<thead>
								<tr>
									<th style="background-color: #fafafa; text-align: center;">아이디</th>
									<th style="background-color: #fafafa; text-align: center;">이름</th>
									<th style="background-color: #fafafa; text-align: center;">직책</th>
									<th style="background-color: #fafafa; text-align: center;">이메일</th>
									<th style="background-color: #fafafa; text-align: center;">전화번호</th>
								</tr>
							</thead>
							<tbody id="userTable" style="font-size : 65%"/>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
			function getUser(id) {
				$.ajax({
					url : "/hierarchy/getuser",
					type : "GET",
					data : {
						"id" : id
					},
					dataType : "json",
					success : function(data) {
						var str = '<tr>';
						$.each(data, function(i, s) {
							str +=  
							'<td>'+ data[i].userId +'</td>' +
							'<td>'+ data[i].userName +'</td>' +
							'<td>'+ data[i].userPosition +'</td>' +
							'<td>'+ data[i].userEmail +'</td>' +
							'<td>'+ data[i].userPhone +'</td>' +
							'</tr>';
						});
						$("#userTable").html(str);
					},
					error : function(error) {
						console.log(error);
					}
				});
			}
			
			$(function() {
				$('#jstree').jstree({
					'plugins': ["wholerow"],
					'core' : {
						'themes' : {
							'name' : 'proton',
							'reponsive' : true
						},
						'data' : {
							"url" : "/hierarchy/gettree",
							"data" : function(node) {
								return {"id" : node.id};
							}
						}
					}
				});
				
				$('#jstree').on("changed.jstree", function(e, data) {
					var i, j, r = [];
					for (i = 0, j = data.selected.length; i < j; i++) {
						r.push(data.instance.get_node(data.selected[i]).id);
					}

					getUser(r.join(', '));
				});
			});
	</script>
</body>
</html>