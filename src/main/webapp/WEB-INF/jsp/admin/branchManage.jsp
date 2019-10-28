<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>Document</title>
</head>
<body>
	<h1>Branch</h1>
	
	<br /> 
	<button>지점 추가</button>
	<table border="1">
		<th>번호</th>
		<th>지점명</th>
		<th>지점장</th>
		<th>운반비</th>
		<th>주소</th>
		<th>전화번호</th>
		<th>수정/삭제</th>
		
	<c:forEach items="${initpage}" var="list">
	<tr>
	<td>${list.branchIndex}</td>
	<td>${list.branchName}</td>
	<td> ${list.branchOwner}</td>
	<td> ${list.branchValue}</td>
	<td> ${list.branchAddr}</td>
	<td> ${list.branchPhone}</td> 
	<td> <button>수정</button><button>삭제</button> </td>
	</tr>
	</c:forEach>

	</table>
</body>
</html>