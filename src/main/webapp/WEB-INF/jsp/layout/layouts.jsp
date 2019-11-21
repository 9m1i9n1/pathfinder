<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> 
<%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

  <c:import url="/WEB-INF/jsp/layout/header.jsp" />

  <body class="hold-transition sidebar-mini layout-fixed layout-navbar-fixed">
    <div class="wrapper">

      <c:import url="/WEB-INF/jsp/layout/nav.jsp" />
      <c:import url="/WEB-INF/jsp/layout/left.jsp" />

      <div id="layout" class="content-wrapper">
        <c:import url="/WEB-INF/jsp/layout/content.jsp" />
        <c:import url="/WEB-INF/jsp/layout/footer.jsp" />
      </div>

    </div>
  </body>
</html>
