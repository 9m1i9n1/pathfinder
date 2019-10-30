<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<title>Document</title>
</head>
<body>Hierarchy
<body>
	<div id="content-wrapper">
		<div class="container-fluid">
			Hierarchy
			<div id="jstreee"/>

			<script type="text/javascript">
				$(function() {
					$('#jstreee').jstree({
						'core' : {
							'data' : {
								"url" : "/hierarchy/tree",
								"data" : function(node) {
									console.log(node);
									return {"id" : node.id};
								}
							}
						}
					});
					$('#jstree').on("changed.jstree", function(e, data) {
						console.log(data.selected);
					});
				});
			</script>
		</div>
	</div>
</body>
</html>