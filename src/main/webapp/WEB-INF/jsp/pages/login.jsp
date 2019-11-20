<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Document</title>
<!-- CSS -->
<link rel="stylesheet"
	href="http://fonts.googleapis.com/css?family=Roboto:400,100,300,500">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.min.css">
<link rel="stylesheet" href="static/css/login/form-elements.css">
<link rel="stylesheet" href="static/css/login/login-style.css">
</head>
<body>
	<!-- Top content -->
	<div class="top-content">
		<div class="inner-bg">
			<div class="container">
				<div class="row justify-content-center">
					<div class="col-sm-8 col-sm-offset-2 text">
						<h1>
							<strong>PathFinder</strong>
						</h1>
						<div class="description">
<!-- 							<strong>
								계정 관련 문의는 지점 담당자에게 문의하시기 바랍니다.
							</strong> -->
						</div>
					</div>
				</div>
				<div class="row justify-content-center">
					<div class="col-sm-6 col-sm-offset-3 form-box">
						<div class="form-top">
							<div class="form-top-left">
								<h3>Login</h3>
								<p>계정 관련 문의는 관리자에게 연락 부탁드립니다.</p>
							</div>
							<div class="form-top-right">
								<i class="fa fa-key"></i>
							</div>
						</div>
						<div class="form-bottom">
							<form role="form" action="<c:url value="/authenticate.do"/>" method="post" class="login-form">
								<div class="form-group">
									<label class="sr-only" for="form-username">Username</label> <input
										type="text" name="id" value="tjenyns3" placeholder="Username..."
										class="form-username form-control" id="form-username">
								</div>
								<div class="form-group">
									<label class="sr-only" for="form-password">Password</label> <input
										type="password" name="pwd" placeholder="Password..."
										class="form-password form-control" value="qc263pEL9" id="form-password">
								</div>
								<button type="submit" class="btn">로그인</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Javascript -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
		integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery-backstretch/2.0.4/jquery.backstretch.min.js"></script>
	<script src="static/js/login.js"></script>

	<script type="text/javascript">
		function doAuth() {
			let userId = $("#username").val();
			let userPwd = $("#password").val();

			let userData = new Object();

			userData.id = userId;
			userData.pwd = userPwd;

			$("#submit").on("click", function() {
				$.ajax({
					url : "/authenticate.do",
					type : "post",
					contentType : "application/json",
					data : JSON.stringify(userData),
					success : function(res, status, xhr) {

					},
					error : function(e) {
						console.log(e);
					}
				})
			})
		}
	</script>
</body>
</html>