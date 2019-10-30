<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<div class="col-3">
				<div id="jstree">
				</div>
			</div>
			<div class="col-9">
				<table class="table"
					style="text-align: center; boarder: 1px solid #ddddd">
					<thead>
						<tr>
							<th style="background-color: #fafafa; text-align: center;">이름</th>
							<th style="background-color: #fafafa; text-align: center;">나이</th>
							<th style="background-color: #fafafa; text-align: center;">성별</th>
							<th style="background-color: #fafafa; text-align: center;">이메일</th>
						</tr>
					</thead>
					<tbody id="ajaxTable">
					</tbody>
				</table>
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
						console.log(data);
					},
					error : function(error) {
						console.log(error);
					}
				});
			}
			
			$(function() {
				$('#jstree').jstree({
					'core' : {
						'data' : {
							"url" : "/hierarchy/gettree",
							"data" : function(node) {
								console.log(node);
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