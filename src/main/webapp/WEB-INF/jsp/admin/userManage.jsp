<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
  <head>
    <title>Document</title>
  </head>
  <body>
    <h1>User</h1>

    <button>사용자 추가</button>

    <table border="1">
      <th>번호</th>
      <th>아이디</th>
      <th>이름</th>
      <th>이메일</th>
      <th>전화번호</th>
      <th>지점</th>
      <th>직책</th>
      <th>초기화/삭제</th>

      <c:forEach items="${userList}" var="user">
        <tr>
          <td> ${user.userIndex}</td>
          <td> ${user.userId}</td>
          <td> ${user.userName}</td>
          <td> ${user.userEmail}</td>
          <td> ${user.userPhone}</td>
          <td> ${user.branch.branchName}</td>
          <td> ${user.userPosition}</td>
          <td> <button>초기화</button><button>삭제</button> </td>
        </tr>
      </c:forEach>
    </table>
  </body>
</html>
