<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<title>Document</title>
<!-- JQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- BootStrap -->
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
	integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">

<base href="/">
<link rel="stylesheet" href="/static/css/login.css">
</head>
<body> 
	<!-- Main Content -->
	<div class="container-fluid">
		<div class="row main-content bg-success text-center">
			<div class="col-md-4 text-center company__info">
				<span class="company__logo"><h2>
						<span class="fa fa-android"></span>
					</h2></span>
				<h4 class="company_title">Your Company Logo</h4>
			</div>
			<div class="col-md-8 col-xs-12 col-sm-12 login_form text-center">
				<div class="container-fluid text-center">
					<div class="row text-center">
						<h2>Log In</h2>
					</div>
					<div class="row text-center">
						<form action="<c:url value = "/authenticate.do"/>" class="form-group" method="post">
							<div class="row">
								<input type="text" name="id" value = "tjenyns3"
									class="form__input" placeholder="Username">
							</div>
							<div class="row">
								<!-- <span class="fa fa-lock"></span> -->
								<input type="password" name="pwd" value= "qc263pEL9"
									class="form__input" placeholder="Password">
							</div>
							<div class="row">
								<input type="checkbox" name="remember_me" id="remember_me"
									class=""> <label for="remember_me">비밀번호 저장</label>
							</div>
							<div class="row">
								<input id="submit" type="submit" value="Submit" class="btn">
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>