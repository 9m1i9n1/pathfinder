<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<title>Document</title>
</head>
<body>
	<div id="content-wrapper">
		<div class="container-fluid">
			Hierarchy
			<div id="jstree"/>

			<script type="text/javascript">
				$(function() {
					$('#jstree').jstree({
						'core' : {
							'data' : {
								"url" : "//www.jstree.com/fiddle/",
								"dataType" : "json"
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